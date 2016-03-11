//
//  MDBFirebaseAPIclient.h
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDBFirebaseAPIclient : NSObject

+(void)createUserWithCompletion:(NSString *)user
                       password:(NSString *)password
                     completion:(void (^)(BOOL success))completionBlock;

+(void)loginUserWithCompletion:(NSString *)user
                      password:(NSString *)password
                    completion:(void (^)(BOOL success))completionBlock;

+(void)changeEmailForUserWithCompletion:(NSString *)user
                               password:(NSString *)password
                               newEmail:(NSString *)newEmail
                             completion:(void (^)(BOOL success))completionBlock;

@end


