[![Gem Version](https://badge.fury.io/rb/pickynode.svg)](https://badge.fury.io/rb/pickynode) [![Build Status](https://app.travis-ci.com/zquestz/pickynode.svg?branch=master&status=passed)](https://app.travis-ci.com/github/zquestz/pickynode) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
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
pickynode v0.2.2
Options:
  -a, --add=<s>           Add node type
  -c, --connect=<s>       Connect to node type
  -b, --ban=<s>           Ban node type
  -d, --debug             Debug mode
  -i, --info              Local node info
  -o, --output            Output commands
  -s, --disconnect=<s>    Disconnect from node type
  -l, --limit=<i>         Limit number of nodes to add/connect
  -t, --ticker=<s>        Currency ticker symbol (BCH/BTC) (default: BCH)
  -v, --version           Print version and exit
  -h, --help              Show this message
```

The --add and --connect commands pull data from the Blockchair API.
