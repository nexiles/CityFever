//
//  LocationDetailViewController.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "LocationDetailViewController.h"
#import "JSON/JSON.h"
#import "ASIHTTPRequest.h"

#import "NSData+Base64.h"


@implementation LocationDetailViewController

@synthesize locationTitle;
@synthesize locationDescription;
@synthesize locationImage;

@synthesize location;

#pragma mark -
#pragma mark async loading {{{1
- (void)requestFinished:(ASIHTTPRequest *)request
{
    DBGS;
    NSString       *response = [request responseString];
    NSMutableDictionary *loc = [response JSONValue];

    self.location = loc;

    self.navigationItem.title = [[self location] objectForKey: @"title"];

    // set values
    self.locationTitle.text = [[self location] objectForKey: @"title"];
    self.locationDescription.text = [[self location] objectForKey: @"description"];

    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSArray *pictures = [[self location] objectForKey: @"pictures"];
    for (NSDictionary *pic in pictures) {
        NSData *imageData = [NSData dataFromBase64String: [pic objectForKey: @"image"]];
        [images addObject: [UIImage imageWithData: imageData]];
    }

    if ([images count]) {
        [[self locationImage] setAnimationImages: images];
        [[self locationImage] setAnimationDuration: 2.0*[images count]];
        [[self locationImage] startAnimating];
    }

    //[images release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBGS;
}

#pragma mark -
#pragma mark view loading {{{1

- (void)viewDidLoad
{
    DBGS;
    [super viewDidLoad];
    [[self view] setBackgroundColor: [UIColor groupTableViewBackgroundColor]];

    self.navigationItem.title = @"Loading ...";
}

#pragma mark -
#pragma mark memory management {{{1

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [locationImage release];
    locationImage = nil;

    [locationTitle release];
    locationTitle = nil;

    [locationDescription release];
    locationDescription = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
