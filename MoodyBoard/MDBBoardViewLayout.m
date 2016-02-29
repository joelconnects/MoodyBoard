//
//  MDBBoardViewLayout.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardViewLayout.h"
#import "MDBBoardLayoutMultipliers.h"
#import "MDBConstants.h"

static NSUInteger const kWidthDictKey = 0;
static NSUInteger const kHeightDictKey = 1;
static NSUInteger const kXdictKey = 0;
static NSUInteger const kYdictKey = 1;
static CGFloat const kFirstItemYoffsetMultiplier = 0.3519553072626;

typedef NS_ENUM(NSUInteger, Zindex) {
    Top = 7,
    LowerTop = 6,
    UpperMiddle = 5,
    Middle = 4,
    LowerMiddle = 3,
    UpperBottom = 2,
    Bottom = 1
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
//@property (nonatomic) UIEdgeInsets insets;

@end

@implementation MDBBoardViewLayout

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self)  {
        _layoutCache = [NSMutableDictionary dictionary];
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


-(void)prepareLayout
{
    
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    
    if (self.layoutCache.count == 0) {
        
        for (NSUInteger section = 0; section < sectionCount; section++) {
            for (NSUInteger item = 0; item < BoardItemsPerSection; item++) {
                
                [self setItemAttributeForSection:section item:item];
                
            }
        }
    
    } else {
        
        NSUInteger sectionIndex = self.layoutCache.count / BoardItemsPerSection;
        
        for (NSUInteger section = sectionIndex; section < sectionCount; section++) {
            for (NSUInteger item = 0; item < BoardItemsPerSection; item++) {
                
                [self setItemAttributeForSection:section item:item];
                
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

-(void)setItemAttributeForSection:(NSUInteger)section item:(NSUInteger)item {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    [self itemSizeForLocation:item];
    [self itemZindexForLocation:item];
    [self itemOffsetForLocation:item];
    
    // initial value for offsets
    if (section == 0 && item == 0) {
        self.xOffset = 0.0;
        self.yOffset = roundf(self.viewHeight * kFirstItemYoffsetMultiplier);
    }
    
    // xOffset adjustment for new section
    if (section > 0 && item == 0) {
        self.xOffset -= 8;
    }
    
    CGRect frame = CGRectMake(self.xOffset, self.yOffset, self.itemWidth, self.itemHeight);
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.frame = frame;
    attributes.zIndex = self.itemZindex;
    
    [self.layoutCache setObject:attributes forKey:indexPath];
    
    if (item % BoardItemsPerSection < 2) {
        self.contentWidth = CGRectGetMaxX(frame);
    }
    
}

-(void)calculateItemSize:(NSString *)size
{
    NSArray *multipliers = [[MDBBoardLayoutMultipliers sizeMultipliers] objectForKey:size];
    CGFloat widthMultiplier = [multipliers[kWidthDictKey] floatValue];
    CGFloat heightMultiplier = [multipliers[kHeightDictKey] floatValue];
    self.itemWidth = roundf(self.viewWidth * widthMultiplier);
    self.itemHeight = roundf(self.viewHeight * heightMultiplier);
}

-(void)itemSizeForLocation:(NSUInteger)item
{
    switch (item) {
        case 0 ... 1:
            [self calculateItemSize:@"XXL"];
            break;
        case 2 ... 3:
            [self calculateItemSize:@"XL"];
            break;
        case 10 ... 11:
            [self calculateItemSize:@"L"];
            break;
        case 8 ... 9:
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
            itemZindex = Top;
            break;
        case 1:
            itemZindex = LowerTop;
            break;
        case 6 ... 7:
            itemZindex = UpperMiddle;
            break;
        case 10 ... 11:
            itemZindex = Middle;
            break;
        case 2 ... 3:
            itemZindex = LowerMiddle;
            break;
        case 4 ... 5:
        case 12 ... 13:
            itemZindex = UpperBottom;
            break;
        case 8 ... 9:
            itemZindex = Bottom;
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
    CGFloat xMultiplier = [multipliers[kXdictKey] floatValue];
    CGFloat yMultiplier = [multipliers[kYdictKey] floatValue];
    
    switch (item) {
        case 1:
        case 5 ... 6:
        case 8 ... 9:
        case 12:
            self.xOffset += roundf(self.viewWidth * xMultiplier);
            break;
        case 0:
        case 2 ... 4:
        case 7:
        case 10 ... 11:
        case 13:
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




@end