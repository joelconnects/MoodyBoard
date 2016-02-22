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


@property (nonatomic, strong) UIButton *addImageButton;


@end

@implementation MDBAddContentViewController


- (void)viewDidLoad {
    
    
    [self addSubView];
    [self addImageButtonToSubView];
    [super viewDidLoad];

    
}

-(void)requestPhotoLibraryAuthorization {
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        
        [self backToBoardController];
        return;
    };
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied) {
        
        NSLog(@"\n\nneed to set up alert for photo library access denied\n(after status denied)\n\n");
    }
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        
        NSLog(@"\n\nif photolibrary auth status not determined\n\n");
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                 {
                     [self backToBoardController];
                 }];
            
            }
            
            if (status == PHAuthorizationStatusDenied) {
                NSLog(@"\n\nneed to set up alert for photo library access denied\n(after status not determined)\n\n");
            }
            
        }];
        
    };
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)animateImagePickerDidAppear {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.navigationBar.tintColor = [UIColor blackColor];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionReveal;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:picker animated:NO completion:NULL];
    
}


- (void)backToBoardController {

//    [[NSNotificationCenter defaultCenter] postNotificationName:BoardSelectedNotificationName object:nil];
    
    [self.view removeConstraints:self.view.constraints];
    [self constrainSubView:self.subView toExpandToParentView:self.view];

    [UIView animateWithDuration:0.4 animations:^{
        
        [self.view layoutIfNeeded];
        self.subView.alpha = 0;
        self.addImageButton.alpha = 0;
        [self performSelector:@selector(animateImagePickerDidAppear)
                   withObject:nil
                   afterDelay:0.1];
        
        
    }];
    
}

//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    
//    NSLog(@"\n\npicker cancelled\n\n");
//    
//}

-(void)addSubView {
    self.subView = [[UIView alloc] init];
    self.subView.backgroundColor = [UIColor whiteColor];
    self.subView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subView];
    [self constrainSubView:self.subView toParentView:self.view];
}

-(void)addImageButtonToSubView {
    self.addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addImageButton addTarget:self action:@selector(requestPhotoLibraryAuthorization)
     forControlEvents:UIControlEventTouchUpInside];
    [self.addImageButton setTitle:@"Add Image" forState:UIControlStateNormal];
    self.addImageButton.backgroundColor = [UIColor grayColor];
    self.addImageButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subView addSubview:self.addImageButton];
    [self constrainButton:self.addImageButton toSubView:self.subView];
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
                                                       multiplier:0.1
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

-(void)constrainSubView:(UIView *)subView
   toExpandToParentView:(UIView *)parentView
{
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0
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

-(void)constrainSubView:(UIView *)subView
        aboveParentView:(UIView *)parentView
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
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0]];
}



/*
 
 static CGFloat const EightyPercentMultiplier = 0.8;
 static CGFloat const TenPercentMultiplier = 0.1;
 static CGFloat const OneHundredPercentMultiplier = 1.0;
 
 @property (nonatomic, assign) CGFloat layoutWidthMultiplier;
 @property (nonatomic, assign) CGFloat layoutHeightMultiplier;
 
UIImagePickerController *picker = [[UIImagePickerController alloc] init];
picker.delegate = self;
picker.allowsEditing = YES;
picker.modalInPopover = YES;
picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
picker.navigationBar.tintColor = [UIColor blackColor];

CATransition *transition = [CATransition animation];
transition.duration = 0.4;
transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
transition.type = kCATransitionFade;
transition.subtype = kCATransitionReveal;

[self.view.window.layer addAnimation:transition forKey:nil];
[self presentViewController:picker animated:YES completion:NULL];
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
