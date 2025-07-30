// File: modules/Internet/InternetStatus.qml
//pragma Singleton
import Quickshell.Io
import QtQuick
import "../../models/NetworkTypeConstants" as NetType
import "../../models/NetworkInterfaceInfo"

Item {
    id: netStatus

	property alias wifi: wifi
	property alias ethernet: ethernet

	NetworkInterfaceInfo {
		id: wifi
		interfaceName: "wlp0s20f3"
	}

	NetworkInterfaceInfo {
		id: ethernet
		interfaceName: "enp0s31f6"
	}


    property string dnsServer: ""
    property bool online: false

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
			//getInfoWifi.running = false
			getInfoWifi.running = true
		}
    }

	/*
    Process {
        id: proc
		stdout: StdioCollector {
			onStreamFinished: {
				const output = stdout.trim();
				const hasWifi = output.indexOf("[WIFI] inet") !== -1;
				const hasEth = output.indexOf("[ETH] inet") !== -1;

				netStatus.online = hasWifi || hasEth;

				const activeMatch = output.match(/inet (\d+\.\d+\.\d+\.\d+)/);
				if (activeMatch)
					netStatus.ip = activeMatch[1];

				const ethMatch = output.match(/\[ETH\][\s\S]*?inet (\d+\.\d+\.\d+\.\d+)/);
				if (ethMatch)
					ethernet.ip = ethMatch[1];

				if (hasWifi) {
					const wifiMatch = output.match(/\[WIFI\][\s\S]*?inet (\d+\.\d+\.\d+\.\d+)/);
					if (wifiMatch) wifi.ip = wifiMatch[1];

					const signal = output.match(/signal:\s*(\d+)/);
					if (signal) wifi.signalStrength = parseInt(signal[1]);

					const freq = output.match(/Frequency[:=]\s*(\d+\.\d+)/);
					if (freq) wifi.frequency = parseFloat(freq[1]) * 1000;

					const speed = output.match(/Bit Rate[:=]\s*(\d+\.?\d*)\s*Mb\/s/);
					if (speed) wifi.speed = parseFloat(speed[1]);

					const gw = output.match(/\[WIFI\][\s\S]*?default via (\d+\.\d+\.\d+\.\d+)/);
					if (gw) wifi.gateway = gw[1];

					const loss = output.match(/\[WIFI_PING\][\s\S]*?(\d+(\.\d+)?)% packet loss/);
					if (loss) wifi.packetLoss = parseFloat(loss[1]);

					const latency = output.match(/\[WIFI_PING\][\s\S]*?min\/avg\/max.*?= .*?\/([\d\.]+)\//);
					if (latency) wifi.latency = parseFloat(latency[1]);
				}

				const ethSpeed = output.match(/\[ETH\][\s\S]*?speed (\d+)Mb\/s/);
				if (ethSpeed) ethernet.speed = parseInt(ethSpeed[1]);

				const gwEth = output.match(/\[ETH\][\s\S]*?default via (\d+\.\d+\.\d+\.\d+)/);
				if (gwEth) ethernet.gateway = gwEth[1];

				const lossEth = output.match(/\[ETH_PING\][\s\S]*?(\d+(\.\d+)?)% packet loss/);
				if (lossEth) ethernet.packetLoss = parseFloat(lossEth[1]);

				const latencyEth = output.match(/\[ETH_PING\][\s\S]*?min\/avg\/max.*?= .*?\/([\d\.]+)\//);
				if (latencyEth) ethernet.latency = parseFloat(latencyEth[1]);

				const dnsMatch = output.match(/\[DNS\][\s\S]*?nameserver (\d+\.\d+\.\d+\.\d+)/);
				if (dnsMatch) netStatus.dnsServer = dnsMatch[1];
			}
		}
    }
    */


	/*
	Process {
		id: getIpWifi
		command: [ "ip", "addr", "show", "dev", ${wifi.interfaceName} ]
		stdout: StdioCollector {
			onStreamFinished: {
				const output = this.text.trim();
				netStatus.online = output.indexOf("inet") !== -1;
				wifi.ip = output.match(/inet (\d+\.\d+\.\d+\.\d+)/);
			}
		}
	}
	*/

	Process {
		id:getInfoWifi
		command: ["wpa_cli", "-i", wifi.interfaceName, "status"]
		stdout: StdioCollector {
			onStreamFinished: {
				const output = this.text.trim();
				//console.log("getInfoWifi result:" + output);

				const ip = output.match(/ip_address=([\d\.]+)/);
				if (ip) {
					//console.log("ip result:" + ip[1]);
					netStatus.online = true;
					wifi.ip = ip[1];


					const ssid = output.match(/^ssid=([^\n\r]+)/m);
					if (ssid) {
						//console.log("ssid result:" + ssid[0]);
						wifi.ssid = ssid[1];
					}
				}


				//console.log("wifi item: " + wifi.ssid)
			}
		}
		onExited: {
			this.running = false
		}
	}

	/*
    function checkConnection() {
        const cmd = `
            echo "[WIFI]" && ip addr show ${wifi.interface} && fig ${wifi.interface} && ip route;
            echo "[WIFI_PING]" && ping -c 3 -I ${wifi.interface} 8.8.8.8;
            echo "[ETH]" && ip addr show ${ethernet.interface} && ethtool ${ethernet.interface} 2>/dev/null && ip route;
            echo "[ETH_PING]" && ping -c 3 -I ${ethernet.interface} 8.8.8.8;
            echo "[DNS]" && cat /etc/resolv.conf;
        `;
    }
    */
}
