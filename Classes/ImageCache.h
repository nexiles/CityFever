//
//  ImageCache.h
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASINetworkQueue.h"

@class ImageCache;

@protocol ImageCacheDelegate<NSObject>
-(void)cacheUpdated:(ImageCache *)cache withPath:(NSString *)path;
@end

@interface ImageCache : NSObject {
    ASINetworkQueue     *queue;
    NSMutableDictionary *thumbCache;
    NSMutableArray      *fetching;

    NSURL               *baseURL;

    id<ImageCacheDelegate>  delegate;
}

@property (retain)   ASINetworkQueue *queue;
@property (retain)   id delegate;

- (id)initWithURL:(NSURL *)url andQueue:(ASINetworkQueue *)queue;
-(UIImage *)imageForPath:(NSString *)path;
-(void)flush;

-(void)startFetch:(NSString *)path;


@end
