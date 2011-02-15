//
//  LocationDetailViewController.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LocationDetailViewController : UIViewController {
    IBOutlet UILabel         *locationTitle;
    IBOutlet UILabel         *locationDescription;
    IBOutlet UIImageView     *locationImage;
}

@end
