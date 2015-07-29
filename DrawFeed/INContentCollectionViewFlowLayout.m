//
//  INContentCollectionViewFlowLayout.m
//  Inbox
//
//  Created by Bob Law on 3/4/15.
//  Copyright (c) 2015 Inbox. All rights reserved.
//

#import "INContentCollectionViewFlowLayout.h"
#import "INContentCollectionViewLayoutAttributes.h"

@implementation INContentCollectionViewFlowLayout

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath
{
  UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
  
  
  return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
  // The rect should compensate the header size
  CGRect adjustedRect = rect;
//  adjustedRect.origin.y -= self.parallaxHeaderReferenceSize.height;
  
  NSMutableArray *allItems = [[super layoutAttributesForElementsInRect:adjustedRect] mutableCopy];
  
  NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *lastCells = [[NSMutableDictionary alloc] init];
  
  [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    UICollectionViewLayoutAttributes *attributes = obj;
    
    NSIndexPath *indexPath = [(UICollectionViewLayoutAttributes *)obj indexPath];
    if ([[obj representedElementKind] isEqualToString:UICollectionElementKindSectionHeader]) {
      [headers setObject:obj forKey:@(indexPath.section)];
    } else if ([[obj representedElementKind] isEqualToString:UICollectionElementKindSectionFooter]) {
      // Not implemeneted
    } else {
      NSIndexPath *indexPath = [(UICollectionViewLayoutAttributes *)obj indexPath];
      
      UICollectionViewLayoutAttributes *currentAttribute = [lastCells objectForKey:@(indexPath.section)];
      
      // Get the bottom most cell of that section
      if ( ! currentAttribute || indexPath.row > currentAttribute.indexPath.row) {
        [lastCells setObject:obj forKey:@(indexPath.section)];
      }
    }
    
    // For iOS 7.0, the cell zIndex should be above sticky section header
    attributes.zIndex = 1;
  }];
  
  [lastCells enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    NSIndexPath *indexPath = [obj indexPath];
    NSNumber *indexPathKey = @(indexPath.section);
    
    UICollectionViewLayoutAttributes *header = headers[indexPathKey];
    // CollectionView automatically removes headers not in bounds
    if ( ! header) {
      header = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                    atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];
      
      if (header) {
        [allItems addObject:header];
      }
    }
    [self updateHeaderAttributes:header lastCellAttributes:lastCells[indexPathKey]];
  }];
  
  return allItems;
}

- (void)updateHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes lastCellAttributes:(UICollectionViewLayoutAttributes *)lastCellAttributes
{
  CGRect currentBounds = self.collectionView.bounds;
  attributes.zIndex = 1024;
  attributes.hidden = NO;
  
  CGPoint origin = attributes.frame.origin;
  
  CGFloat sectionMaxY = CGRectGetMaxY(lastCellAttributes.frame) - attributes.frame.size.height + INContentCollectionViewFooterHeight;
  CGFloat y = CGRectGetMaxY(currentBounds) - currentBounds.size.height + self.collectionView.contentInset.top;
  
  CGFloat maxY = MIN(MAX(y, attributes.frame.origin.y), sectionMaxY);
    
  origin.y = maxY;
  
  attributes.frame = (CGRect){origin, attributes.frame.size};
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
  return YES;
}

@end
