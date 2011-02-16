//
//  ModelTests.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 16.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//
//

#import <Foundation/Foundation.h>

#import "JSON/JSON.h"
#import "LocationModel.h"

@interface ModelTests : GHTestCase {}
@end

@implementation ModelTests

- (void)testLocationModelInitalizer
{
    id location = [LocationModel initFromJSON:nil];
    GHAssertNotNil(location, @"LocationModel initializer returns nil.");
}

@end
