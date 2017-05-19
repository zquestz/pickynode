[![Gem Version](https://badge.fury.io/rb/pickynode.svg)](https://badge.fury.io/rb/pickynode) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
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

Add a node type:
```
pickynode --add=USER_AGENT_FILTER
```

Ban a node type:
```
pickynode --ban=USER_AGENT_FILTER
```

Disconnect a node type:

```
pickynode --disconnect=USER_AGENT_FILTER
```

### Help:

```
pickynode v0.0.1
Options:
  -a, --add=<s>           Node type to add
  -b, --ban=<s>           Node type to ban
  -d, --debug             Debug mode
  -o, --output            Output commands
  -i, --disconnect=<s>    Node type to disconnect
  -v, --version           Print version and exit
  -h, --help              Show this message
```

The --add command pulls data from Bitnodes.
