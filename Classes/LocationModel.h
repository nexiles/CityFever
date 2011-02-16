//
//  LocationModel.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 16.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocationModel : NSObject {
    NSString        *uid;
    NSString        *path;

    NSString        *title;
    NSString        *description;

    NSArray         *imageData;
}

@property (nonatomic,retain) NSString         *uid;
@property (nonatomic,retain) NSString         *path;
@property (nonatomic,retain) NSString         *title;
@property (nonatomic,retain) NSString         *description;
@property (nonatomic,retain) NSArray          *imageData;

+ (id)initWithJSON:(NSString *)json;
- (id)initWithJSON:(NSString *)json;

@end
