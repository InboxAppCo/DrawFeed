//
//  INContentFooterCollectionReusableView.m
//  Inbox
//
//  Created by Bob Law on 3/6/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentFooterCollectionReusableView.h"

@interface INContentFooterCollectionReusableView ()

@property (nonatomic, strong) UILabel *likesLabel;
@property (nonatomic, strong) UIImageView *likesImageView;
@property (nonatomic, strong) UIImageView *starImageView;

@property (nonatomic, assign) BOOL hasLiked;

@end

@implementation INContentFooterCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  self.backgroundColor = [UIColor clearColor];
  
  UIView *contentView = [[UIView alloc] init];
  contentView.translatesAutoresizingMaskIntoConstraints = NO;
  contentView.clipsToBounds = NO;
  contentView.backgroundColor = [UIColor whiteColor];
  [self addSubview:contentView];
  
//  UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, frame.size.width, CGRectGetHeight(frame) - 20)];
//  contentView.layer.masksToBounds = NO;
//  contentView.layer.shadowColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7].CGColor;
//  contentView.layer.shadowOffset = CGSizeMake(0.0f, 1.5f);
//  contentView.layer.shadowOpacity = 1.f;
//  contentView.layer.shadowRadius = 1;
//  contentView.layer.shadowPath = shadowPath.CGPath;
  
  self.likesLabel = [[UILabel alloc] init];
  self.likesLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.likesLabel.text = @"200 likes";
  self.likesLabel.font = [UIFont systemFontOfSize:13];
  self.likesLabel.textColor = [UIColor lightGrayColor];
  [contentView addSubview:self.likesLabel];
  
  self.likesImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content_small_star"]];
  self.likesImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [contentView addSubview:self.likesImageView];
  
  self.starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_empty"] highlightedImage:[UIImage imageNamed:@"star_filled"]];
  self.starImageView.translatesAutoresizingMaskIntoConstraints = NO;
  self.starImageView.userInteractionEnabled = YES;
  [self.starImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setLiked:)]];
  [contentView addSubview:self.starImageView];
  
  NSDictionary *views = NSDictionaryOfVariableBindings(_likesLabel, _likesImageView, _starImageView);
  [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_likesImageView]-5-[_likesLabel]" options:0 metrics:nil views:views]];
  [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_starImageView]-15-|" options:0 metrics:nil views:views]];
  
  [contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.likesImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
  [contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.likesLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
  [contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.starImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
  
  views = NSDictionaryOfVariableBindings(contentView);
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]-20-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:views]];
  
  return self;
}

- (void)setLiked:(BOOL)liked
{
  self.starImageView.highlighted = !self.starImageView.isHighlighted;
  if (self.starImageView.isHighlighted) {
//    [self.starImageView bounceEffect];
  }
}

@end
