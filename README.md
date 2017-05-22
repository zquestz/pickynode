[![Gem Version](https://badge.fury.io/rb/pickynode.svg)](https://badge.fury.io/rb/pickynode) [![Build Status](https://travis-ci.org/zquestz/pickynode.svg)](https://travis-ci.org/zquestz/pickynode) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
# pickynode

Some people are picky about the bitcoin nodes they connect to.

### Requirements:

You need a working full node on your machine. The `bitcoin-cli` command should be functional.

### Installation:

```
gem install pickynode
```

### Usage:

Display list of currently connected nodes:

```
pickynode
```

Add node type:
```
pickynode --add=USER_AGENT_FILTER
```

Ban node type:
```
pickynode --ban=USER_AGENT_FILTER
```

Connect to node type:
```
pickynode --connect=USER_AGENT_FILTER
```

Disconnect from node type:

```
pickynode --disconnect=USER_AGENT_FILTER
```

### Help:

```
pickynode v0.1.1
Options:
  -a, --add=<s>           Add node type
  -c, --connect=<s>       Connect to node type
  -b, --ban=<s>           Ban node type
  -d, --debug             Debug mode
  -o, --output            Output commands
  -i, --disconnect=<s>    Disconnect from node type
  -v, --version           Print version and exit
  -h, --help              Show this message

```

The --add and --connect commands pull data from Bitnodes.
