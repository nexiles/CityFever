/*
 *  debug.h
 *  DegDazePhone
 *
 *  Created by Stephan Eletzhofer on 21.10.10.
 *  Copyright 2010 Nexiles. All rights reserved.
 *
 */

#define DBGS   NSLog(@"%s start", __FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __FUNCTION__, #x, x)

#define RELEASE(x) [x release]; x = nil


