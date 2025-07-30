import QtQuick

QtObject {
	id: root
    // Interface name (e.g., wlan0, eth0)
    property string status: ""
    property string server: ""

	property string protocol: ""

    // Metrics
    property string ip: ""
	property var routes: []
	property string dns: ""
	property string dnsSuffix: ""
	property string throughput: ""
	property string connected: ""

	function toString() {
        return ["status: " + root.status + "\n" +
               "server: " + root.server + "\n" +
               "protocol: " + root.protocol + "\n" +
               "ip: " + root.ip + "\n" +
               "routes: " + root.JSON.stringify(routes) + "\n" +
               "dns: " + root.dns + "\n" +
               "dnsSuffix: " + root.dnsSuffix + "\n" +
               "throughput: " + root.throughput + "\n" +
				"connected: " + root.connected].join("")
    }
}
