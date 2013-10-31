//
//  UUIDShortenerTests.m
//  UUIDShortenerTests
//
//  Created by kishikawa katsumi on 2013/10/31.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AdSupport/AdSupport.h>
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

#pragma mark - Regular case

- (void)testShortenUUID
{
    NSUUID *UUID = [NSUUID UUID];
    NSString *UUIDString = UUID.UUIDString;
    
    NSString *shortUUIDString = [UUIDShortener shortenUUIDString:UUIDString];
    XCTAssertEqual(shortUUIDString.length, (NSUInteger)26);
    
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, UUIDString);
}

- (void)testShortenUUIDString
{
    NSString *UUIDString = @"D21ACF57-A8BB-488D-B5DD-DEAC94C9A6D1";
    NSString *shortUUIDString = [UUIDShortener shortenUUIDString:UUIDString];
    XCTAssertEqualObjects(shortUUIDString, @"2INM6V5IXNEI3NO532WJJSNG2E");
    
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, UUIDString);
}

- (void)testShortenUUIDStringWithoutDashes
{
    NSString *UUIDString = @"D21ACF57A8BB488DB5DDDEAC94C9A6D1";
    NSString *shortUUIDString = [UUIDShortener shortenUUIDString:UUIDString];
    XCTAssertEqualObjects(shortUUIDString, @"2INM6V5IXNEI3NO532WJJSNG2E");
    
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, @"D21ACF57-A8BB-488D-B5DD-DEAC94C9A6D1");
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

- (void)testVedorIdentifier
{
    NSUUID *identifierForVendor = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *shortUUIDString = identifierForVendor.shortUUIDString;
    XCTAssertEqual(shortUUIDString.length, 26U);
    
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, identifierForVendor.UUIDString);
}

- (void)testAdvertisingIdentifier
{
    NSUUID *advertisingIdentifier = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    
    NSString *shortUUIDString = advertisingIdentifier.shortUUIDString;
    XCTAssertEqual(shortUUIDString.length, 26U);
    
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:shortUUIDString];
    XCTAssertEqualObjects(restoredString, advertisingIdentifier.UUIDString);
}

#pragma mark - Irregular case

- (void)testInvalidUUIDString
{
    NSString *shortUUIDString = [UUIDShortener shortenUUIDString:@"1234567890"];
    XCTAssertNil(shortUUIDString);
}

- (void)testInvalidShortUUIDString
{
    NSString *restoredString = [UUIDShortener UUIDStringFromShortUUIDString:@"2INM6V5IXNEI3NO532WJJSNG2+"];
    XCTAssertNil(restoredString);
}

@end
