UUIDShortener
=============

Convert UUID 32-character hex string into a Base32 short string and back.


### Usage
```objc
NSUUID *UUID = [NSUUID UUID];
NSString *UUIDString = UUID.UUIDString;
NSLog(@"Original UUID:\t%@", UUIDString);

NSString *shortUUIDString = UUID.shortUUIDString;
NSLog(@"Short UUID:\t%@", shortUUIDString);

NSLog(@"%@", @"=====");
NSString *restoredString = [NSUUID UUIDStringFromShortUUIDString:shortUUIDString];
NSLog(@"Restored UUID:\t%@", restoredString);
```


```
Original UUID:	40256F2F-3211-49CD-BC1F-DD5197D2F0F9
Short UUID:	IASW6LZSCFE43PA73VIZPUXQ7E

=====
Restored UUID:	40256F2F-3211-49CD-BC1F-DD5197D2F0F9
```
