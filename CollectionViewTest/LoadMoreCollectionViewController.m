//
//  LoadMoreCollectionViewController.m
//  LoadMoreCollectionView
//
//  Created by koogawa on 2013/02/17.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "LoadMoreCollectionViewController.h"

#define MORE_FOOTER_HEIGHT 52.0f

@interface LoadMoreCollectionViewController ()

@end

@implementation LoadMoreCollectionViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // Custom initialization
        self.moreLoadEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.moreLoadEnabled) {
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, MORE_FOOTER_HEIGHT, 0);
        [self addMoreLoadFooter];
    }
}


#pragma mark - Private method

- (void)addMoreLoadFooter
{
    self.moreFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.contentSize.height, self.collectionView.frame.size.width, MORE_FOOTER_HEIGHT)];
    self.moreFooterView.backgroundColor = [UIColor clearColor];
    
    self.moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, MORE_FOOTER_HEIGHT)];
    self.moreLabel.backgroundColor = [UIColor clearColor];
    self.moreLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.moreLabel.textAlignment = NSTextAlignmentCenter;
    self.moreLabel.text = @"Loading...";
    
    self.moreSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.moreSpinner.frame = CGRectMake(floorf(floorf(MORE_FOOTER_HEIGHT - 20) / 2), floorf((MORE_FOOTER_HEIGHT - 20) / 2), 20, 20);
    self.moreSpinner.hidesWhenStopped = YES;
    
    [self.moreFooterView addSubview:self.moreLabel];
    [self.moreFooterView addSubview:self.moreSpinner];
    [self.collectionView addSubview:self.moreFooterView];
    
    // Hide at first
    [self.moreFooterView setHidden:YES];
}

- (void)startMoreLoading
{
    self.isLoading = YES;
    
    self.moreFooterView.frame = CGRectMake(0, self.collectionView.contentSize.height, self.collectionView.frame.size.width, MORE_FOOTER_HEIGHT);
    self.moreFooterView.hidden = NO;
    [self.moreSpinner startAnimating];
    
    [self loadMore];
}

- (void)stopMoreLoading
{
    self.isLoading = NO;
    
    self.moreFooterView.hidden = YES;
    [self.moreSpinner stopAnimating];
}

- (void)loadMore
{
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    [self performSelector:@selector(stopMoreLoading) withObject:nil afterDelay:2.0];
}


#pragma mark - UIScrollViewDelegate

// Don't forget to call [super ...] method, if you override this method
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height)
    {
        // we are at the end
        [self startMoreLoading];
    }
}

@end
