# awm-lib-server
The data collection format is designed to allow for bulk uploading of statistics
data. This means the device can store measurements locally and upload them all
at once so that it may collect data while there is no Internet connection.

Full monitoring of relative positions of the observed devices from the
reporting device is possible. The format of the JSON request to upload data
to the collection server is provided below. The awm-lib Android library
makes measurements and either on-demand or periodically uploads the measures
to a server running this software. The server stores the data in a mysql db and
also provides some limited visualisation of this data. The raw data is also
available for analysis and is open source, along with this software.

The idea with this project is that it is a fully-open (both data and source)
alternative to other libraries and apps which provide similar collection of
bandwidth tests and device density, but often do so with closed source, closed
data or entirely closed initiatives.
```
{
  "awm-measure": {
    "reporting_device": {
      "uuid": string,
      "ipv4_address": string,
      "ipv6_address": string,
      "timestamp": string,
      "longitude": string,
      "latitude": string,
      "bt_mac_address": string,
      "wifi_mac_address": string,
      "OS": string,
      "battery_life": string,
      "has_cellular_internet": boolean,
      "has_wifi_internet": boolean,
      "cellular_throughput": string,
      "wifi_throughput": string,
      "cellular_ping": string,
      "wifi_ping": string,
      "cellular_operator": string,
      "cellular_network_type": int
    },
    "devices": [
      { "mac_address": mac_address, "device_type": device_type, "network_name" : network_name },
          ...
      { "mac_address": mac_address, "device_type": device_type, "network_name" : network_name },
    ]
  }
}
```

Here is an example request with values filled in:
```
{
  "awm-measure": {
    "reporting_device": {
      "uuid": "123e4567-e89b-12d3-a456-556642440000",
      "ipv4_address": "97.107.187.21",
      "ipv6_address": "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
      "timestamp": "2016-11-16 06:43:19.77",
      "longitude": "49.2730073",
      "latitude": "-122.7726766",
      "bt_mac_address": "00-14-22-01-23-45",
      "wifi_mac_address": "11-14-22-01-23-45",
      "OS": "android",
      "battery_life": "98.5",
      "has_cellular_internet": false,
      "has_wifi_internet": true,
      "cellular_throughput": 0,
      "wifi_throughput": 1.5,
      "cellular_ping": 0,
      "wifi_ping": 15,
      "cellular_operator": "Rogers",
      "cellular_network_type": 0
    },
    "devices": [
      { "mac_address": "22-14-22-01-23-45", "mac_type": 0, "network_name" : "rtr" },
      { "mac_address": "33-14-22-01-23-45", "mac_type": 1, "network_name" : "jasonbt" }
    ]
  }
}
```


The results are stored in two tables. The first stores the reporting device
along with identifying information such as mac addresses of various interfaces
and IP addresses, along with the location and timestamp. This way the same
reporting device can be tracked even if some of its properties change such as
the ip addresses, so long as something remains the same such as the wifi or bt
mac addresses. In addition to logging the position, we can also log the status
of Internet connectivity from the cellular radio or Wi-Fi, and the battery life
at the given moment in time, however this is still not implemented until the
InternetStatsCollector is completed.

| UUID  | timestamp | bt_mac_address | wifi_mac_address | ipv4_address | ipv6_address | longitude | latitude | OS |
|---|---|---|---|---|---|---|---|---|
|  varchar(36) | timestamp | bigint | bitint | int | bigint | float | float | varchar(255) |

The second table is for the actual measurements themselves. The measurement
references the observed device recorded in previous table so that the timestamp
and GPS co-ordinates are not reproduced all repeatedly. The only thing new
recorded is a list of Wi-Fi or Bluetooth mac addresses which were observed by
the particular observing device at the moment in time. We also capture either
the Wi-Fi SSID if possible or the bluetooth device name.

| id | reporting_device_id | mac_address | mac_type | network_name
|---|---|---|---|---|
| int | int | bigint | tinyint | varchar(255) |

This allows processing later on to be accomplished in time, and filtered by
reporting device if necessary. Observed devices could also be filtered and
tracked which is a bit creepy.
