//
//  instagramImage.m
//  FavoritePhotos
//
//  Created by Daniel Barrido on 10/17/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "instagramImage.h"
#import <UIKit/UIKit.h>

@implementation instagramImage

-(instancetype)initWithContentsOfDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self)
    {
        self.imageURL = dictionary[@"images"][@"standard_resolution"][@"url"];
        self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]]];
        NSLog(@"self.imageUR: = %@", self.imageURL);    }

    return self;
}

@end
