//
//  INContentHeaderCollectionReusableView.m
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentHeaderCollectionReusableView.h"

@interface INContentHeaderCollectionReusableView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UIView *topColorView;

@property (nonatomic, strong) NSLayoutConstraint *timeStampWidthConstraint;
@end

@implementation INContentHeaderCollectionReusableView


- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
  
  self.topColorView = [[UIView alloc] init];
  self.topColorView.translatesAutoresizingMaskIntoConstraints = NO;
  self.topColorView.backgroundColor = [UIColor darkGrayColor];
  [self addSubview:self.topColorView];
  
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
  self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.85;
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.text = @"Maher posted a new drawing";
  self.titleLabel.textColor = [UIColor darkGrayColor];
  [self addSubview:self.titleLabel];
  
  [self setupConstraints];
  
  return self;
}

- (void)setupConstraints
{
  NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _topColorView);
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topColorView(==2)]" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topColorView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20@999-[_titleLabel]-10@999-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12@999-[_titleLabel]-12@999-|" options:0 metrics:nil views:views]];
}

- (void)setString:(NSString *)string subString:(NSString *)subString color:(UIColor *)color
{
  self.topColorView.backgroundColor = color;
  NSString *message = @"sent Team Inbox a";
  NSString *fullString = [NSString stringWithFormat:@"%@ %@ %@", string, message, subString];
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullString];
  [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[fullString rangeOfString:string]];
  [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[fullString rangeOfString:string]];
  
  self.titleLabel.attributedText = attributedString;
}

@end
