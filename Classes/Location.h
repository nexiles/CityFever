//
//  Location.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject {

    NSString        *uid;
    NSString        *path;

    NSString        *title;
    NSString        *description;

    NSData          *image_data;

}

@property (nonatomic,copy) NSString         *uid;
@property (nonatomic,copy) NSString         *path;
@property (nonatomic,copy) NSString         *title;
@property (nonatomic,copy) NSString         *description;
@property (nonatomic,retain) NSData         *image_data;


- (id)initFromJSON:(NSString *)json;

@end
