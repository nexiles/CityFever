//
//  CategoryItemViewController.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "CategoryItemViewController.h"
#import "LocationDetailViewController.h"

#import "JSON/JSON.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"


@implementation CategoryItemViewController

#define BFEVER_URL @"http://192.168.1.10:28001"

@synthesize queue;
@synthesize baseURL;

@synthesize categories;
@synthesize locationIndex;


#pragma mark -
#pragma mark network code {{{1

- (void)         enqueueURL:(NSURL *)url
          didFinishSelector:(SEL)finish
            didFailSelector:(SEL)fail
                   userInfo:(NSDictionary *)info
                   delegate:(id)delegate
{
    //DBGS;
    DBG(url);
    //DBG(info);

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

    if (!baseURL) {
        NSString *base_url = [[NSUserDefaults standardUserDefaults] stringForKey:@"base_url"];
        if (!base_url) {
            NSLog(@"ugh, can't get the 'base_url' defaults ... using hard-coded value.");
            base_url = BFEVER_URL;
        }
        [self setBaseURL: [NSURL URLWithString: base_url]];
    }

    if (![self queue]) {
        [self setQueue:[[[ASINetworkQueue alloc] init] autorelease]];
    }

    NSURL *url = [NSURL URLWithString:@"/en/index.json"
                        relativeToURL:baseURL];
    DBG(url);

    [self       enqueueURL: url
         didFinishSelector: @selector(categoryIndexRequestDone:)
           didFailSelector: @selector(requestFailed:)
                  userInfo: nil
                  delegate: self];

    [[self queue] go];
}

- (void)categoryIndexRequestDone:(ASIHTTPRequest *)request
{
    DBGS;
    NSString *response = [request responseString];
    NSMutableDictionary *result = [response JSONValue];

    self.categories = [result objectForKey:@"items"];
    DBG(self.categories);

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

- (void)fetchThumbImage:(NSString *)path
{
    DBG(path);

    NSURL *url = [NSURL URLWithString:path
                        relativeToURL:baseURL];
    NSDictionary *info = [NSDictionary dictionaryWithObject:path forKey:@"path"];

    [self       enqueueURL: url
         didFinishSelector: @selector(thumbFetchFinished:)
           didFailSelector: @selector(requestFailed:)
                  userInfo: nil
                  delegate: self];

    [info release];
}

- (void)thumbFetchFinished:(ASIHTTPRequest *)request
{
    DBGS;
    NSDictionary   *info = [request userInfo];
    NSData         *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];

    @synchronized(self) {
        [[self cache] setObject: data
                         forKey: [info objectForKey:@"path"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBGS;
}



#pragma mark -
#pragma mark View lifecycle {{{1

- (void)viewDidLoad {
    DBGS;
    [super viewDidLoad];

    if (!self.locationIndex) {
        [self setLocationIndex: [[[NSMutableDictionary alloc] init] autorelease]];
    }

    if (!self.categories) {
        [self setCategories: [[[NSMutableArray alloc] init] autorelease]];
    }

    //if (!self.locations) {
        //[self setLocations: [[[NSMutableDictionary alloc] init] autorelease]];
    //}

    [self loadCategoryIndex];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //
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
    //[self setLocations: nil];
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
#pragma mark Table view data source {{{1

-(NSDictionary *)locationForIndexPath:(NSIndexPath *)indexPath
{
    DBGS;

    NSDictionary *category = [[self categories] objectAtIndex: [indexPath section]];
    NSString     *categoryTitle = [category objectForKey: @"title"];
    NSArray      *sectionLocations = [[self locationIndex] objectForKey: categoryTitle];
    //DBG(sectionLocations);

    NSDictionary *location = [sectionLocations objectAtIndex: [indexPath row]];
    //DBG(location);

    return location;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
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
    //DBG(location);

    // XXX: caching!
    NSString *thumb = [location objectForKey:@"thumb"];
    NSData *thumbData = [[self thumbCache] objectForKey: thumb];
    if (thumbData) {
        UIImage *img = [UIImage imageWithData: thumbData];
        [[cell imageView] setImage: img];
    } else {
        [self fetchThumbImage: thumb];
    }

    [[cell textLabel] setText: [location objectForKey: @"title"]];
    [[cell detailTextLabel] setText: [location objectForKey: @"description"]];

    //[thumbData release];
    //[img release];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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
    DBG(location);
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
    [self setQueue: nil];
    [self setBaseURL: nil];
    [super dealloc];
}


@end

