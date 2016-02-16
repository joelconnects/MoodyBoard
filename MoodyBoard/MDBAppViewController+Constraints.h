//
//  MDBAppViewController+Constraints.h
//  MoodyBoard
//
//  Created by Joel Bell on 2/14/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAppViewController.h"

@interface MDBAppViewController (Constraints)


-(void)constrainSubView:(UIView *)subView
           toParentView:(UIView *)parentView;

-(void)preAnimationConstrainAddContentSubView:(UIView *)subView
                                 toParentView:(UIView *)parentView;


@end
