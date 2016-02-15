//
//  MDBAppViewController+Constraints.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/14/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAppViewController+Constraints.h"

@implementation MDBAppViewController (Constraints)


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



@end
