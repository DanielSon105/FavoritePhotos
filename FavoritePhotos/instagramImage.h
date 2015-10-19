//
//  instagramImage.h
//  FavoritePhotos
//
//  Created by Daniel Barrido on 10/17/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface instagramImage : NSObject

- (instancetype)initWithContentsOfDictionary:(NSDictionary *)eventDictionary;

@property NSString *imageURL;
@property UIImage *image;

@end
