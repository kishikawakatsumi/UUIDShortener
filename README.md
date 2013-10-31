UUIDShortener
=============

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
