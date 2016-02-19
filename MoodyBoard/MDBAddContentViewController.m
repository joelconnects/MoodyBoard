//
//  MDBAddContentViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/13/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAddContentViewController.h"
#import "MDBConstants.h"


static CGFloat const EightyPercentMultiplier = 0.8;
static CGFloat const TenPercentMultiplier = 0.1;
static CGFloat const OneHundredPercentMultiplier = 1.0;

@interface MDBAddContentViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) CGFloat layoutWidthMultiplier;
@property (nonatomic, assign) CGFloat layoutHeightMultiplier;
@property (nonatomic, strong) UIButton *button;


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
    
    [self.view removeConstraints:self.view.constraints];
    self.layoutWidthMultiplier = OneHundredPercentMultiplier;
    self.layoutHeightMultiplier = OneHundredPercentMultiplier;
    [self constrainSubView:self.subView toParentView:self.view];


    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
        self.button.alpha = 0;
        
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.3 animations:^{
            self.view.alpha = 0;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
//            picker.modalInPopover = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.4;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.type = kCATransitionFade;
            transition.subtype = kCATransitionReveal;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self presentViewController:picker animated:NO completion:NULL];
            
        }];
        
    }];
    
    
    
    
    
    
}

-(void)addSubView {
    self.subView = [[UIView alloc] init];
    self.subView.backgroundColor = [UIColor whiteColor];
    self.subView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subView];
    self.layoutWidthMultiplier = EightyPercentMultiplier;
    self.layoutHeightMultiplier = EightyPercentMultiplier;
    [self constrainSubView:self.subView toParentView:self.view];
}

-(void)addButton {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button addTarget:self action:@selector(backToBoardController)
     forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"Add Image" forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor grayColor];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subView addSubview:self.button];
    self.layoutWidthMultiplier = EightyPercentMultiplier;
    self.layoutHeightMultiplier = TenPercentMultiplier;
    [self constrainButton:self.button toSubView:self.subView];
}

-(void)constrainButton:(UIButton *)button
             toSubView:(UIView *)subView
{
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:self.layoutWidthMultiplier
                                                         constant:0.0]];

    [subView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:self.layoutHeightMultiplier
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
                                                          multiplier:self.layoutWidthMultiplier
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:self.layoutHeightMultiplier
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
