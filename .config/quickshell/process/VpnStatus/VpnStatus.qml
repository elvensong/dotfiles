// Time.qml

// with this line our type becomes a Singleton
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../../models/VpnInfo"

// your singletons should always have Singleton as the type
Singleton {
	id: root
	property alias vpnInfo: vpnInfo

	VpnInfo {
		id: vpnInfo
	}

  Process {
    id: process
    command: ["nxcli", "status"]

    stdout: StdioCollector {
		onStreamFinished: {
			const output = this.text
			//console.log("VpnStatus:" + (output.indexOf("NetExtender is disconnected.") != -1));
			if (output.indexOf("NetExtender is disconnected.") != -1) {
				vpnInfo.status = "disconnected";
			} else {
				vpnInfo.status = "connected";
			}
			//console.log("vpn status:" + vpnInfo.status);

			vpnInfo.server       = matchKeyValue("Server");
            vpnInfo.protocol     = matchKeyValue("Protocol");
            vpnInfo.ip         = matchKeyValue("IPv4 Address");
            vpnInfo.routes   = matchKeyValue("IPv4 Routes").split(",");
            vpnInfo.dns          = matchKeyValue("DNS").split(",");
            vpnInfo.dnsSuffix    = matchKeyValue("DNS Suffix");
            vpnInfo.throughput   = matchKeyValue("Throughput");
            vpnInfo.connected    = matchKeyValue("Connected");

			function matchKeyValue(key) {
                const re = new RegExp(key + "\\s*:\\s*(.*)", "i");
                const match = output.match(re);
                return match ? match[1].trim() : "";
            }
		}
    }
  }

	/* Timer { */
	/* 	interval: 5000 */
	/* 	running: true */
	/* 	repeat: true */
	/* 	onTriggered: { */
	/* 		//console.log("run vpnStatus"); */
	/* 		process.running = false */
	/* 		process.running = true */
	/* 	} */
	/* } */

	function trigger() {
		console.log("Trigger VpnStatus proc")
		process.running = false
		process.running = true
	}
}
