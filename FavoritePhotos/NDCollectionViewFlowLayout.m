//
//  NDCollectionViewFlowLayout.m
//  FavoritePhotos
//
//  Created by Daniel Barrido on 10/18/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "NDCollectionViewFlowLayout.h"

@implementation NDCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttributes = [NSMutableArray arrayWithCapacity:attributes.count];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if ((attribute.frame.origin.x + attribute.frame.size.width <= self.collectionViewContentSize.width) &&
            (attribute.frame.origin.y + attribute.frame.size.height <= self.collectionViewContentSize.height)) {
            [newAttributes addObject:attribute];
        }
    }
    return newAttributes;
}

@end
