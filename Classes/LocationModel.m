//
//  LocationModel.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 16.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "LocationModel.h"
#import "JSON/JSON.h"
#import "NSData+Base64.h"

@implementation LocationModel

@synthesize uid;
@synthesize path;
@synthesize title;
@synthesize description;
@synthesize imageData;

+ (id)initWithJSON:(NSString *)json
{
    DBGS;
    LocationModel *model = [[super alloc] initWithJSON: json];
    return model;
}

- (id)initWithJSON:(NSString *)json
{
    DBGS;
    self = [super init];
    if (self) {
        if (json) {
            DBG(json);
            NSDictionary *loc = [json JSONValue];

            self.uid = [loc objectForKey: @"uid"];
            self.path = [loc objectForKey: @"path"];
            self.title = [loc objectForKey: @"title"];
            self.description = [loc objectForKey: @"description"];

            NSMutableArray *images = [[NSMutableArray alloc] init];
            for (NSDictionary *pic in [loc objectForKey: @"pictures"]) {
                NSString *s = [pic objectForKey: @"image"];
                NSData *data = [NSData dataFromBase64String: s];
                [images addObject: data];
            }

            self.imageData = images;
        }
        return self;
    }

    return nil;
}

-(void)dealloc
{
    DBGS;

    self.uid = nil;
    self.path = nil;
    self.title = nil;
    self.description = nil;
    self.imageData = nil;

    [super dealloc];
}

@end
