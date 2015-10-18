//
//  RetrieveDataFromInstagramAPI.m
//  FavoritePhotos
//
//  Created by Daniel Barrido on 10/17/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "RetrieveDataFromInstagramAPI.h"

@implementation RetrieveDataFromInstagramAPI

-(void)retrieveDataFromInstagramAPI:(NSArray *)results{


    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=ea901362a20b4ade92c1c969b5c7703c", self.searchTag]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

//        NSArray *results = [rawData objectForKey:@"data"];


    }];


    
}

@end
