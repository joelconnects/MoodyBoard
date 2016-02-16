//
//  MDBBoardViewCell.h
//  MoodyBoard
//
//  Created by Joel Bell on 2/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDBBoardViewCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *image;

-(void)addShadowToCell;


@end
