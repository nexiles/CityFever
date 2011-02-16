//
//  ModelTests.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 16.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//
//

#import <Foundation/Foundation.h>

#import "LocationModel.h"

@interface ModelTests : GHTestCase {}
@end

@implementation ModelTests

- (void)testLocationModelInitalizer
{
    id location = [LocationModel initWithJSON:nil];
    GHAssertNotNil(location, @"LocationModel initializer returns nil.");
}

- (void)testLocationInitzWithJSON
{
    NSString *json = @" \
        { \
         \"uid\": \"abc12345\",  \
         \"title\": \"title\",  \
         \"description\": \"desc\",  \
         \"path\": \"/some/path\",  \
         \"pictures\": [ \
          { \
           \"image\": \"aGFsbG8=\" \
          }, \
          { \
           \"image\": \"aHVodQ==\" \
          }] \
        } \
    ";

    LocationModel *l = [LocationModel initWithJSON: json];
    GHAssertNotNil(l, @"LocationModel initializer returns nil.");

    GHAssertEqualStrings(l.title, @"title", @"Title not correct");
    GHAssertEqualStrings(l.description, @"desc", @"Description not correct");
    GHAssertEqualStrings(l.path, @"/some/path", @"Path not correct");
    GHAssertTrue([[l imageData] count] == 2, @"Image data conversion fishy");
}
@end
