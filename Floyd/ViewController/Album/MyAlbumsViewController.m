//
//  MyAlbumsViewController.m
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "MyAlbumsViewController.h"
#import "AlbumInfoCell.h"
#import "SWGIAlbumApi.h"
#import "NewAlbumViewController.h"
#import "AlbumPhotoViewController.h"

@interface MyAlbumsViewController () <NewAlbumViewControllerDelegate>
@property(nonatomic, strong) NSArray<SWGAlbumInfo> *albums;
@end

@implementation MyAlbumsViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                           target:self
                           action:@selector(rightBarButtonPressed:)];
  self.title = @"我的相册";
  [self requestData];
}

- (void)refreshUI {
  NSMutableArray *contents = [@[] mutableCopy];
  if (self.albums) {
    for (SWGAlbumInfo *item in self.albums) {
      AlbumInfoCellUserData *userData = [[AlbumInfoCellUserData alloc] init];
      userData.album = item;
      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[AlbumInfoCell class]
                                       userInfo:userData]];
    }
  }

  [self setTableData:contents];
}

- (void)requestData {
  [self showHUD];
  [[SWGIAlbumApi sharedAPI]
      allAlbumsGetWithCompletionBlock:[UserManager sharedInstance].userId
                    completionHandler:^(NSArray<SWGAlbumInfo> *output,
                                        NSError *error) {
                      if (error) {
                        [self showError:error];
                      } else {
                        self.albums = output;
                        [self refreshUI];
                      }
                      [self hideAllHUDs];
                    }];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[AlbumInfoCell class]]) {
    AlbumInfoCell *albumCell = (AlbumInfoCell *)cell;
    AlbumInfoCellUserData *userData = albumCell.userData;
    AlbumPhotoViewController *vc =
        [[AlbumPhotoViewController alloc] initWithNibName:nil bundle:nil];
    vc.album = userData.album;
    [self.navigationController pushViewController:vc animated:YES];
  }
}

- (void)rightBarButtonPressed:(id)sender {
  NewAlbumViewController *vc =
      [[NewAlbumViewController alloc] initWithNibName:nil bundle:nil];
  vc.delegate = self;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma NewAlbumViewControllerDelegate
- (void)newAlbum:(SWGAlbumInfo *)album {
  [self requestData];
}

@end
