//
//  INContentCollectionViewLayoutAttributes.h
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INContentCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes


// 0 = minimized, 1 = fully expanded, > 1 = stretched
@property (nonatomic) CGFloat progressiveness;

@end
