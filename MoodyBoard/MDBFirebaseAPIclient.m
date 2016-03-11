//
//  MDBFirebaseAPIclient.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBFirebaseAPIclient.h"
#import "MDBConstants.h"
#import "Firebase.h"
#import "MDBFirebaseReference.h"
#import "Firebase+References.h"

@interface MDBFirebaseAPIclient()

@end

@implementation MDBFirebaseAPIclient

//                                 //
// --------- CREATE USER --------- //
//                                 //
+(void)createUserWithCompletion:(NSString *)user
                       password:(NSString *)password
                     completion:(void (^)(BOOL))completionBlock
{
    [[Firebase appReferenceURL] createUser:user
                                  password:password
                  withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        
        if (error) {
            // There was an error creating the account
            completionBlock(NO);
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
            completionBlock(YES);
        }
    }];
    
}

//                                 //
// --------- LOGIN USER  --------- //
//                                 //
+(void)loginUserWithCompletion:(NSString *)user
                      password:(NSString *)password
                    completion:(void (^)(BOOL))completionBlock
{
    
    [[Firebase appReferenceURL] authUser:user
                                password:password
                     withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            // There was an error logging in to this account
            completionBlock(NO);
        } else {
            // We are now logged in
            completionBlock(YES);
        }
        
    }];
    
    
}

//                                           //
// --------- CHANGE EMAIL FOR USER --------- //
//                                           //
+(void)changeEmailForUserWithCompletion:(NSString *)user
                               password:(NSString *)password
                               newEmail:(NSString *)newEmail
                             completion:(void (^)(BOOL success))completionBlock
{
    [[Firebase appReferenceURL] changeEmailForUser:@"oldemail@firebase.com"
                                          password:@"correcthorsebatterystaple"
                                        toNewEmail:@"newemail@firebase.com"
                               withCompletionBlock:^(NSError *error) {
         
        if (error) {
             // There was an error processing the request
         } else {
             // Email changed successfully
         }
            
     }];
    
    
}





@end


