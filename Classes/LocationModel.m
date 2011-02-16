//
//  LocationModel.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 16.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "LocationModel.h"
#import "JSON/JSON.h"

@implementation LocationModel

@synthesize uid;
@synthesize path;
@synthesize title;
@synthesize description;
@synthesize imageData;

+ (id)initFromJSON:(NSString *)json
{
    LocationModel *model = [[super alloc] initFromJSON: json];
    return model;
}

- (id)initFromJSON:(NSString *)json
{
    self = [super init];
    if (self) {
        if (json) {
            NSDictionary *loc = [json JSONValue];

            self.uid = [loc objectForKey: @"uid"];
            self.path = [loc objectForKey: @"path"];
            self.title = [loc objectForKey: @"title"];
            self.description = [loc objectForKey: @"description"];

            NSMutableArray *images = [[NSMutableArray alloc] init];

            self.imageData = images;
        }
        return self;
    }

    return nil;
}

-(void)dealloc
{
    self.uid = nil;
    self.path = nil;
    self.title = nil;
    self.description = nil;
    self.imageData = nil;

    [super dealloc];
}

@end
