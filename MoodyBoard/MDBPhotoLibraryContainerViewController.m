//
//  MDBPhotoLibraryContainerViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/24/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBPhotoLibraryContainerViewController.h"

@interface MDBPhotoLibraryContainerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIView *emptyView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UITextField *commentField;
@property (weak, nonatomic) UIButton *saveButton;
@property (weak, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) UIStackView *vStackView;
@property (weak, nonatomic) UIStackView *hStackViewTopRow;
@property (weak, nonatomic) UIStackView *hStackViewMiddleRow;
@property (weak, nonatomic) UIStackView *hStackViewBottomRow;

@end

@implementation MDBPhotoLibraryContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *topView = [[UIView alloc] init];
    self.topView = topView;
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.alpha = 0;
    
    UITextField *commentField = [[UITextField alloc] init];
    self.commentField = commentField;
    self.commentField.backgroundColor = [UIColor whiteColor];
    self.commentField.placeholder = @"Write something...";
    [self.commentField setFont:[UIFont systemFontOfSize:16.0]];
    self.commentField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.commentField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 10, 0);
    self.commentField.alpha = 0;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton = cancelButton;
    [self.cancelButton addTarget:self
                          action:@selector(returnToBoardController)
                forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.cancelButton.alpha = 0;
    
    UIView *emptyView = [[UIView alloc] init];
    self.emptyView = emptyView;
    self.emptyView.alpha = 0;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton = saveButton;
    [self.saveButton addTarget:self
                        action:@selector(returnToBoardController)
              forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.backgroundColor = [UIColor whiteColor];
    [self.saveButton setTitle:@"ADD TO BOARD" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.saveButton.alpha = 0;
    
    [self.view removeConstraints:self.view.constraints];
    [self constrainTopViewToParentView];
    
    UIStackView *vStackView = [[UIStackView alloc] init];
    UIStackView *hStackViewTopRow = [[UIStackView alloc] init];
    UIStackView *hStackViewMiddleRow = [[UIStackView alloc] init];
    UIStackView *hStackViewBottomRow = [[UIStackView alloc] init];
    self.vStackView = vStackView;
    self.hStackViewTopRow = hStackViewTopRow;
    self.hStackViewMiddleRow = hStackViewMiddleRow;
    self.hStackViewBottomRow = hStackViewBottomRow;
    
    CGFloat stackViewSpacing = 4;
    CGFloat vStackViewWidth = self.view.frame.size.width * 0.9;
    CGFloat buttonHeight = 44;
    CGFloat vStackViewHeight = (vStackViewWidth / 3) + (stackViewSpacing * 2) + (buttonHeight * 2);
    CGFloat vStackViewTopConstant = 0;
    CGFloat imageViewWidth = (vStackViewWidth / 3);
    
    self.vStackView.axis = UILayoutConstraintAxisVertical;
    self.vStackView.distribution = UIStackViewDistributionFill;
    self.vStackView.spacing = stackViewSpacing;
    [self.view addSubview:self.vStackView];
    self.vStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.vStackView.widthAnchor constraintEqualToConstant:vStackViewWidth].active = YES;
    [self.vStackView.heightAnchor constraintEqualToConstant:vStackViewHeight].active = YES;
    [self.vStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.vStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:vStackViewTopConstant].active = YES;
    
    self.hStackViewTopRow.axis = UILayoutConstraintAxisHorizontal;
    self.hStackViewTopRow.distribution = UIStackViewDistributionFill;
    self.hStackViewMiddleRow.axis = UILayoutConstraintAxisHorizontal;
    self.hStackViewMiddleRow.distribution = UIStackViewDistributionFill;
    self.hStackViewBottomRow.axis = UILayoutConstraintAxisHorizontal;
    self.hStackViewBottomRow.distribution = UIStackViewDistributionFill;
    
    [self.vStackView addArrangedSubview:self.hStackViewTopRow];
    [self.vStackView addArrangedSubview:self.hStackViewMiddleRow];
    [self.vStackView addArrangedSubview:self.hStackViewBottomRow];
    self.hStackViewTopRow.translatesAutoresizingMaskIntoConstraints = NO;
    self.hStackViewMiddleRow.translatesAutoresizingMaskIntoConstraints = NO;
    self.hStackViewBottomRow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.hStackViewTopRow addArrangedSubview:self.emptyView];
    [self.hStackViewTopRow addArrangedSubview:self.cancelButton];
    [self.hStackViewMiddleRow addArrangedSubview:self.imageView];
    [self.hStackViewMiddleRow addArrangedSubview:self.commentField];
    [self.hStackViewBottomRow addArrangedSubview:self.saveButton];
    
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.cancelButton.heightAnchor constraintEqualToConstant:buttonHeight].active = YES;
    [self.cancelButton.rightAnchor constraintEqualToAnchor:self.hStackViewTopRow.rightAnchor].active = YES;
    [self.cancelButton.topAnchor constraintEqualToAnchor:self.hStackViewTopRow.topAnchor].active = YES;
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.commentField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imageView.widthAnchor constraintEqualToConstant:imageViewWidth].active = YES;
    [self.imageView.heightAnchor constraintEqualToConstant:imageViewWidth].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.hStackViewMiddleRow.leftAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.hStackViewMiddleRow.topAnchor].active = YES;
    
    [self.commentField.leftAnchor constraintEqualToAnchor:self.imageView.rightAnchor constant:stackViewSpacing].active = YES;
    [self.commentField.topAnchor constraintEqualToAnchor:self.hStackViewMiddleRow.topAnchor].active = YES;
    [self.commentField.rightAnchor constraintEqualToAnchor:self.hStackViewMiddleRow.rightAnchor].active = YES;
    [self.commentField.bottomAnchor constraintEqualToAnchor:self.hStackViewMiddleRow.bottomAnchor].active = YES;

    self.imageView.hidden = YES;
    self.commentField.hidden = YES;
    self.cancelButton.hidden = YES;
    self.emptyView.hidden = YES;
    self.saveButton.hidden = YES;
    
}


-(void)constrainTopViewToParentView {
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.topView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.topView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.topView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
}


-(void)returnToBoardController {
    
    NSLog(@"\n\n\nreturn to board controller\n\n\n");
    
}

-(void)presentImagePickerController {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    picker.navigationBar.tintColor = [UIColor whiteColor];
    picker.navigationBar.translucent = NO;
    picker.navigationBar.opaque = YES;
    picker.navigationBar.barTintColor = [UIColor colorWithRed:101.0/255.0 green:100.0/255.0 blue:116.0/255.0 alpha:1.0];
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;

    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    [self presentViewController:picker animated:NO completion:^{
        self.topView.backgroundColor = [UIColor blackColor];
    }];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImageForDisplay = [UIImage imageWithData:UIImageJPEGRepresentation(editedImage, 0.1)];

    self.imageView.hidden = NO;
    self.commentField.hidden = NO;
    self.cancelButton.hidden = NO;
    self.emptyView.hidden = NO;
    self.saveButton.hidden = NO;
    
    self.imageView.image = editedImageForDisplay;
    
    NSData *editedImageForDisplayData = UIImageJPEGRepresentation(editedImageForDisplay, 1.0);
    NSData *editedImageData = UIImageJPEGRepresentation(editedImage, 1.0);
    NSData *originalImageData = UIImageJPEGRepresentation(originalImage, 1.0);
    NSLog(@"\n\nSize of Edited Image For Display(bytes):%lu\n\n",[editedImageForDisplayData length]);
    NSLog(@"\n\nSize of Edited Image(bytes):%lu\n\n",[editedImageData length]);
    NSLog(@"\n\nSize of Original Image(bytes):%lu\n\n",[originalImageData length]);
    NSLog(@"\n\neditedImageForDisplay: %@\n\neditedImage: %@\n\noriginalImage: %@\n\n",editedImageForDisplay,editedImage,originalImage);
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.backgroundColor = [UIColor clearColor];
            self.topView.alpha = 0;
            self.imageView.alpha = 1;
            self.commentField.alpha = 1;
            self.cancelButton.alpha = 0.5;
            self.saveButton.alpha = 0.6;
            
        } completion:^(BOOL finished) {
            
            [self.topView removeFromSuperview];
            
        }];
        
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"\n\n\nimage picker controller did cancel\n\n\n");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
