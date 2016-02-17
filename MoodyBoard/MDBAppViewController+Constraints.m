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
                  oldVC:(UIViewController *)oldVC
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
}


-(void)constrainSubView:(UIView *)subView
           toParentView:(UIView *)parentView
{
    NSDictionary * views = @{@"subView" : subView};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];

}

-(void)constrainAddContentSubViewSizeZero:(UIView *)subView
                             toParentView:(UIView *)parentView {
    
    NSDictionary *viewsDictionary = @{@"subView":subView};
    
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[subView(0)]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    [parentView addConstraints:constraint_H];
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView(0)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    [parentView addConstraints:constraint_V];

}



@end



//-(void)constrainSubView:(UIView *)subView
//           toParentView:(UIView *)parentView
//{
//    [super updateViewConstraints];
//    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeTop
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:parentView
//                                                          attribute:NSLayoutAttributeTop
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//
//    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeLeading
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:parentView
//                                                          attribute:NSLayoutAttributeLeading
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//
//    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeBottom
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:parentView
//                                                          attribute:NSLayoutAttributeBottom
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//
//    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:subView
//                                                          attribute:NSLayoutAttributeTrailing
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:parentView
//                                                          attribute:NSLayoutAttributeTrailing
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//}
