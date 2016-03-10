//
//  MDBPendingOperations.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBPendingOperations.h"

@implementation MDBPendingOperations

-(id)init {
    
    self = [super init];
    
    if (self) {
        _downloadsInProgress = [NSMutableDictionary new];
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.name = @"Download Queue";
    }
    
    return self;
    
}

@end
