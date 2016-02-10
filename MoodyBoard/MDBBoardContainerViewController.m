//
//  MDBBoardContainerViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardContainerViewController.h"

@interface MDBBoardContainerViewController ()

@end

@implementation MDBBoardContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSegueWithIdentifier:@"boardSegue" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
