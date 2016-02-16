//
//  MDBAddContentViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/13/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAddContentViewController.h"
#import "MDBConstants.h"

@interface MDBAddContentViewController ()

@end

@implementation MDBAddContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToBoardController:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:BoardSelectedNotificationName object:nil];
    
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
