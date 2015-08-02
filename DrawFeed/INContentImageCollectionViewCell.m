//
//  INContentImageCollectionView.m
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentImageCollectionViewCell.h"
#import "FLAnimatedImageView.h"

@interface INContentImageCollectionViewCell ()

@property (nonatomic, strong) FLAnimatedImageView *imageView;

@end

@implementation INContentImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  self.imageView = [[FLAnimatedImageView alloc] initWithFrame:self.bounds];
  self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
  [self.contentView addSubview:self.imageView];
  
  return self;
}

- (void)setImage:(UIImage *)image
{
  self.imageView.image = image;
}

- (void)setAnimatedImage:(FLAnimatedImage *)animatedImage
{
  self.imageView.animatedImage = animatedImage;
}

- (void)prepareForReuse
{
  self.imageView.image = nil;
  self.imageView.animatedImage = nil;
}

@end
