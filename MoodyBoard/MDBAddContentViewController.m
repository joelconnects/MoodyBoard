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

@property (strong, nonatomic) UIView *subView;
@property (strong, nonatomic) UIView *buttonView;
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) UIButton *cancelButton;


@end

@implementation MDBAddContentViewController


- (void)viewDidLoad {
    
    
    [self addSubView];
    [self addButtonViewToSubView];
    [self addImageButtonToButtonView];
    [self addCancelButtonToButtonView];
    [super viewDidLoad];

    
}

-(void)requestPhotoLibraryAuthorization {
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        
        [self continueToPhotoLibrary];
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
                     [self continueToPhotoLibrary];
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
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.modalInPopover = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.navigationBar.tintColor = [UIColor blackColor];
//    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromRight;
//    
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self presentViewController:picker animated:NO completion:nil];
    
}


- (void)transitionToImagePicker {

    [self.view removeConstraints:self.view.constraints];
    [self constrainSubView:self.subView toExpandToParentView:self.view];

//    self.subView.alpha = 0;
//    self.addImageButton.alpha = 0;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.view layoutIfNeeded];
//        self.subView.alpha = 0;
//        self.addImageButton.alpha = 0;
        
    }];
    
//    [self animateImagePickerDidAppear];
    
    [self performSelector:@selector(animateImagePickerDidAppear)
               withObject:nil
               afterDelay:0.1];
    
}

-(void)returnToBoardController {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BoardSelectedNotificationName object:nil];
    
}

-(void)continueToPhotoLibrary {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PhotoLibrarySelectedNotificationName object:nil];
    
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

-(void)addButtonViewToSubView {
    self.buttonView = [[UIView alloc] init];
    self.buttonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subView addSubview:self.buttonView];
    [self constrainButtonView:self.buttonView toSubView:self.subView];
}

-(void)addImageButtonToButtonView {
    self.addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addImageButton addTarget:self
                            action:@selector(requestPhotoLibraryAuthorization)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.addImageButton setTitle:@"Add Image" forState:UIControlStateNormal];
    self.addImageButton.backgroundColor = [UIColor grayColor];
    self.addImageButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttonView addSubview:self.addImageButton];
    [self constrainAddImageButton:self.addImageButton toButtonView:self.buttonView];
}

-(void)addCancelButtonToButtonView {
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton addTarget:self
                          action:@selector(returnToBoardController)
                forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.backgroundColor = [UIColor grayColor];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttonView addSubview:self.cancelButton];
    [self constrainCancelButton:self.cancelButton toButtonView:self.buttonView];
    
}

-(void)constrainAddImageButton:(UIButton *)button
                  toButtonView:(UIView *)buttonView
{
    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:buttonView
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1.0
                                                         constant:0.0]];

    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:buttonView
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0.45
                                                         constant:0.0]];

    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:buttonView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                         constant:0.0]];

    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:buttonView
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1.0
                                                         constant:0.0]];
}

-(void)constrainCancelButton:(UIButton *)button
                toButtonView:(UIView *)buttonView
{
    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:buttonView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:buttonView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:0.45
                                                            constant:0.0]];
    
    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:buttonView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [buttonView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:buttonView
                                                           attribute:NSLayoutAttributeLeft
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

-(void)constrainButtonView:(UIView *)buttonView toSubView:(UIView *)subView
{
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:buttonView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:subView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:0.8
                                                            constant:0.0]];
    
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:buttonView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:subView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:0.25
                                                            constant:0.0]];
    
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:buttonView
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:subView
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:buttonView
                                                           attribute:NSLayoutAttributeCenterY
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:subView
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
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeLeft
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
