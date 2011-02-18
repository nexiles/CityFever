//
//  ImageCache.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "ImageCache.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@implementation ImageCache

@synthesize queue;

- (id)initWithURL:(NSURL *)url andQueue:(ASINetworkQueue *)theQueue
{
    DBGS;
    self = [super init];
    if (self) {
        baseURL = [url retain];
        DBG(url);
        fetching = [[NSMutableArray alloc] init];
        thumbCache = [[NSMutableDictionary alloc] init];
        [self setQueue: theQueue];

        return self;
    }
    return nil;
}

- (UIImage *)imageForPath:(NSString *)path
{
    DBGS;
    DBG(path);
    UIImage *image = nil;
    @synchronized(self) {
        image = [thumbCache objectForKey: path];
        if (!image) {
            if (![fetching containsObject: path]) {
                [fetching addObject: path];
                [self startFetch: path];
            }
        }
    }
    return image;
}

- (void)startFetch:(NSString *)path
{
    DBGS;
    DBG(path);
    NSDictionary *info = [NSDictionary dictionaryWithObject:path forKey:@"path"];
    NSURL         *url = [NSURL URLWithString:path relativeToURL:baseURL];

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate: self];
    [request setDidFinishSelector: @selector(finishedFetch:)];
    [request setDidFailSelector: @selector(failedFetch:)];
    [request setUserInfo: info];


    [[self queue] addOperation:request];
}

-(void)finishedFetch:(ASIHTTPRequest *)request
{
    DBGS;
    NSData *data = [request responseData];
    NSString * path = [[request userInfo] objectForKey:@"path"];
    DBG(path);
    @synchronized(self) {
        [thumbCache setObject:[UIImage imageWithData:data]
                       forKey:path];
        [fetching removeObject:path];
    }
}

- (void)failedFetch:(ASIHTTPRequest *)request
{
    DBGS;
    NSString *path = [[request userInfo] objectForKey:@"path"];
    NSLog(@"url=%@", [request url]);
    DBG(path);
}

-(void)flush
{
    DBGS;
    @synchronized(self) {
        // flush cache
        [fetching removeAllObjects];
        [thumbCache removeAllObjects];
    }
}

-(void)dealloc
{
    DBGS;
    [self flush];

    [baseURL release];
    [thumbCache release];
    [fetching release];
    [self setQueue: nil];
    [super dealloc];
}

@end
