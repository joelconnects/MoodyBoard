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
