//
//  UUIDShortenerTests.m
//  UUIDShortenerTests
//
//  Created by kishikawa katsumi on 2013/10/31.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UUIDShortener.h"

@interface UUIDShortenerTests : XCTestCase

@end

@implementation UUIDShortenerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testShortenUUID
{
    NSUUID *UUID = [NSUUID UUID];
    NSString *UUIDString = UUID.UUIDString;
    
    NSString *shortUUIDString = [UUIDShortener shortUUIDString:UUIDString];
    XCTAssertEqual(shortUUIDString.length, (NSUInteger)26);
    
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, UUIDString);
}

- (void)testNSUUIDCategoryMethods
{
    NSUUID *UUID = [NSUUID UUID];
    NSString *UUIDString = UUID.UUIDString;
    
    NSString *shortUUIDString = UUID.shortUUIDString;
    XCTAssertEqual(shortUUIDString.length, (NSUInteger)26);
    
    NSString *restoredString = [NSUUID UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, UUIDString);
}

@end
