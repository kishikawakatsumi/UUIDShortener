//
//  UUIDShortener.m
//  UUID-Shortener
//
//  Created by kishikawa katsumi on 2013/10/30.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import "UUIDShortener.h"

@interface NSString (UUIDShortener)

- (BOOL)isUUID;

@end

@implementation NSString (UUIDShortener)

- (BOOL)isUUID
{
    NSRegularExpression *regex;
    NSError *error = nil;
    regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9a-f]{8}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{12}$"
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length)];
    return !error && numberOfMatches == 1;
}

@end

@implementation NSUUID (UUIDShortener)

- (NSString *)shortUUIDString
{
    return [UUIDShortener shortenUUIDString:self.UUIDString];
}

- (id)initWithShortUUIDString:(NSString *)string
{
    NSString *UUIDString = [UUIDShortener UUIDStringFromShortUUIDString:string];
    return [self initWithUUIDString:UUIDString];
}

+ (NSString *)UUIDStringFromShortUUIDString:(NSString *)string
{
    return [UUIDShortener UUIDStringFromShortUUIDString:string];
}

@end

@implementation UUIDShortener

+ (NSString *)shortenUUIDString:(NSString *)string
{
    if (!string.isUUID) {
        return nil;
    }
    
    NSString *hexString = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSData *data = [UUIDShortener dataWithHexString:hexString];
    
    return [self base32EncodingWithData:data];
}

+ (NSString *)UUIDStringFromShortUUIDString:(NSString *)shortUUIDString
{
    if (shortUUIDString.length != 26) {
        return nil;
    }
    
    NSData *data = [UUIDShortener dataWithBase32Encoding:shortUUIDString];
    NSString *hexString = [UUIDShortener hexStringWithData:data];
    
    if (hexString.length != 8 + 4 + 4 + 4 + 12) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@-%@-%@",
            [hexString substringWithRange:NSMakeRange(0, 8)],
            [hexString substringWithRange:NSMakeRange(8, 4)],
            [hexString substringWithRange:NSMakeRange(12, 4)],
            [hexString substringWithRange:NSMakeRange(16, 4)],
            [hexString substringWithRange:NSMakeRange(20, 12)]];
}

#pragma mark -

+ (NSData *)dataWithHexString:(NSString *)hexString
{
    const char *chars = hexString.UTF8String;
    NSUInteger length = hexString.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:length / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    NSUInteger i = 0;
    while (i < length) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}

+ (NSString *)hexStringWithData:(NSData *)data
{
    NSUInteger length = data.length;
    const unsigned char *dataBuffer = data.bytes;
    
    if (length == 0 || !dataBuffer) {
        return nil;
    }
    
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:length * 2];
    for (NSUInteger i = 0; i < length; ++i) {
        [hexString appendString:[NSString stringWithFormat:@"%02lX", (unsigned long)dataBuffer[i]]];
    }
    
    return hexString.copy;
}

+ (NSString *)base32EncodingWithData:(NSData *)data
{
    NSUInteger length = data.length;
    const unsigned char *dataBuffer = data.bytes;
    
    if (length == 0 || !dataBuffer) {
        return nil;
    }
    
    int bufSize = 256;
    char result[bufSize];
    
    NSUInteger count = 0;
    unsigned long buffer = dataBuffer[0];
    int next = 1;
    int bitsLeft = 8;
    while (count < bufSize && (bitsLeft > 0 || next < length)) {
        if (bitsLeft < 5) {
            if (next < length) {
                buffer <<= 8;
                buffer |= dataBuffer[next++] & 0xFF;
                bitsLeft += 8;
            } else {
                int pad = 5 - bitsLeft;
                buffer <<= pad;
                bitsLeft += pad;
            }
        }
        int index = 0x1F & (buffer >> (bitsLeft - 5));
        bitsLeft -= 5;
        result[count++] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"[index];
    }
    if (count < bufSize) {
        result[count] = '\000';
    }
    
    return [NSString stringWithUTF8String:result];
}

+ (NSData *)dataWithBase32Encoding:(NSString *)base32Encoding
{
    int buffer = 0;
    int bitsLeft = 0;
    int count = 0;
    
    const char *chars = base32Encoding.UTF8String;
    
    int bufSize = 256;
    char result[bufSize];
    
    for (const char *ptr = chars; count < bufSize && *ptr; ++ptr) {
        uint8_t ch = *ptr;
        if (ch == ' ' || ch == '\t' || ch == '\r' || ch == '\n' || ch == '-') {
            continue;
        }
        buffer <<= 5;
        
        if (ch == '0') {
            ch = 'O';
        } else if (ch == '1') {
            ch = 'L';
        } else if (ch == '8') {
            ch = 'B';
        }
        
        if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z')) {
            ch = (ch & 0x1F) - 1;
        } else if (ch >= '2' && ch <= '7') {
            ch -= '2' - 26;
        } else {
            return nil;
        }
        
        buffer |= ch;
        bitsLeft += 5;
        if (bitsLeft >= 8) {
            result[count++] = buffer >> (bitsLeft - 8);
            bitsLeft -= 8;
        }
    }
    if (count < bufSize) {
        result[count] = '\000';
    }
    
    return [NSData dataWithBytes:result length:count];
}

@end
