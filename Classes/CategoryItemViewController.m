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

#define BFEVER_URL @"http://localhost:28001"

@synthesize queue;
@synthesize baseURL;

@synthesize categories;
@synthesize locations;


#pragma mark -
#pragma mark network code {{{1

- (void)         enqueueURL:(NSURL *)url
          didFinishSelector:(SEL)finish
            didFailSelector:(SEL)fail
                   userInfo:(NSDictionary *)info
{
    //DBGS;
    //DBG(url);
    //DBG(info);

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector: finish];
    [request setDidFailSelector: fail];
    [request setUserInfo: info];
    [[self queue] addOperation:request];
}

- (void)loadCategoryIndex
{
    DBGS;

    if (!baseURL) {
        [self setBaseURL: [NSURL URLWithString: BFEVER_URL]];
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
                  userInfo: nil];

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
                      userInfo: category];
    }

    //[[self queue] go];

    //[result release];
}

- (void)locationIndexRequestDone:(ASIHTTPRequest *)request
{
    DBGS;
    NSString       *response = [request responseString];
    NSDictionary   *category = [request userInfo];

    NSMutableDictionary *result = [response JSONValue];
    NSArray                *loc = [result objectForKey:@"items"];

    [[self locations] setObject: loc
                         forKey: [category objectForKey: @"title"]];

    [[self tableView] reloadData];
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

    if (!self.locations) {
        [self setLocations: [[[NSMutableDictionary alloc] init] autorelease]];
    }

    if (!self.categories) {
        [self setCategories: [[[NSMutableArray alloc] init] autorelease]];
    }

    [self loadCategoryIndex];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    DBGS;
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    DBGS;
    [super viewDidAppear:animated];
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
    NSArray      *sectionLocations = [[self locations] objectForKey: categoryTitle];
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

    NSDictionary *category = [[self categories] objectAtIndex: [indexPath section]];
    NSString     *categoryTitle = [category objectForKey: @"title"];
    NSArray      *sectionLocations = [[self locations] objectForKey: categoryTitle];
    DBG(sectionLocations);

    NSDictionary *location = [sectionLocations objectAtIndex: [indexPath row]];
    DBG(location);

    [[cell textLabel] setText: [location objectForKey: @"title"]];
    [[cell detailTextLabel] setText: [location objectForKey: @"description"]];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    LocationDetailViewController *detailViewController = [[LocationDetailViewController alloc] init];

    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


#pragma mark -
#pragma mark Memory management {{{1

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    //

    [locations release];
    locations = nil;

    [categories release];
    categories = nil;
}


- (void)dealloc {
    [self setQueue: nil];
    [self setBaseURL: nil];
    [super dealloc];
}


@end

