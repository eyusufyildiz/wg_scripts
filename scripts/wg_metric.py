import subprocess
import requests, json
import time

WG_COLLECTOR_SERVER = "starvpnzone.duckdns.org"
WG_COLLECTOR_PORT = 14533
wg_metric = {}
interval = 30
wg_metric["time-interval"] = interval

def local_cmd(cmd):
    #print(">", cmd)
    response = subprocess.check_output(cmd, shell=True).decode("utf-8").strip()
    return response

def server_info(int_name):
    r1 = local_cmd(f"cat /sys/class/net/{int_name}/statistics/rx_bytes")
    t1 = local_cmd(f"cat /sys/class/net/{int_name}/statistics/tx_bytes")    
    time.sleep(interval//2)
    cpu_load = 100 - float( local_cmd("top -bn1 | grep \"Cpu(s)\" | awk -F\",\" '{print $4}' | awk '{print $1}'") )
    mem_load = float( local_cmd("free | grep Mem | awk '{print $3/$2 * 100.0}'") )  
    time.sleep(interval//2)
    r2 = local_cmd(f"cat /sys/class/net/{int_name}/statistics/rx_bytes")
    t2 = local_cmd(f"cat /sys/class/net/{int_name}/statistics/tx_bytes")
    
    tbps = int(t2) - int(t1)
    rbps = int(r2) - int(r1)
    tx = tbps / (131072*interval)
    rx = rbps / (131072*interval)

    wg_metric["server-name"] = local_cmd(f"/usr/bin/hostnamectl hostname")
    wg_metric["cpu-load"] = round(cpu_load, 2)
    wg_metric["mem-load"] = round(mem_load, 2)
    wg_metric[int_name]["tx"] = round(tx, 1)
    wg_metric[int_name]["rx"] = round(rx, 1)

def peers_data(int_name):
    wg_metric[int_name]= {}
    wg_metric[int_name]["peers"] = {}
    wg_show = local_cmd(f"sudo wg show {int_name}")
    lines = list(wg_show.split('\n'))
    cnt = 0

    while cnt < len(lines):
        line = lines[cnt].strip()
        if line.startswith("peer:"):
            peer = line.split("peer:")[1].strip()
            wg_metric[int_name]["peers"][peer] = {}
        elif line.startswith("endpoint:"):
            wg_metric[int_name]["peers"][peer]["endpoint"] = line.split(":")[1].strip()
        elif line.startswith("allowed ips:"):
            wg_metric[int_name]["peers"][peer]["allowed-ips"] = line.split("allowed ips:")[
                1].strip()
        elif line.startswith("latest handshake:"):
            wg_metric[int_name]["peers"][peer]["latest-handshake"] = ''.join(
                line.split("latest handshake:")[1].strip())
        elif line.startswith("transfer:"):
            spline = line.split(" ")
            wg_metric[int_name]["peers"][peer]["transfer"] = ' '.join(spline[1:3])
            wg_metric[int_name]["peers"][peer]["received"] = ' '.join(spline[4:6])
        cnt += 1


def send_metric_data():
    """
    Sends metric data to {WG_COLLECTOR_SERVER}
    """
    
    url = f"http://{WG_COLLECTOR_SERVER}:{WG_COLLECTOR_PORT}"
    print(f"Sending metric data {url}")
    print(wg_metric)
    
    r = requests.post(url, data = json.dumps(wg_metric), headers = {"job-type": "METRIC"}, timeout=6)
    print(r.status_code)
 
peers_data("wg0")
server_info("wg0")
send_metric_data()

