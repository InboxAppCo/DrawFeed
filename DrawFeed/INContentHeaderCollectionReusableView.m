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
@property (nonatomic, strong) UILabel *timeStampLabel;
@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UIView *topColorView;

@property (nonatomic, strong) NSLayoutConstraint *timeStampWidthConstraint;
@end

@implementation INContentHeaderCollectionReusableView


- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.965];
  
  self.topColorView = [[UIView alloc] init];
  self.topColorView.translatesAutoresizingMaskIntoConstraints = NO;
  self.topColorView.backgroundColor = [UIColor greenColor];
  [self addSubview:self.topColorView];
  
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
  self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.85;
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.text = @"Julian M sent Team Inbox a message";
  self.titleLabel.textColor = [UIColor colorWithHexString:@"#919191"];
  [self addSubview:self.titleLabel];
  
  self.timeStampLabel = [[UILabel alloc] init];
  self.timeStampLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.timeStampLabel.textColor = [UIColor colorWithHexString:@"#919191"];
  self.timeStampLabel.text = @"now";
  self.timeStampLabel.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:13];
  self.timeStampLabel.layoutMargins = UIEdgeInsetsZero;
  self.timeStampLabel.numberOfLines = 1;
  [self addSubview:self.timeStampLabel];
  
  self.actionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_arrow"]];
  self.actionImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.actionImageView];
  
  [self setupConstraints];
  
  return self;
}

- (void)setupConstraints
{
  NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _timeStampLabel, _actionImageView, _topColorView);
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topColorView(==2)]" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topColorView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20@999-[_titleLabel]-5-[_timeStampLabel]-5-[_actionImageView]-10@999-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12@999-[_titleLabel]-12@999-|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_timeStampLabel]" options:0 metrics:nil views:views]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.actionImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.timeStampLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
  
  self.timeStampWidthConstraint = [NSLayoutConstraint constraintWithItem:self.timeStampLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:3];
  [self addConstraint:self.timeStampWidthConstraint];
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
  
  self.timeStampWidthConstraint.constant = [self.timeStampLabel sizeThatFits:CGSizeZero].width;
  [self layoutIfNeeded];
}

@end
