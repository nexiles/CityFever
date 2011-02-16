//
//  SetupTests.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 16.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//


@interface SetupTests : GHTestCase {}
@end


@implementation SetupTests

- (void) testFail
{
    GHAssertEquals(1, 2, @"This should fail");
}

- (void) testPass
{
    GHAssertEquals(1, 1, @"This should pass");
}


@end
