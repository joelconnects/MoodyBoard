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
    self.commentField.alpha = 0;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton = cancelButton;
    [self.cancelButton addTarget:self
                          action:@selector(returnToBoardController)
                forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.backgroundColor = [UIColor whiteColor];
    [self.cancelButton setTitle:@"✕" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    self.cancelButton.alpha = 0;
    
    UIView *emptyView = [[UIView alloc] init];
    self.emptyView = emptyView;
    self.emptyView.backgroundColor = [UIColor whiteColor];
    self.emptyView.alpha = 0;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton = saveButton;
    [self.saveButton addTarget:self
                        action:@selector(returnToBoardController)
              forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.backgroundColor = [UIColor whiteColor];
    [self.saveButton setTitle:@"✓" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    self.saveButton.alpha = 0;
    
    [self.view removeConstraints:self.view.constraints];
    [self constrainTopViewToParentView];
    
//    self.hStackView = [[UIStackView alloc] init];
//    self.hStackView.axis = UILayoutConstraintAxisHorizontal;
//    self.hStackView.distribution = UIStackViewDistributionFill;
//    self.hStackView.alignment = UIStackViewAlignmentLeading;
//    self.hStackView.spacing = 0;
//    self.hStackView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:self.hStackView];
    
    UIStackView *vStackView = [[UIStackView alloc] init];
    UIStackView *hStackViewTopRow = [[UIStackView alloc] init];
    UIStackView *hStackViewBottomRow = [[UIStackView alloc] init];
    self.vStackView = vStackView;
    self.hStackViewTopRow = hStackViewTopRow;
    self.hStackViewBottomRow = hStackViewBottomRow;
    
    
    self.imageView.hidden = YES;
    self.commentField.hidden = YES;
    self.cancelButton.hidden = YES;
    self.emptyView.hidden = YES;
    self.saveButton.hidden = YES;
    
    // vStackView
    //      hStackViewTopRow
    //          imageView, commentField
    //      hStackViewBottomRow
    //          cancelButton, emptyView, saveButton
    
    // vStackView width * 0.9
    // vStackView height = vStackView width * 0.6666 + spacing
    //      hStackViewTopRow
    //          imageView width * 0.3333
    //          imageView height = imageView width
    //          commentField width * 0.6666
    //          commentField height = imageView width
    //      hStackViewBottomRow
    //          


}


-(void)constrainTopViewToParentView {
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.topView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.topView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.topView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
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
            self.cancelButton.alpha = 1;
            self.emptyView.alpha = 1;
            self.saveButton.alpha = 1;
            
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
