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

@end

@implementation MDBBoardViewCell


- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectZero];
    self.colorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.colorView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowRadius  = 1.3f;
    self.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(1.5f, 1.5f);
    self.layer.shadowOpacity = 0.4f;
    self.layer.masksToBounds = NO;
    
    return self;
}

-(void)layoutSubviews
{
    self.colorView.frame = CGRectInset(self.bounds, 4, 4);
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    
    self.colorView.backgroundColor = color;
}


@end
