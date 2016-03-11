//
//  MDBFirebaseReference.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBFirebaseReference.h"
#import "MDBConstants.h"

@implementation MDBFirebaseReference

+ (instancetype)sharedManager {
    static MDBFirebaseReference *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[MDBFirebaseReference alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _mainAppRef = [[Firebase alloc] initWithUrl:FirebaseAppReferenceURL];
    }
    return self;
}

@end
