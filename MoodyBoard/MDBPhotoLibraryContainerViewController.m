//
//  MDBPhotoLibraryContainerViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/24/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBPhotoLibraryContainerViewController.h"

@interface MDBPhotoLibraryContainerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UITextField *commentField;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIStackView *hStackView;
@property (strong, nonatomic) UIStackView *vStackView;

@end

@implementation MDBPhotoLibraryContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.hidden = YES;
    
    self.commentField = [[UITextField alloc] init];
    self.commentField.backgroundColor = [UIColor whiteColor];
    self.commentField.placeholder = @"Write something...";
    [self.commentField setFont:[UIFont systemFontOfSize:16.0]];
    self.commentField.hidden = YES;
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton addTarget:self
                        action:@selector(returnToBoardController)
              forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.backgroundColor = [UIColor grayColor];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.hidden = YES;
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton addTarget:self
                        action:@selector(returnToBoardController)
              forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.backgroundColor = [UIColor grayColor];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.hidden = YES;
    
    [self.view removeConstraints:self.view.constraints];
    [self constrainTopViewToParentView];
    
    //
    
    self.hStackView = [[UIStackView alloc] init];
    self.hStackView.axis = UILayoutConstraintAxisHorizontal;
    self.hStackView.distribution = UIStackViewDistributionFillProportionally;
    self.hStackView.spacing = 8;
    self.hStackView.hidden = YES;
    
    self.vStackView = [[UIStackView alloc] init];
    self.vStackView.axis = UILayoutConstraintAxisVertical;
    self.vStackView.distribution = UIStackViewDistributionFillEqually;
    self.vStackView.spacing = 8;
    self.vStackView.hidden = YES;
    
    [self.view addSubview:self.hStackView];
    [self.hStackView addArrangedSubview:self.vStackView];
    [self.hStackView addArrangedSubview:self.commentField];
    [self.vStackView addArrangedSubview:self.imageView];
    [self.vStackView addArrangedSubview:self.saveButton];
    [self.vStackView addArrangedSubview:self.cancelButton];
    
//    [self.hStackView addSubview:self.vStackView];
//    [self.hStackView addSubview:self.commentField];
//    [self.vStackView addSubview:self.imageView];
//    [self.vStackView addSubview:self.saveButton];
//    [self.vStackView addSubview:self.cancelButton];
    
    self.hStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.commentField.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;

    
    CGFloat topAnchorConstant = self.view.frame.size.width * 0.05;
    [self.hStackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.9].active = YES;
    [self.hStackView.bottomAnchor constraintEqualToAnchor:self.cancelButton.bottomAnchor].active = YES;
    [self.hStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.hStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:topAnchorConstant].active = YES;
    
    /*
     CGRect frame = subView.frame;
     frame.size.width = 0;
     frame.size.height = 0;
     [subView setFrame:frame];
     */
    
    [self.imageView.widthAnchor constraintEqualToAnchor:self.hStackView.widthAnchor multiplier:0.3].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.hStackView.widthAnchor multiplier:0.3].active = YES;
    


    

    
    
    // stackView horizontal
    //  left side
    //      stackView Vertical
    //          imageView, saveButton, cancelButton
    //              equal distribution
    //              alignment center
    //  right side
    //      commentField
    //          fill
    //          alignment center

}

/*
 //Stack View
 UIStackView *stackView = [[UIStackView alloc] init];
 
 stackView.axis = UILayoutConstraintAxisVertical;
 stackView.distribution = UIStackViewDistributionEqualSpacing;
 stackView.alignment = UIStackViewAlignmentCenter;
 stackView.spacing = 30;
 
 
 [stackView addArrangedSubview:view1];
 [stackView addArrangedSubview:view2];
 [stackView addArrangedSubview:view3];
 
 stackView.translatesAutoresizingMaskIntoConstraints = false;
 [self.view addSubview:stackView];
 */

-(void)constrainTopViewToParentView {
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.topView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.topView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.topView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
}

-(void)someConstraints {
    
    [self.view removeConstraints:self.view.constraints];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10.0].active = YES;
    
    
    
}

-(void)returnToBoardController {
    
}

-(void)presentImagePickerController {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    picker.navigationBar.tintColor = [UIColor blackColor];

    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;

    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    [self presentViewController:picker animated:NO completion:^{
        self.topView.backgroundColor = [UIColor blackColor];
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImageForDisplay = [UIImage imageWithData:UIImageJPEGRepresentation(editedImage, 0.1)];
    
    self.hStackView.hidden = NO;
    self.vStackView.hidden = NO;
    self.commentField.hidden = NO;
    self.saveButton.hidden = NO;
    self.cancelButton.hidden = NO;
    self.imageView.hidden = NO;
    
    self.imageView.image = editedImageForDisplay;
    self.hStackView.alpha = 0;
    
    NSData *editedImageForDisplayData = UIImageJPEGRepresentation(editedImageForDisplay, 1.0);
    NSData *editedImageData = UIImageJPEGRepresentation(editedImage, 1.0);
    NSData *originalImageData = UIImageJPEGRepresentation(originalImage, 1.0);
    NSLog(@"\n\nSize of Edited Image For Display(bytes):%lu\n\n",[editedImageForDisplayData length]);
    NSLog(@"\n\nSize of Edited Image(bytes):%lu\n\n",[editedImageData length]);
    NSLog(@"\n\nSize of Original Image(bytes):%lu\n\n",[originalImageData length]);
    NSLog(@"\n\neditedImageForDisplay: %@\n\neditedImage: %@\n\noriginalImage: %@\n\n",editedImageForDisplay,editedImage,originalImage);
    
//    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:NO completion:^{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.backgroundColor = [UIColor clearColor];
            self.topView.alpha = 0;
            self.hStackView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            [self.topView removeFromSuperview];
            
            
            
        }];
        
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
