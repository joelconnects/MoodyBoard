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
    
    [self.view removeConstraints:self.view.constraints];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1.0].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1.0].active = YES;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20.0].active = YES;
}

-(void)presentImagePickerController {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.navigationBar.tintColor = [UIColor blackColor];

    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;

    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:picker animated:NO completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView.image = originalImage;

    NSLog(@"\n\neditedImage: %@\n\n",editedImage);
    NSLog(@"\n\noriginalImage: %@\n\n",originalImage);
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
