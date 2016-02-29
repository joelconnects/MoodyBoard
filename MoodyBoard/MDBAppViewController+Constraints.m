//
//  MDBAppViewController+Constraints.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/14/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAppViewController+Constraints.h"
#import "MDBConstants.h"

@implementation MDBAppViewController (Constraints)


-(void)constrainSubView:(UIView *)subView
           toParentView:(UIView *)parentView
           forNavAction:(NSString *)navAction
           includeOldVC:(UIViewController *)oldVC
{
    if ([navAction isEqualToString:ReturnToBoardNavAction]) {
        [parentView removeConstraints:parentView.constraints];
        [self constrainSubView:subView toParentView:parentView];
        [self constrainAddContentSubViewSizeZero:oldVC.view toParentView:parentView];
    }
    
    if ([navAction isEqualToString:AddContentNavAction]) {
        [self constrainAddContentSubViewSizeZero:subView toParentView:parentView];
        [parentView layoutIfNeeded];
        [parentView removeConstraints:parentView.constraints];
        [self constrainSubView:subView toParentView:parentView];
    }
    
    if ([navAction isEqualToString:SettingsMenuNavAction]) {
        //
        //
    }
    
    if ([navAction isEqualToString:BoardDetailsNavAction]) {
        //
        //
    }
    
    if ([navAction isEqualToString:BoardActivityNavAction]) {
        //
        //
    }
    
    if ([navAction isEqualToString:PhotoLibraryNavAction]) {
        [parentView removeConstraints:parentView.constraints];
        [self constrainPhotoLibraryContainer:subView toCenterofParentView:parentView];
        [self constrainSubView:oldVC.view toParentView:parentView];
        [parentView layoutIfNeeded];
        [parentView removeConstraints:parentView.constraints];
        [self constrainPhotoLibraryContainer:oldVC.view toCenterofParentView:parentView];
        [self constrainSubView:subView toParentView:parentView];
        
    }

}

-(void)constrainSubView:(UIView *)subView
           toParentView:(UIView *)parentView
{
    
    [subView.leftAnchor constraintEqualToAnchor:parentView.leftAnchor].active = YES;
    [subView.rightAnchor constraintEqualToAnchor:parentView.rightAnchor].active = YES;
    [subView.topAnchor constraintEqualToAnchor:parentView.topAnchor].active = YES;
    [subView.bottomAnchor constraintEqualToAnchor:parentView.bottomAnchor].active = YES;

}

-(void)constrainAddContentSubViewSizeZero:(UIView *)subView
                             toParentView:(UIView *)parentView {
    CGRect frame = subView.frame;
    frame.size.width = 0;
    frame.size.height = 0;
    [subView setFrame:frame];
    [subView.rightAnchor constraintEqualToAnchor:parentView.rightAnchor].active = YES;
    [subView.topAnchor constraintEqualToAnchor:parentView.topAnchor].active = YES;
}

-(void)constrainPhotoLibraryContainer:(UIView *)subView
                 toCenterofParentView:(UIView *)parentView
{
    CGRect frame = subView.frame;
    frame.size.width = 0;
    frame.size.height = 0;
    [subView setFrame:frame];
    [subView.centerXAnchor constraintEqualToAnchor:parentView.centerXAnchor].active = YES;
    [subView.centerYAnchor constraintEqualToAnchor:parentView.centerYAnchor].active = YES;

}




@end

//-(void)constrainAddContentToMoveLeft:(UIView *)subView
//                        ofParentView:(UIView *)parentView
//{
//    CGRect frame = subView.frame;
//    frame.size.width = 0;
//    frame.size.height = 0;
//    [subView setFrame:frame];
//    [subView.centerXAnchor constraintEqualToAnchor:parentView.centerXAnchor].active = YES;
//    [subView.centerYAnchor constraintEqualToAnchor:parentView.centerYAnchor].active = YES;
//}


