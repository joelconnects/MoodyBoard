//
//  MDBAddContentViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/13/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAddContentViewController.h"
#import "MDBConstants.h"

@interface MDBAddContentViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MDBAddContentViewController

- (void)viewDidLoad {
    
    [self addSubView];
    [self addButton];
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)backToBoardController {

//    [[NSNotificationCenter defaultCenter] postNotificationName:BoardSelectedNotificationName object:nil];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

-(void)addSubView {
    self.subView = [[UIView alloc] init];
    self.subView.backgroundColor = [UIColor whiteColor];
    self.subView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subView];
    [self constrainSubView:self.subView toParentView:self.view];
}

-(void)addButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backToBoardController)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Add Image" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subView addSubview:button];
    [self constrainButton:button toSubView:self.subView];
}

-(void)constrainButton:(UIButton *)button
             toSubView:(UIView *)subView
{
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.8
                                                         constant:0.0]];

    [subView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0.10
                                                         constant:0.0]];

    [subView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];

    [subView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0.0]];
}

-(void)constrainSubView:(UIView *)subView
           toParentView:(UIView *)parentView
{
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:0.8
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:0.8
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeCenterY
                                                          multiplier:1.0
                                                            constant:0.0]];
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
