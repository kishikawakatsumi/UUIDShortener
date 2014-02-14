UUID Shortener ![License MIT](https://go-shields.herokuapp.com/license-MIT-yellow.png) 
=============

[![Version](https://cocoapod-badges.herokuapp.com/v/UUIDShortener/badge.png)](https://cocoapod-badges.herokuapp.com/v/UUIDShortener/badge.png)
[![Platform](https://cocoapod-badges.herokuapp.com/p/UUIDShortener/badge.png)](https://cocoapod-badges.herokuapp.com/p/UUIDShortener/badge.png)
[![Build Status](https://travis-ci.org/kishikawakatsumi/UUIDShortener.png?branch=master)](https://travis-ci.org/kishikawakatsumi/UUIDShortener)
[![Analytics](https://ga-beacon.appspot.com/UA-4291014-9/UUIDShortener/README.md)](https://github.com/igrigorik/ga-beacon)

Convert UUID 32-character hex string into a Base32 short string and back.


### Usage
#### Generate new UUID
```objc
/* Generate UUID */
NSUUID *UUID = [NSUUID UUID];
NSString *UUIDString = UUID.UUIDString;
NSLog(@"Original UUID:\t%@", UUIDString);
// => Original UUID:	40256F2F-3211-49CD-BC1F-DD5197D2F0F9
```

#### Compressing UUID
```objc
/* Shorten UUID string */
NSString *shortUUIDString = UUID.shortUUIDString;
NSLog(@"Short UUID:\t%@", shortUUIDString);
// => Short UUID:	    IASW6LZSCFE43PA73VIZPUXQ7E
```

#### Restore original UUID from compact representaion
```objc
/* Restore UUID string from short string */
NSString *restoredString = [NSUUID UUIDStringFromShortUUIDString:shortUUIDString];
NSLog(@"Restored UUID:\t%@", restoredString);
// => Restored UUID:	40256F2F-3211-49CD-BC1F-DD5197D2F0F9
```

## Installation
### CocoaPods
`pod 'UUIDShortener'`

### Manual Install
- Copy files in Lib (`UUIDShortener.h` and `UUIDShortener.m`) to your project.

## License
MIT License


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/kishikawakatsumi/uuidshortener/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

