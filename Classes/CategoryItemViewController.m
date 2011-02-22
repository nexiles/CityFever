//
//  CategoryItemViewController.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "CityFeverAppDelegate.h"
#import "CategoryItemViewController.h"
#import "LocationDetailViewController.h"

#import "JSON/JSON.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"


@implementation CategoryItemViewController

#define BFEVER_URL @"http://www-berlin-fever.com"

@synthesize baseURL;

@synthesize categories;
@synthesize locationIndex;


-(id)init
{
    [super initWithNibName:@"CategoryItemViewController" bundle:nil];
    return self;
}


#pragma mark -
#pragma mark network code {{{1

- (ASINetworkQueue *)queue
{
    CityFeverAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    return [delegate queue];
}

- (void)         enqueueURL:(NSURL *)url
          didFinishSelector:(SEL)finish
            didFailSelector:(SEL)fail
                   userInfo:(NSDictionary *)info
                   delegate:(id)delegate
{
    DBGS;

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate: delegate];
    [request setDidFinishSelector: finish];
    [request setDidFailSelector: fail];
    [request setUserInfo: info];
    [[self queue] addOperation:request];
}

- (void)loadCategoryIndex
{
    DBGS;
    NSURL *url = [NSURL URLWithString:@"/en/index.json"
                        relativeToURL:baseURL];

    [self       enqueueURL: url
         didFinishSelector: @selector(categoryIndexRequestDone:)
           didFailSelector: @selector(requestFailed:)
                  userInfo: nil
                  delegate: self];
}

- (void)categoryIndexRequestDone:(ASIHTTPRequest *)request
{
    DBGS;
    NSString *response = [request responseString];
    NSMutableDictionary *result = [response JSONValue];

    self.categories = [result objectForKey:@"items"];

    // now load all location indices
    for (NSDictionary *category in [self categories]) {
        NSString *path = [NSString stringWithFormat: @"/en/%@/index.json", [category objectForKey: @"id"]];
        NSURL *url = [NSURL URLWithString:path
                            relativeToURL:baseURL];

        [self       enqueueURL: url
             didFinishSelector: @selector(locationIndexRequestDone:)
               didFailSelector: @selector(requestFailed:)
                      userInfo: category
                      delegate: self];
    }

    [[self tableView] reloadData];
}

- (void)locationIndexRequestDone:(ASIHTTPRequest *)request
{
    DBGS;
    NSString       *response = [request responseString];
    NSDictionary   *category = [request userInfo];

    NSMutableDictionary *result = [response JSONValue];
    NSArray                *loc = [result objectForKey:@"items"];

    [[self locationIndex] setObject: loc
                         forKey: [category objectForKey: @"title"]];

    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark View lifecycle {{{1

- (void)viewDidLoad {
    DBGS;
    [super viewDidLoad];

    if (!baseURL) {
        NSString *base_url = [[NSUserDefaults standardUserDefaults] stringForKey:@"base_url"];
        if (!base_url) {
            NSLog(@"ugh, can't get the 'base_url' defaults ... using hard-coded value.");
            base_url = BFEVER_URL;
        }
        [self setBaseURL: [NSURL URLWithString: base_url]];
    }

    thumbCache = [[ImageCache alloc]
        initWithURL:baseURL
           andQueue:[self queue]];
    [thumbCache setDelegate: self];

    if (!self.locationIndex) {
        [self setLocationIndex: [[[NSMutableDictionary alloc] init] autorelease]];
    }

    if (!self.categories) {
        [self setCategories: [[[NSMutableArray alloc] init] autorelease]];
    }

    [self loadCategoryIndex];

    self.navigationItem.title = @"City Fever";
}

- (void)viewWillAppear:(BOOL)animated {
    DBGS;
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    DBGS;
    [super viewDidAppear:animated];
}

- (void)viewDidUnload {
    DBGS;
    [self setLocationIndex: nil];
    [self setCategories: nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    DBGS;
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    DBGS;
    [super viewDidDisappear:animated];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark ImageCache delegate {{{1

-(void)cacheUpdated:(ImageCache *)cache withPath:(NSString *)path
{
    DBGS;
    [[self tableView] reloadData];
}


#pragma mark -
#pragma mark Table view data source {{{1

-(NSDictionary *)locationForIndexPath:(NSIndexPath *)indexPath
{
    DBGS;

    NSDictionary *category = [[self categories] objectAtIndex: [indexPath section]];
    NSString     *categoryTitle = [category objectForKey: @"title"];
    NSArray      *sectionLocations = [[self locationIndex] objectForKey: categoryTitle];

    NSDictionary *location = [sectionLocations objectAtIndex: [indexPath row]];

    return location;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self categories] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // The header for the section is the region name -- get this from the region at the section index.
    NSDictionary *category = [[self categories] objectAtIndex: section];
    return [category objectForKey: @"title"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    DBGS;
    NSDictionary *category = [[self categories] objectAtIndex: section];
    NSString     *categoryTitle = [category objectForKey: @"title"];
    NSArray      *sectionLocations = [[self locationIndex] objectForKey: categoryTitle];
    return [sectionLocations count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBGS;
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
    }

    NSDictionary *location = [self locationForIndexPath: indexPath];
    NSString *path = [location objectForKey:@"thumb"];
    if ((NSNull *)path != [NSNull null]) {
        UIImage *img = [thumbCache imageForPath: path];
        [[cell imageView] setImage: img];
    } else {
        [[cell imageView] setImage: nil];
    }

    [[cell textLabel] setText: [location objectForKey: @"title"]];
    [[cell detailTextLabel] setText: [location objectForKey: @"description"]];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate {{{1

- (void) loadLocation:(NSDictionary *)location
        forController:(LocationDetailViewController *)controller
{
    NSString *path = [NSString stringWithFormat: @"%@/index.json", [location objectForKey: @"path"]];
    NSURL *url = [NSURL URLWithString:path
                        relativeToURL:baseURL];

    [self       enqueueURL: url
         didFinishSelector: @selector(requestFinished:)
           didFailSelector: @selector(requestFailed:)
                  userInfo: location
                  delegate: controller];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    LocationDetailViewController *detailViewController = [[LocationDetailViewController alloc] init];

    // enqueue loading of location details
    NSDictionary *location = [self locationForIndexPath: indexPath];
    [self loadLocation: location forController: detailViewController];


    // push view to navigation controller
    [self.navigationController
        pushViewController:detailViewController
                  animated:YES];
    [detailViewController release];
}


#pragma mark -
#pragma mark Memory management {{{1

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    DBGS;
    [thumbCache release];
    [self setBaseURL: nil];

    [super dealloc];
}

@end
