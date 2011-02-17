//
//  CategoryItemViewController.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASINetworkQueue.h"

@interface CategoryItemViewController : UITableViewController {

    NSMutableDictionary *locationIndex;
    NSMutableArray      *categories;
    NSURL               *baseURL;

    NSMutableDictionary *thumbCache;
}

@property (retain) NSURL                            *baseURL;
@property (retain) NSMutableArray                   *categories;
@property (retain) NSMutableDictionary              *locationIndex;
@property (retain) NSMutableDictionary              *thumbCache;

- (ASINetworkQueue *)queue;

@end
