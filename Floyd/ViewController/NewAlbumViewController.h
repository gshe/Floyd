//
//  NewAlbumViewController.h
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDViewController.h"
#import "SWGAlbumInfo.h"

@protocol NewAlbumViewControllerDelegate <NSObject>
- (void)newAlbum:(SWGAlbumInfo *)album;
@end

@interface NewAlbumViewController : FDViewController
@property(nonatomic, weak) id<NewAlbumViewControllerDelegate> delegate;
@end
