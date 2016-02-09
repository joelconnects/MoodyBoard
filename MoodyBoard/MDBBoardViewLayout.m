//
//  MDBBoardViewLayout.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardViewLayout.h"
#import "MDBBoardLayoutMultipliers.h"

static NSUInteger const kXpercentIndex = 0;
static NSUInteger const kYpercentIndex = 0;
NSUInteger const kItemsPerSection = 14;

typedef NS_ENUM(NSUInteger, Zindex) {
    VeryTop = 5,
    Top = 4,
    Middle = 3,
    Bottom = 2,
    VeryBottom = 1
};

@interface MDBBoardViewLayout()

@property (nonatomic, strong) NSDictionary* cache;
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic, readonly) CGFloat viewHeight;
@property (nonatomic, readonly) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) NSUInteger itemZindex;

@end

@implementation MDBBoardViewLayout

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self)  {
        _contentWidth = 0;
        
    }
    return self;
}

-(CGFloat)viewWidth
{
    return self.collectionView.bounds.size.width;
}
-(CGFloat)viewHeight
{
    return self.collectionView.bounds.size.height;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth, self.viewHeight);
}

-(void)calculateItemSize:(NSString *)size
{
    NSArray *multipliers = [[MDBBoardLayoutMultipliers sizeMultipliers] objectForKey:size];
    CGFloat widthMultiplier = [multipliers[0] floatValue];
    CGFloat heightMultiplier = [multipliers[1] floatValue];
    self.itemWidth = roundf(self.viewWidth * widthMultiplier);
    self.itemHeight = roundf(self.viewHeight * heightMultiplier);
}

-(void)itemSizeForLocation:(NSUInteger)item
{
    switch (item) {
        case 0 ... 1:
            [self calculateItemSize:@"XL"];
            break;
        case 2 ... 3:
            [self calculateItemSize:@"L"];
            break;
        case 8 ... 11:
            [self calculateItemSize:@"M"];
            break;
        case 4 ... 7:
            [self calculateItemSize:@"S"];
            break;
        case 12 ... 13:
            [self calculateItemSize:@"XS"];
            break;
        default:
            break;
    }
}

-(void)itemZindexForLocation:(NSUInteger)item
{
    Zindex itemZindex;
    switch (item) {
        case 0:
        case 10:
        case 11:
            itemZindex = VeryTop;
            break;
        case 1:
        case 12:
        case 13:
            itemZindex = Top;
            break;
        case 2 ... 3:
            itemZindex = Middle;
            break;
        case 4 ... 5:
            itemZindex = Bottom;
            break;
        case 6 ... 9:
            itemZindex = VeryBottom;
            break;
        default:
            break;
    }
    
    self.itemZindex = itemZindex;
}


-(void)prepareLayout
{
    
    if (!self.cache) {
        
        CGFloat xOffset = 0.0;
        CGFloat yOffset = 0.0;
        
        NSMutableDictionary *layoutInformation = [NSMutableDictionary dictionary];
        
        NSUInteger sectionCount = [self.collectionView numberOfSections];

        for (NSUInteger section = 0; section < sectionCount; section++) {
            for (NSUInteger item = 0; item < kItemsPerSection; item++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
                
                // item size
                [self itemSizeForLocation:item];
                
                // item zIndex
                [self itemZindexForLocation:item];
                
                

                
                
                
                
            }
        }
        
        
        
//        NSMutableArray* xOffsetArray = [NSMutableArray new];
//        [xOffsetArray addObject:[NSNumber numberWithFloat:0.0]];
//        
//        NSMutableArray* yOffsetArray = [NSMutableArray new];
//        [yOffsetArray addObject:[NSNumber numberWithFloat:0.0]];
//        
//        NSMutableDictionary *layoutInformation = [NSMutableDictionary dictionary];
//        
//        CGFloat largeWidth = self.width / 2;
//        CGFloat largeHeight = self.height / 4;
//        
//        CGFloat smallWidth = self.width / 4;
//        CGFloat smallHeight = self.height / 8;
//        
//        NSUInteger numberOfSections = 1;
//        
//        for (NSUInteger section = 0; section < numberOfSections ; section++) {
//            NSInteger itemsCount = [self.collectionView numberOfItemsInSection:section];
//            
//            for (NSInteger item = 0; item < itemsCount; item++) {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
//                
//                CGFloat xOffset = [[xOffsetArray objectAtIndex:0] floatValue];
//                CGFloat yOffset = [[yOffsetArray objectAtIndex:0] floatValue];
//                
//                NSInteger viewPattern = (item + 1) % 10;
//                NSInteger viewPage = item % 20;
//                
//                if (item == 0)
//                {
//                    xOffset = 0;
//                    yOffset = 0;
//                }
//                else if (viewPage == 0 && item > 1)
//                {
//                    xOffset = xOffset + smallWidth;
//                    yOffset = 0;
//                }
//                else
//                {
//                    switch (viewPattern) {
//                        case 0 :
//                            xOffset = xOffset + smallWidth;
//                            // yOffset remains at current value
//                            break;
//                        case 1 :
//                            xOffset = xOffset - (largeWidth + smallWidth);
//                            yOffset = yOffset + smallHeight;
//                            break;
//                        case 2 :
//                            xOffset = xOffset + largeWidth;
//                            // yOffset remains at current value
//                            break;
//                        case 3 :
//                            xOffset = xOffset + smallWidth;
//                            // yOffset remains at current value
//                            break;
//                        case 4 :
//                            xOffset = xOffset - smallWidth;
//                            yOffset = yOffset + smallHeight;
//                            break;
//                        case 5 :
//                            xOffset = xOffset - largeWidth;
//                            yOffset = yOffset + smallHeight;
//                            break;
//                        case 6 :
//                            xOffset = xOffset + smallWidth;
//                            // yOffset remains at current value
//                            break;
//                        case 7 :
//                            xOffset = xOffset - smallWidth;
//                            yOffset = yOffset + smallHeight;
//                            break;
//                        case 8 :
//                            xOffset = xOffset + smallWidth;
//                            // yOffset remains at current value
//                            break;
//                        case 9 :
//                            xOffset = xOffset + smallWidth;
//                            // yOffset remains at current value
//                            break;
//                        default :
//                            break;
//                    }
//                }
//                
//                CGRect frame;
//                switch(viewPattern)
//                {
//                    case 0 :
//                    case 2 :
//                    case 3 :
//                    case 5 :
//                    case 6 :
//                    case 7 :
//                    case 8 :
//                    case 9 :
//                        frame = CGRectMake(xOffset, yOffset, smallWidth, smallHeight);
//                        break;
//                    case 1 :
//                    case 4 :
//                    default:
//                        frame = CGRectMake(xOffset, yOffset, largeWidth, largeHeight);
//                        break;
//                }
//                
//                [xOffsetArray replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:xOffset]];
//                [yOffsetArray replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:yOffset]];
//                
//                CGRect insetFrame = CGRectInset(frame, 0.0, 0.0);
//                
//                UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//                
//                attributes.frame = insetFrame;
//                
//                NSLog(@"\n\nItem Num: %li\nCGRect frame: %@\nitem xOffset: %.f\nitem yOffset: %.f\n\n",item + 1,(NSStringFromCGRect(insetFrame)),xOffset,yOffset);
//                
//                [layoutInformation setObject:attributes forKey:indexPath];
//                
//                self.contentWidth = MAX(self.contentWidth, CGRectGetMaxX(frame));
//                
//                
//            }
//            
//        }
//        self.cache = layoutInformation;
        
    }
    
}



@end
