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

    ASINetworkQueue     *queue;
    NSMutableDictionary *locationIndex;
    NSMutableArray      *categories;
    NSURL               *baseURL;

    NSMutableDictionary *thumbCache;
}

@property (retain) ASINetworkQueue                  *queue;
@property (retain) NSURL                            *baseURL;
@property (retain) NSMutableArray                   *categories;
@property (retain) NSMutableDictionary              *locationIndex;

@end
