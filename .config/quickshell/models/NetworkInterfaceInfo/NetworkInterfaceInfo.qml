import QtQuick
import "../NetworkTypeConstants"

QtObject {
    // Interface name (e.g., wlan0, eth0)
    property string interfaceName: ""
    // Network type enum (WIFI, ETHERNET, OTHERS)
    property int networkType: NetworkTypeConstants._OTHERS

    // Metrics
    property string ip: ""
    property string ssid: ""
    property int signalStrength: 0
    property int frequency: 0
    property int speed: 0
    property string gateway: ""
    property real packetLoss: 0.0
    property real latency: 0.0
    property real upload: 0.0
    property real download: 0.0


    /* onInterfaceChanged: { */
    /*     if (interfaceName.startsWith("wlan") || interfaceName.startsWith("wlp")) { */
    /*         networkType = NetType.WIFI; */
    /*     } else if (interfaceName.startsWith("eth") || interfaceName.startsWith("enp")) { */
    /*         networkType = NetType.ETHERNET; */
    /*     } else { */
    /*         networkType = NetType.OTHERS; */
    /*     } */
    /* } */
}
