//
//  AlbumPhotoViewController.m
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "AlbumPhotoViewController.h"
#import "SWGIAlbumApi.h"
#import "QiniuFileUploadManager.h"
#import "PhotoInfoCell.h"
#import "MWPhotoBrowser.h"

@interface AlbumPhotoViewController () <
    UIActionSheetDelegate, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate, MWPhotoBrowserDelegate>
@property(nonatomic, strong) NSArray<SWGPhotoInfo> *photos;
@property(nonatomic, strong) NSMutableArray *photoBrowseArr;
@end

@implementation AlbumPhotoViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self requestData];
  self.title = [NSString stringWithFormat:@"相册：%@", self.album.name];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                           target:self
                           action:@selector(rightBarButtonPressed:)];
}

- (void)createUI {
}

- (void)requestData {
  [self showHUD];
  [[SWGIAlbumApi sharedAPI]
      photosInAlbumGetWithCompletionBlock:self.album._id
                        completionHandler:^(NSArray<SWGPhotoInfo> *output,
                                            NSError *error) {
                          if (error) {
                            [self showError:error];
                          }
                          self.photos = output;
                          [self refreshUI];
                          [self hideAllHUDs];
                        }];
}

- (void)refreshUI {
  NSMutableArray *contents = [@[] mutableCopy];
  if (self.photos) {
    for (SWGPhotoInfo *item in self.photos) {
      PhotoInfoCellUserData *userData = [[PhotoInfoCellUserData alloc] init];
      userData.photo = item;
      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[PhotoInfoCell class]
                                       userInfo:userData]];
    }
  }

  [self setTableData:contents];
}

- (void)rightBarButtonPressed:(id)sender {
  UIActionSheet *choiceSheet = [[UIActionSheet alloc]
               initWithTitle:nil
                    delegate:self
           cancelButtonTitle:@"取消"
      destructiveButtonTitle:nil
           otherButtonTitles:@"拍照", @"从相册中选取", nil];
  [choiceSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    // 拍照
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
      UIImagePickerController *controller =
          [[UIImagePickerController alloc] init];
      controller.sourceType = UIImagePickerControllerSourceTypeCamera;
      if ([self isFrontCameraAvailable]) {
        controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
      }
      NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
      [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
      controller.mediaTypes = mediaTypes;
      controller.delegate = self;
      [self presentViewController:controller
                         animated:YES
                       completion:^(void) {
                         NSLog(@"Picker View Controller is presented");
                       }];
    }

  } else if (buttonIndex == 1) {
    // 从相册中选取
    if ([self isPhotoLibraryAvailable]) {
      UIImagePickerController *controller =
          [[UIImagePickerController alloc] init];
      controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
      [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
      controller.mediaTypes = mediaTypes;
      controller.delegate = self;
      [self presentViewController:controller
                         animated:YES
                       completion:^(void) {
                         NSLog(@"Picker View Controller is presented");
                       }];
    }
  }
}

- (void)uploadImage:(NSDictionary *)info {
  [self showHUD];
  UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
  QiniuFileUploadManager *manager = [[QiniuFileUploadManager alloc] init];
  [manager
      uploadImageToServce:image
       withCompletedBlock:^(NSString *key, NSString *hash, NSError *error) {
         if (key && !error) {
           [self addPhotoToAlbum:key];
         } else {
           [self showError:error];
           [self hideAllHUDs];
         }
       }];
}

- (void)addPhotoToAlbum:(NSString *)key {
  [[SWGIAlbumApi sharedAPI]
      addPhotoToAlbumGetWithCompletionBlock:self.album._id
                                  photoName:@"Picture"
                                   photoUrl:key
                          completionHandler:^(SWGPhotoInfo *output,
                                              NSError *error) {
                            [self requestData];
                            [self hideAllHUDs];
                          }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker dismissViewControllerAnimated:YES
                             completion:^() {
                               [self uploadImage:info];
                             }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES
                             completion:^(){
                             }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
}

#pragma mark camera utility
- (BOOL)isCameraAvailable {
  return [UIImagePickerController
      isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isRearCameraAvailable {
  return [UIImagePickerController
      isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL)isFrontCameraAvailable {
  return [UIImagePickerController
      isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)doesCameraSupportTakingPhotos {
  return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage
                        sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isPhotoLibraryAvailable {
  return [UIImagePickerController
      isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL)canUserPickVideosFromPhotoLibrary {
  return
      [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie
                     sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL)canUserPickPhotosFromPhotoLibrary {
  return
      [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage
                     sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType
                 sourceType:(UIImagePickerControllerSourceType)paramSourceType {
  __block BOOL result = NO;
  if ([paramMediaType length] == 0) {
    return NO;
  }
  NSArray *availableMediaTypes = [UIImagePickerController
      availableMediaTypesForSourceType:paramSourceType];
  [availableMediaTypes
      enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]) {
          result = YES;
          *stop = YES;
        }
      }];
  return result;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self startBrowserPhoto:indexPath];
}

- (void)startBrowserPhoto:(NSIndexPath *)indexPath {
  self.photoBrowseArr = [NSMutableArray array];
  for (SWGPhotoInfo *info in self.photos) {
    NSString *url = QINIU_FILE_URL_ORIGINAL(info.url);
    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
    [self.photoBrowseArr addObject:photo];
  }
  MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];

  // Set options
  browser.displayActionButton = YES; // Show action button to allow sharing,
                                     // copying, etc (defaults to YES)
  browser.displayNavArrows = NO; // Whether to display left and right nav arrows
                                 // on toolbar (defaults to NO)
  browser.displaySelectionButtons =
      NO; // Whether selection buttons are shown on each image (defaults to NO)
  browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be
                                  // initially zoomed to fill (defaults to YES)
  browser.alwaysShowControls =
      NO; // Allows to control whether the bars and controls are always visible
          // or whether they fade away to show the photo full (defaults to NO)
  browser.enableGrid = YES; // Whether to allow the viewing of all the photo
                            // thumbnails on a grid (defaults to YES)
  browser.startOnGrid = NO; // Whether to start on the grid of thumbnails
                            // instead of the first photo (defaults to NO)
  browser.autoPlayOnAppear = NO; // Auto-play first video

  // Present
  [self.navigationController pushViewController:browser animated:YES];

  // Manipulate
  [browser showNextPhotoAnimated:YES];
  [browser showPreviousPhotoAnimated:YES];
  [browser setCurrentPhotoIndex:indexPath.row];
}

#pragma MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
  return self.photoBrowseArr.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser
               photoAtIndex:(NSUInteger)index {
  if (index < self.photoBrowseArr.count) {
    return [self.photoBrowseArr objectAtIndex:index];
        }
	return nil;
}
@end
