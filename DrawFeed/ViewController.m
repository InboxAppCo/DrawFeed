//
//  ViewController.m
//  DrawFeed
//
//  Created by Bob Law on 7/27/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "ViewController.h"
#import "INContentImageCollectionViewCell.h"
#import "INContentCollectionViewFlowLayout.h"
#import "INContentHeaderCollectionReusableView.h"
#import "INContentFooterCollectionReusableView.h"
#import "FLAnimatedImage.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *collection;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.navigationItem.title = @"DrawFeed";
  
  INContentCollectionViewFlowLayout *flowLayout = [INContentCollectionViewFlowLayout new];
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
  self.collectionView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  [self.view addSubview:self.collectionView];
  [self.collectionView registerClass:[INContentImageCollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];
  [self.collectionView registerClass:[INContentHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
  [self.collectionView registerClass:[INContentFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
  self.collection = @[[UIImage imageNamed:@"draw1"], [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"bikini-2"] ofType:@"gif"]], [UIImage imageNamed:@"draw2"], [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"calvin"] ofType:@"gif"]], [UIImage imageNamed:@"draw3"], [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"1"] ofType:@"gif"]], [UIImage imageNamed:@"draw4"],[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"jenner6"] ofType:@"gif"]], [UIImage imageNamed:@"draw5"], [UIImage imageNamed:@"draw6"], [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"bikini"] ofType:@"gif"]], [UIImage imageNamed:@"draw7"], [UIImage imageNamed:@"draw8"], [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"bunny"] ofType:@"gif"]], [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"halsy"] ofType:@"gif"]]];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.collectionView reloadData];
    });
  });

}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return self.collection.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
  return CGSizeMake(CGRectGetWidth(self.view.bounds), 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
  return CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
  INContentImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
  
  id data = [self.collection objectAtIndex:indexPath.section];
  
  if ([data isKindOfClass:[UIImage class]]) {
    UIImage *image = (UIImage *)data;
    [cell setImage:image];
  } else {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    FLAnimatedImage *gif = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
      dispatch_async(dispatch_get_main_queue(), ^{
        [cell setAnimatedImage:gif];
      });
    });
  }

  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//    NSInteger integer = indexPath.section % 5;
    INContentHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//    [header setString:self.names[integer] subString:self.actions[integer] color:self.colors[integer]];
    return header;
//  }
  } else {
    INContentFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    return footer;
  }
}

@end
