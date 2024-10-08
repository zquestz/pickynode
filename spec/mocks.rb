# frozen_string_literal: true

BLOCKCHAIR_SNAPSHOT = <<~HEREDOC
  {
    "data": {
      "nodes": {
        "88.99.199.87:8333": {
          "version": "\/BitcoinUnlimited:1.0.2(EB16; AD12)\/",
          "country": "US",
          "height": 555417,
          "flags": 37
        },
        "[2a01:e34:ee3a:5730:21f:5bff:fec5:e356]:8333": {
          "version": "\/Satoshi:0.14.0\/",
          "country": "US",
          "height": 555416,
          "flags": 37
        }
      }
    }
  }
HEREDOC

NODE_INFO = <<~HEREDOC
  {
    "version": 1020500,
    "protocolversion": 70012,
    "blocks": 467548,
    "timeoffset": 0,
    "connections": 154,
    "proxy": "",
    "difficulty": 559970892890.8381,
    "testnet": false,
    "paytxfee": 0.00000000,
    "relayfee": 0.00001000,
    "errors": ""
  }
HEREDOC

PEER_INFO = <<~HEREDOC
  [
    {
      "id": 2,
      "addr": "131.114.88.218:33422",
      "addrlocal": "67.188.11.253:8333",
      "services": "0000000000000000",
      "relaytxes": true,
      "lastsend": 1495412829,
      "lastrecv": 1495412825,
      "bytessent": 5200917,
      "bytesrecv": 2044140,
      "conntime": 1495393261,
      "timeoffset": -24,
      "pingtime": 0.369602,
      "minping": 0.210565,
      "version": 70002,
      "subver": "/FirstClient/",
      "inbound": true,
      "startingheight": 435862,
      "banscore": 0,
      "synced_headers": 467515,
      "synced_blocks": -1,
      "inflight": [
      ],
      "whitelisted": false
    },
    {
      "id": 3,
      "addr": "[2a01:e34:ee3a:5730:21f:5bff:fec5:e356]:8333",
      "addrlocal": "[2a01:e34:ee3a:5730:21f:5bff:fec5:e356]:8333",
      "services": "0000000000000005",
      "relaytxes": true,
      "lastsend": 1495412829,
      "lastrecv": 1495412830,
      "bytessent": 10235040,
      "bytesrecv": 2729345,
      "conntime": 1495393262,
      "timeoffset": -11,
      "pingtime": 0.275245,
      "minping": 0.07081899999999999,
      "version": 80002,
      "subver": "/SecondClient/",
      "inbound": false,
      "startingheight": 467483,
      "banscore": 0,
      "synced_headers": 467515,
      "synced_blocks": 467515,
      "inflight": [
      ],
      "whitelisted": false
    }
  ]
HEREDOC
