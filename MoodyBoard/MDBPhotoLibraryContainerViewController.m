//
//  MDBPhotoLibraryContainerViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/24/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBPhotoLibraryContainerViewController.h"

@interface MDBPhotoLibraryContainerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *topView;

@end

@implementation MDBPhotoLibraryContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageView];
    
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.hidden = YES;
    
    self.topView = [[UIView alloc] init];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [UIColor whiteColor];
    
    [self.view removeConstraints:self.view.constraints];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10.0].active = YES;
    
    [self.topView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.topView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.topView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.topView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
}

-(void)presentImagePickerController {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    picker.navigationBar.tintColor = [UIColor blackColor];

//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    transition.type = kCATransitionFade;
//
//    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    [self presentViewController:picker animated:YES completion:^{
        self.topView.backgroundColor = [UIColor blackColor];
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImageForDisplay = [UIImage imageWithData:UIImageJPEGRepresentation(editedImage, 0.1)];
    
    self.imageView.hidden = NO;
    self.imageView.image = editedImageForDisplay;
    self.imageView.alpha = 0;
    
    NSData *editedImageForDisplayData = UIImageJPEGRepresentation(editedImageForDisplay, 1.0);
    NSData *editedImageData = UIImageJPEGRepresentation(editedImage, 1.0);
    NSData *originalImageData = UIImageJPEGRepresentation(originalImage, 1.0);
    NSLog(@"\n\nSize of Edited Image For Display(bytes):%lu\n\n",[editedImageForDisplayData length]);
    NSLog(@"\n\nSize of Edited Image(bytes):%lu\n\n",[editedImageData length]);
    NSLog(@"\n\nSize of Original Image(bytes):%lu\n\n",[originalImageData length]);
    NSLog(@"\n\neditedImageForDisplay: %@\n\neditedImage: %@\n\noriginalImage: %@\n\n",editedImageForDisplay,editedImage,originalImage);
    
//    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:NO completion:^{
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.topView.alpha = 0;
            self.imageView.alpha = 1;
            
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
