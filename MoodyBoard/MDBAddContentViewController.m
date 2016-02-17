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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)backToBoardController:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:BoardSelectedNotificationName object:nil];
    
}
/*
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 [button addTarget:self
 action:@selector(aMethod:)
 forControlEvents:UIControlEventTouchUpInside];
 [button setTitle:@"Show View" forState:UIControlStateNormal];
 button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
 [view addSubview:button];
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
