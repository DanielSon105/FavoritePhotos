//
//  SearchViewController.m
//  FavoritePhotos
//
//  Created by Daniel Barrido on 10/17/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomCollectionViewCell.h"
#import "instagramImage.h"

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSString *searchString;
@property BOOL isSearching;

@property NSDictionary *searchResultDictionary;
@property NSMutableArray *searchResultArrayOfDictionaries;
@property NSMutableArray *arrayOfinstagramImages;

@property (weak, nonatomic) IBOutlet UICollectionView *searchResultCollectionView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self; // searchBar delegation - include <>!
    self.isSearching = false; // initial value for BOOL

    self.searchString = @"colts";
    self.arrayOfinstagramImages = [NSMutableArray new];
    [self searchForPhotos];
    // Do any additional setup after loading the view.
}


#pragma mark - Search For Photos

-(void)searchForPhotos{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ea901362a20b4ade92c1c969b5c7703c", self.searchString]];

   NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

       self.searchResultDictionary = [NSDictionary new];
       self.searchResultArrayOfDictionaries = [NSMutableArray new];

       self.searchResultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

       self.searchResultArrayOfDictionaries = [self.searchResultDictionary objectForKey:@"data"];

                NSLog(@"%@", self.searchResultArrayOfDictionaries);
        for (NSDictionary *temp in self.searchResultArrayOfDictionaries) {
            instagramImage *newImage = [[instagramImage alloc] initWithContentsOfDictionary:temp];
            [self.arrayOfinstagramImages addObject:newImage];
//            NSLog(@"%@", self.arrayOfinstagramImages);
        }


        dispatch_async(dispatch_get_main_queue(), ^{

            [self.searchResultCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

        });
    }];
    [task resume];


}






#pragma mark - UICollectionView Delegate Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    {
        if (self.arrayOfinstagramImages.count == 0)
        {
            return 1;
        }
        else if (self.arrayOfinstagramImages.count < 10)
        {
            return self.arrayOfinstagramImages.count;
        }
        else
        {
            return 10;
        }
    }
}

-(CustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCellID" forIndexPath:indexPath];
    if (self.arrayOfinstagramImages.count > 0)
    {
    instagramImage *instagramImageInstance = self.arrayOfinstagramImages[indexPath.row];
    cell.customImageView.image = instagramImageInstance.image;
    }
    else
    {
        cell.customImageView.image = [UIImage imageNamed:@"success"];
    }

    return cell;
}

#pragma mark - UISearchBarDelegate


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.arrayOfinstagramImages = [NSMutableArray new];
    self.searchString = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [searchBar resignFirstResponder];
    [self searchForPhotos];
    [self.searchResultCollectionView reloadData];

    // reloadData or search won't be dynamic
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
