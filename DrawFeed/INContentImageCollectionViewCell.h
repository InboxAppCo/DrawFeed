//
//  INContentImageCollectionView.h
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentMotherCollectionViewCell.h"
#import "FLAnimatedImage.h"

@interface INContentImageCollectionViewCell : INContentMotherCollectionViewCell

- (void)setImage:(UIImage *)image;
- (void)setAnimatedImage:(FLAnimatedImage *)animatedImage;

@end
