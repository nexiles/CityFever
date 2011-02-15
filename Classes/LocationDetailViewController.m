//
//  LocationDetailViewController.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "LocationDetailViewController.h"


@implementation LocationDetailViewController

#pragma mark -
#pragma mark initializer {{{1

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

#pragma mark -
#pragma mark view loading {{{1

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    DBGS;
    [super viewDidLoad];
    [[self view] setBackgroundColor: [UIColor groupTableViewBackgroundColor]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
