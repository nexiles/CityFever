//
//  LocationDetailViewController.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "JSON/JSON.h"
#import "ASIHTTPRequest.h"
#import "NSData+Base64.h"

#import "LocationDetailViewController.h"
#import "LocationModel.h"


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

    // initialize location model
    self.location = [LocationModel initWithJSON: response];

    [self update];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBGS;
}

#pragma mark -
#pragma mark view loading {{{1

- (void)update
{
    if (self.location) {
        self.navigationItem.title = self.location.title;

        // set values
        self.locationTitle.text = self.location.title;
        self.locationDescription.text = self.location.description;

        NSMutableArray *images = [[NSMutableArray alloc] init];
        if ([[[self location] imageData] count]) {
            for (NSData *data in self.location.imageData)
                [images addObject: [UIImage imageWithData: data]];
            [[self locationImage] setAnimationImages: images];
            [[self locationImage] setAnimationDuration: 2.0*[images count]];
            [[self locationImage] startAnimating];
        }
    }
}

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
    self.location = nil;
    [super dealloc];
}


@end
