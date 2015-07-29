//
//  INContentImageCollectionView.m
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentImageCollectionViewCell.h"

@interface INContentImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation INContentImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  self.imageView = [[UIImageView alloc] init];
  self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
  self.imageView.backgroundColor = [UIColor orangeColor];
  [self.contentView addSubview:self.imageView];
  
  NSDictionary *views = NSDictionaryOfVariableBindings(_imageView);
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:views]];
  
  return self;
}

- (void)setImage:(UIImage *)image
{
  self.imageView.image = image;
}

- (void)prepareForReuse
{
  self.imageView.image = nil;
}

@end
