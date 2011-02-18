//
//  CategoryItemViewController.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"
#import "ASINetworkQueue.h"

@interface CategoryItemViewController : UITableViewController <ImageCacheDelegate> {

    NSMutableDictionary *locationIndex;
    NSMutableArray      *categories;
    NSURL               *baseURL;

    ImageCache          *thumbCache;

}

@property (retain) NSURL                            *baseURL;
@property (retain) NSMutableArray                   *categories;
@property (retain) NSMutableDictionary              *locationIndex;

- (ASINetworkQueue *)queue;

-(void)cacheUpdated:(ImageCache *)cache withPath:(NSString *)path;

@end
