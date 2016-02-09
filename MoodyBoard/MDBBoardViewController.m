//
//  MDBBoardViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardViewController.h"
#import "MDBBoardViewLayout.h"
#import "MDBBoardViewCell.h"

@interface MDBBoardViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *colors;

@end

@implementation MDBBoardViewController

static NSString * const reuseIdentifier = @"BoardCell";
static NSUInteger const kDefaultNumberOfSections = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[MDBBoardViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.colors = [self generateColors:kItemsPerSection*3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    if (self.colors.count == kItemsPerSection) {
        return kDefaultNumberOfSections;
    }
    
    return self.colors.count / kItemsPerSection;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return kItemsPerSection;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MDBBoardViewCell *cell = (MDBBoardViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSUInteger boardIndex = indexPath.item + (indexPath.section * kItemsPerSection);

    [cell setColor:self.colors[boardIndex]];
    
    return cell;
}


-(NSArray *)generateColors:(NSUInteger)numberOfColors
{
    
    NSMutableArray *colors = [NSMutableArray array];
    CGFloat hue = 0.0;
    CGFloat hueIncrement = 0.05;
    
    for (NSUInteger i = 0; i < numberOfColors; i++) {
        UIColor *color = [UIColor colorWithHue:hue
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [colors addObject:color];
        hue += hueIncrement;
    }
    
    return colors;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSUInteger item = indexPath.item;
    NSUInteger section = indexPath.section;
    NSLog(@"\n\nDID SELECT:\nsection: %lu\nitem: %lu\n\n",section,item);
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
