//
//  MDBFirebaseReference.h
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Firebase.h"

@interface MDBFirebaseReference : NSObject

@property (nonatomic, strong) Firebase *mainAppRef;

+ (instancetype)sharedManager;

@end
