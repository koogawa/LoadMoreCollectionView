//
//  CollectionViewController.h
//  CollectionViewTest
//
//  Created by koogawa on 2012/12/05.
//  Copyright (c) 2012年 koogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadMoreCollectionViewController.h"

@interface CollectionViewController : LoadMoreCollectionViewController

@property (nonatomic, strong) NSMutableArray *photos;

@end
