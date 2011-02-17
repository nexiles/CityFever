//
//  CityFeverAppDelegate.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"

@interface CityFeverAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow                *window;
    UINavigationController  *navigationController;

    ASINetworkQueue         *queue;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, readonly) ASINetworkQueue *queue;

+ (void)initialize;


@end

