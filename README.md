Straw, a native/js bridge :oden:

# straw-ios-service-http v0.1.2

[![Build Status](https://travis-ci.org/strawjs/straw-ios-service-http.svg?branch=master)](https://travis-ci.org/strawjs/straw-ios-service-http)

> HTTP service for Straw iOS

# Methods

- get
  - Success Object
    - {String} responseText The response text
    - {Number} statusCode The status code of the response
  - Error Codes:
    - -1: Unknown error occured
    - -1001: Connection timed out
    - -1004: Cannot connect to the host

**Note:** 40x or 50x responses are not an failure as a Straw Method Call. These are success Straw Call with `statusCode` field 40x or 50x.

- post

## not implemented
- head
- options
- put
- delete
