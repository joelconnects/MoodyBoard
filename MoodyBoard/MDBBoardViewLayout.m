//
//  MDBBoardViewLayout.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardViewLayout.h"
#import "MDBBoardLayoutMultipliers.h"

static NSUInteger const kX, kWidth = 0;
static NSUInteger const kY, kHeight = 1;
NSUInteger const kItemsPerSection = 14;

typedef NS_ENUM(NSUInteger, Zindex) {
    VeryTop = 5,
    Top = 4,
    Middle = 3,
    Bottom = 2,
    VeryBottom = 1
};

@interface MDBBoardViewLayout()

@property (nonatomic, strong) NSMutableDictionary *layoutCache;
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic, readonly) CGFloat viewHeight;
@property (nonatomic, readonly) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) NSUInteger itemZindex;
@property (nonatomic, assign) CGFloat xOffset;
@property (nonatomic, assign) CGFloat yOffset;

@end

@implementation MDBBoardViewLayout

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self)  {
        _layoutCache = [NSMutableDictionary dictionary];
        _contentWidth = 0;
        _xOffset = 0.0;
        _yOffset = 260.0;
        
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
    CGFloat widthMultiplier = [multipliers[kWidth] floatValue];
    CGFloat heightMultiplier = [multipliers[kHeight] floatValue];
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

-(void)itemOffsetForLocation:(NSUInteger)item
{
    
    NSNumber *itemKey = [NSNumber numberWithInteger:item];
    NSArray *multipliers = [[MDBBoardLayoutMultipliers offsetMultipliers] objectForKey:itemKey];
    CGFloat xMultiplier = [multipliers[kX] floatValue];
    CGFloat yMultiplier = [multipliers[kY] floatValue];
    
    switch (item) {
        case 0:
        case 1:
        case 5 ... 6:
        case 9 ... 10:
        case 12 ... 13:
            self.xOffset += roundf(self.viewWidth * xMultiplier);
            break;
        case 2 ... 4:
        case 7 ... 8:
        case 11:
            self.xOffset -= roundf(self.viewWidth * xMultiplier);
            break;
        default:
            break;
    }
    
    switch (item) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 9:
        case 11:
        case 13:
            self.yOffset += roundf(self.viewHeight * yMultiplier);
            break;
        case 0:
        case 2:
        case 4:
        case 6:
        case 8:
        case 10:
        case 12:
            self.yOffset -= roundf(self.viewHeight * yMultiplier);
            break;
        default:
            break;
    }
    
}


-(void)prepareLayout
{
    
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    
    if (self.layoutCache.count == 0) {
        
        for (NSUInteger section = 0; section < sectionCount; section++) {
            for (NSUInteger item = 0; item < kItemsPerSection; item++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
                
                // item size
                [self itemSizeForLocation:item];
                
                // item zIndex
                [self itemZindexForLocation:item];
                
                if (section != 0 && item != 0) {
                    
                    // item offsets
                    [self itemOffsetForLocation:item];
        
                }
                
                CGRect frame = CGRectMake(self.xOffset, self.yOffset, self.itemWidth, self.itemHeight);
                
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                
                attributes.frame = frame;
                attributes.zIndex = self.itemZindex;
                
                [self.layoutCache setObject:attributes forKey:indexPath];
                
                if (item % kItemsPerSection < 2) {
                    self.contentWidth = CGRectGetMaxX(frame);
                }
                
            }
        }
    
    } else {
        
        // let's say layoutCache count is 14
        // that means section number should be 1
        
        NSUInteger sectionIndex = self.layoutCache.count / kItemsPerSection;
        
        for (NSUInteger section = sectionIndex; section < sectionCount; section++) {
            for (NSUInteger item = 0; item < kItemsPerSection; item++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
                
                // item size
                [self itemSizeForLocation:item];
                
                // item zIndex
                [self itemZindexForLocation:item];
                
                if (section != 0 && item != 0) {
                    
                    // item offsets
                    [self itemOffsetForLocation:item];
                    
                }
                
                CGRect frame = CGRectMake(self.xOffset, self.yOffset, self.itemWidth, self.itemHeight);
                
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                
                attributes.frame = frame;
                attributes.zIndex = self.itemZindex;
                
                [self.layoutCache setObject:attributes forKey:indexPath];
                
                if (item % kItemsPerSection < 2) {
                    self.contentWidth = CGRectGetMaxX(frame);
                }
                
            }
        }
        
        
    }
    
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    
    for (NSIndexPath *path in self.layoutCache) {
        
        UICollectionViewLayoutAttributes *attributes = [self.layoutCache objectForKey:path];
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
        
        
    }
    
    return layoutAttributes;
    
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}



@end