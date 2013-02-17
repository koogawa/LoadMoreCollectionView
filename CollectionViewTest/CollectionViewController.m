//
//  CollectionViewController.m
//  CollectionViewTest
//
//  Created by koogawa on 2012/12/05.
//  Copyright (c) 2012年 koogawa. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    // Load sample data
    NSMutableArray *msmPhotos = [NSMutableArray array];
    for (int i = 1; i <= 10; i++) {
        NSString *filename = [NSString stringWithFormat:@"m%d.jpg", i];
        [msmPhotos addObject:[UIImage imageNamed:filename]];
    }
    self.photos = msmPhotos;
    
    // Regist CollectionCell
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"MY_CELL"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.photos = nil;
}


#pragma mark -
#pragma mark Override method

- (void)loadMore
{
    for (int i = 1; i <= 10; i++) {
        NSString *filename = [NSString stringWithFormat:@"m%d.jpg", i];
        [self.photos addObject:[UIImage imageNamed:filename]];
    }
    
    [self performSelector:@selector(didLoadPhotos) withObject:nil afterDelay:2.0];
}

- (void)didLoadPhotos
{
    [self stopMoreLoading];
    [self.collectionView reloadData];
}


#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.imageView.image = [self.photos objectAtIndex:indexPath.item];
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [self.photos objectAtIndex:indexPath.item];
    
    // Resize image
    return CGSizeMake(image.size.width / 25, image.size.height / 25);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 15.0f, 10.0f, 15.0f);
}

@end
