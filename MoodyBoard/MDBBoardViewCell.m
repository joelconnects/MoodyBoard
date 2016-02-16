//
//  MDBBoardViewCell.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardViewCell.h"

@interface MDBBoardViewCell()

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MDBBoardViewCell


- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
    
    
    /*
     UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
     selectedBackgroundView.backgroundColor = [UIColor orangeColor];
     self.selectedBackgroundView = selectedBackgroundView;
     */
    
    /*
    self.colorView = [[UIView alloc] initWithFrame:CGRectZero];
    self.colorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.colorView];
    */
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    return self;
}

-(void)layoutSubviews
{
//    self.colorView.frame = CGRectInset(self.bounds, 4, 4);
    self.imageView.frame = CGRectInset(self.bounds, 8, 8);
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

//-(void)setColor:(UIColor *)color
//{
//    _color = color;
//    
//    self.colorView.backgroundColor = color;
//}

-(void)addShadowToCell {
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.5f, 1.5f);
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


@end
