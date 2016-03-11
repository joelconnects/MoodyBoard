//
//  Firebase+References.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "Firebase+References.h"
#import "MDBConstants.h"

@implementation Firebase (References)


+(Firebase *)appReferenceURL
{
    static Firebase *ref;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            ref = [[Firebase alloc] initWithUrl:FirebaseAppReferenceURL];
    });
    return ref;
}

@end
