//
//  MDBLoginViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBLoginViewController.h"
#import "Firebase.h"

@interface MDBLoginViewController ()

@end

@implementation MDBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://moodyboard.firebaseio.com"];
    [ref createUser:@"bobtony@example.com" password:@"correcthorsebatterystaple" withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
    
    if (error) {
        // There was an error creating the account
    } else {
        NSString *uid = [result objectForKey:@"uid"];
        NSLog(@"Successfully created user account with uid: %@", uid);
        ;
    }
}];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
