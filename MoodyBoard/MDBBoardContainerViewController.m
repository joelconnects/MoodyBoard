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
    
    UIViewController *boardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardViewController"];
//    [self showViewController:boardVC sender:nil];
    
    [self addChildViewController:boardVC];
    boardVC.view.frame = self.view.frame;
    [self.view addSubview:self.];
    [content didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
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
