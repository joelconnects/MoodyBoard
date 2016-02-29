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
    [button.widthAnchor constraintEqualToAnchor:buttonView.widthAnchor].active = YES;
    [button.heightAnchor constraintEqualToAnchor:buttonView.heightAnchor multiplier:0.45].active = YES;
    [button.topAnchor constraintEqualToAnchor:buttonView.topAnchor].active = YES;
    [button.leftAnchor constraintEqualToAnchor:buttonView.leftAnchor].active = YES;
}

-(void)constrainCancelButton:(UIButton *)button
                toButtonView:(UIView *)buttonView
{
    [button.widthAnchor constraintEqualToAnchor:buttonView.widthAnchor].active = YES;
    [button.heightAnchor constraintEqualToAnchor:buttonView.heightAnchor multiplier:0.45].active = YES;
    [button.leftAnchor constraintEqualToAnchor:buttonView.leftAnchor].active = YES;
    [button.bottomAnchor constraintEqualToAnchor:buttonView.bottomAnchor].active = YES;
}

-(void)constrainSubView:(UIView *)subView
           toParentView:(UIView *)parentView
{
    [subView.widthAnchor constraintEqualToAnchor:parentView.widthAnchor multiplier:0.8].active = YES;
    [subView.heightAnchor constraintEqualToAnchor:parentView.heightAnchor multiplier:0.8].active = YES;
    [subView.centerXAnchor constraintEqualToAnchor:parentView.centerXAnchor].active = YES;
    [subView.centerYAnchor constraintEqualToAnchor:parentView.centerYAnchor].active = YES;
}

-(void)constrainButtonView:(UIView *)buttonView toSubView:(UIView *)subView
{
    [buttonView.widthAnchor constraintEqualToAnchor:subView.widthAnchor multiplier:0.8].active = YES;
    [buttonView.heightAnchor constraintEqualToAnchor:subView.heightAnchor multiplier:0.25].active = YES;
    [buttonView.centerXAnchor constraintEqualToAnchor:subView.centerXAnchor].active = YES;
    [buttonView.centerYAnchor constraintEqualToAnchor:subView.centerYAnchor].active = YES;
}

-(void)constrainSubView:(UIView *)subView
   toExpandToParentView:(UIView *)parentView
{
    [subView.widthAnchor constraintEqualToAnchor:parentView.widthAnchor multiplier:0.8].active = YES;
    [subView.heightAnchor constraintEqualToAnchor:parentView.heightAnchor multiplier:0.8].active = YES;
    [subView.rightAnchor constraintEqualToAnchor:parentView.leftAnchor].active = YES;
    [subView.centerYAnchor constraintEqualToAnchor:parentView.centerYAnchor].active = YES;
}

-(void)constrainSubView:(UIView *)subView
        aboveParentView:(UIView *)parentView
{
    [subView.widthAnchor constraintEqualToAnchor:parentView.widthAnchor multiplier:0.8].active = YES;
    [subView.heightAnchor constraintEqualToAnchor:parentView.heightAnchor multiplier:0.8].active = YES;
    [subView.centerXAnchor constraintEqualToAnchor:parentView.centerXAnchor].active = YES;
    [subView.bottomAnchor constraintEqualToAnchor:parentView.topAnchor].active = YES;
}

@end

//- (void)transitionToImagePicker {
//
//    [self.view removeConstraints:self.view.constraints];
//    [self constrainSubView:self.subView toExpandToParentView:self.view];
//
////    self.subView.alpha = 0;
////    self.addImageButton.alpha = 0;
//
//    [UIView animateWithDuration:0.6 animations:^{
//
//        [self.view layoutIfNeeded];
////        self.subView.alpha = 0;
////        self.addImageButton.alpha = 0;
//
//    }];
//
////    [self animateImagePickerDidAppear];
//
////    [self performSelector:@selector(animateImagePickerDidAppear)
////               withObject:nil
////               afterDelay:0.1];
//
//}


//    self.subView.layer.masksToBounds = NO;
//    self.subView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.subView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    self.subView.layer.shadowOpacity = 1.0f;
//    self.subView.layer.shadowRadius = 5.0f;
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.subView.bounds];
//    self.subView.layer.shadowPath = shadowPath.CGPath;

/*
 viewCheck.layer.shadowRadius  = 1.5f;
 viewCheck.layer.shadowColor   = [UIColor colorWithRed:176.f/255.f green:199.f/255.f blue:226.f/255.f alpha:1.f].CGColor;
 viewCheck.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
 viewCheck.layer.shadowOpacity = 0.9f;
 viewCheck.layer.masksToBounds = NO;
 
 UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
 UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(viewCheck.bounds, shadowInsets)];
 viewCheck.layer.shadowPath    = shadowPath.CGPath;
 */

//-(void)animateImagePickerDidAppear {

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

//}

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


