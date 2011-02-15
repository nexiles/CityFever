//
//  LocationDetailViewController.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface LocationDetailViewController : UIViewController {
    IBOutlet UILabel         *locationTitle;
    IBOutlet UILabel         *locationDescription;
    IBOutlet UIImageView     *locationImage;

    NSMutableDictionary      *location;
}

@property (retain) NSMutableDictionary *location;;

@property (retain) UILabel             *locationTitle;
@property (retain) UILabel             *locationDescription;
@property (retain) UIImageView         *locationImage;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

@end
