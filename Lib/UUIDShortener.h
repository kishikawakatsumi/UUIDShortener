//
//  UUIDShortener.h
//  UUID-Shortener
//
//  Created by kishikawa katsumi on 2013/10/30.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUIDShortener : NSObject

+ (NSString *)shortenUUIDString:(NSString *)UUIDString;
+ (NSString *)UUIDStringFromShortUUIDString:(NSString *)shortUUIDString;

@end

@interface NSUUID (UUIDShortener)

- (NSString *)shortUUIDString;
+ (NSString *)UUIDStringFromShortUUIDString:(NSString *)shortUUIDString;

@end
