# Yanic
```
__   __          _
\ \ / /_ _ _ __ (_) ___
 \ V / _` | '_ \| |/ __|
  | | (_| | | | | | (__
  |_|\__,_|_| |_|_|\___|
Yet another node info collector
```

[![CircleCI](https://circleci.com/gh/FreifunkBremen/yanic/tree/master.svg?style=shield)](https://circleci.com/gh/FreifunkBremen/yanic/tree/master)
[![Coverage Status](https://coveralls.io/repos/github/FreifunkBremen/yanic/badge.svg?branch=master)](https://coveralls.io/github/FreifunkBremen/yanic?branch=master)
[![codecov](https://codecov.io/gh/FreifunkBremen/yanic/branch/master/graph/badge.svg)](https://codecov.io/gh/FreifunkBremen/yanic)
[![Go Report Card](https://goreportcard.com/badge/github.com/FreifunkBremen/yanic)](https://goreportcard.com/report/github.com/FreifunkBremen/yanic)

`yanic` is a respondd client that fetches, stores and publishes information about a Freifunk network. The goals:
* Generating JSON for [Meshviewer](https://github.com/ffrgb/meshviewer)
* Storing statistics in [InfluxDB](https://influxdata.com/) or [Graphite](https://graphiteapp.org/) to be analyzed by [Grafana](http://grafana.org/)
* Provide a little webserver for a standalone installation with a meshviewer

## How it works
In the first step Yanic sends a multicast message to the group `ff05::2:1001` and port `1001`.
Recently seen nodes that does not reply are requested via a unicast message.

## Documentation
Take a look at the [git](https://github.com/FreifunkBremen/yanic/blob/master/SUMMARY.md) or [Gitbook](https://freifunkbremen.gitbooks.io/yanic/content/)

# Installation
Take a look into the Documentation (see above) or for Quick Overview in [INSTALL.md](INSTALL.md).

If you like Docker you may want to take a look [here](https://github.com/christf/docker-yanic).

## Configuration
Read comments in [config_example.toml](config_example.toml) for more information.

## Running
Yanic provides several commands:

### Usage
Run Yanic without any arguments to get the usage information:
```
Usage:
  yanic [command]

Available Commands:
  help        Help about any command
  import      Imports global statistics from the given RRD files, requires InfluxDB
  query       Sends a query on the interface to the destination and waits for a response
  serve       Runs the yanic server

Flags:
  -h, --help              help for yanic
      --loglevel uint32   Show log message starting at level (default 40)
      --timestamps        Enables timestamps for log output

Use "yanic [command] --help" for more information about a command.
```

#### Serve
Runs the yanic server
```
Usage:
  yanic serve [flags]

Examples:
yanic serve --config /etc/yanic.toml

Flags:
  -c, --config string   Path to configuration file (default "config.toml")
  -h, --help            help for serve

Global Flags:
      --loglevel uint32   Show log message starting at level (default 40)
      --timestamps        Enables timestamps for log output
```

#### Query
Sends a query on the interface to the destination and waits for a response
```
Usage:
  yanic query <interfaces> <destination> [flags]

Examples:
yanic query "eth0,wlan0" "fe80::eade:27ff:dead:beef"

Flags:
  -h, --help        help for query
      --ip string   ip address which is used for sending (optional - without definition used the link-local address)
      --port int    define a port to listen (if not set or set to 0 the kernel will use a random free port at its own)
      --wait int    Seconds to wait for a response (default 1)

Global Flags:
      --loglevel uint32   Show log message starting at level (default 40)
      --timestamps        Enables timestamps for log output
```

#### Import
Imports global statistics from the given RRD files (ffmap-backend).
```
Usage:
  yanic import <file.rrd> <site> <domain> [flags]

Examples:
yanic import --config /etc/yanic.toml olddata.rrd global global

Flags:
  -c, --config string   Path to configuration file (default "config.toml")
  -h, --help            help for import

Global Flags:
      --loglevel uint32   Show log message starting at level (default 40)
      --timestamps        Enables timestamps for log output
```



## Communities using Yanic
* **Freifunk Bremen** uses InfluxDB, [Grafana](https://grafana.bremen.freifunk.net), and [Meshviewer](https://map.bremen.freifunk.net) with a patch to show state-version of `nodes.json`. 
* **Freifunk Nord** uses [hopglass](https://github.com/hopglass/hopglass) (commit 587740a) as frontend:  https://mesh.freifunknord.de/
* **Freifunk Kiel** uses [Meshviewer](https://github.com/ffrgb/meshviewer/) as frontend: https://map.freifunk.in-kiel.de/

Do you know someone else using Yanic? Create a [pull request](https://github.com/FreifunkBremen/yanic/issues/new?template=community.md&title=Mention+community+$name)!

## Related projects
Collecting data from respondd:
* [HopGlass Server](https://github.com/plumpudding/hopglass-server) written in Node.js

Respondd for servers:
* [mesh-announce](https://github.com/ffnord/mesh-announce) from ffnord
* [respondd](https://github.com/Sunz3r/ext-respondd) from Sunz3r


## License
This software is licensed under the terms of the [AGPL v3 License](LICENSE).
