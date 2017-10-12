UUID [![Swift Version](https://img.shields.io/badge/Swift-4.0-orange.svg)](https://swift.org/download/#snapshots) [![Build Status](https://travis-ci.org/DavidSkrundz/UUID.svg?branch=master)](https://travis-ci.org/DavidSkrundz/UUID) [![Codebeat Status](https://codebeat.co/badges/68c11dd2-40b7-4397-9b27-cbd5f3fd356c)](https://codebeat.co/projects/github-com-davidskrundz-uuid)
====

A Swift implementation of UUID

```Swift
let uuid = UUID(version: .v1)
let uuid = UUID(bytes: [0x12, 0x3E, 0x45, 0x67, 0xE8, 0x9B, 0x12, 0xD3, 0xA4, 0x56, 0x42, 0x66, 0x55, 0x44, 0x00, 0x00])
let uuid = UUID(string: "123e4567-e89b-12d3-a456-426655440000")
```


Prerequisites
-------------

###### Linux
`$ sudo apt-get install libbsd-dev`
