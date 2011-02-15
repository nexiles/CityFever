//
//  Location.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "Location.h"

@implementation Location

@synthesize uid;
@synthesize path;
@synthesize title;
@synthesize description;
@synthesize image_data;

- (id)initFromJSON:(NSString *)json
{
    DBGS;
    DBG(json);

    self = [super init];
    if (!self) {
        return nil;
    }

    return self;
}

@end
