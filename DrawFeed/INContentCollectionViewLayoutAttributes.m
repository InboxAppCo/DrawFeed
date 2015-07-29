//
//  INContentCollectionViewLayoutAttributes.m
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentCollectionViewLayoutAttributes.h"

@implementation INContentCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
  typeof(self) copy = [super copyWithZone:zone];
  copy.progressiveness = self.progressiveness;
  return copy;
}

@end
