//
//  NewAlbumViewController.m
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "NewAlbumViewController.h"
#import "SWGIAlbumApi.h"
#import "SWGIFileApi.h"
#import "QiniuFileUploadManager.h"

#define ORIGINAL_MAX_WIDTH 800

@interface NewAlbumViewController () <UIActionSheetDelegate,
                                      UINavigationControllerDelegate,
                                      UIImagePickerControllerDelegate>
@property(nonatomic, strong) UITextField *albumNameField;
@property(nonatomic, strong) UITextField *albumDescField;
@property(nonatomic, strong) UIImageView *albumCoverImage;

@property(nonatomic, strong) NSString *coverKey;

@property(nonatomic, strong) UIImage *coverImage;
@end

@implementation NewAlbumViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self createUI];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                           target:self
                           action:@selector(rightBarButtonPressed:)];
}

- (void)createUI {
  _albumNameField = [UITextField new];
  _albumNameField.placeholder = @"  input Album Name";
  _albumNameField.returnKeyType = UIReturnKeyNext;
  _albumNameField.layer.cornerRadius = 2;
  _albumNameField.layer.borderWidth = 1;
  _albumNameField.layer.borderColor = [UIColor ex_greenTextColor].CGColor;
  _albumDescField = [UITextField new];
  _albumDescField.placeholder = @"  input Album Description";
  _albumDescField.layer.cornerRadius = 2;
  _albumDescField.layer.borderWidth = 1;
  _albumDescField.layer.borderColor = [UIColor ex_greenTextColor].CGColor;
  _albumDescField.returnKeyType = UIReturnKeyDone;
  _albumCoverImage = [UIImageView new];
  _albumCoverImage.contentMode = UIViewContentModeScaleAspectFit;
  _albumCoverImage.image = [UIImage imageNamed:@"img_lose"];

  [self.view addSubview:_albumNameField];
  [self.view addSubview:_albumDescField];
  [self.view addSubview:_albumCoverImage];
  UITapGestureRecognizer *portraitTap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(editPortrait)];
  [self.view addGestureRecognizer:portraitTap];
  [_albumNameField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.right.equalTo(self.view).offset(-15);
    make.top.equalTo(self.view).offset(15);
    make.height.mas_equalTo(30);
  }];

  [_albumDescField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.right.equalTo(self.view).offset(-15);
    make.top.equalTo(_albumNameField.mas_bottom).offset(15);
    make.height.mas_equalTo(30);
  }];

  [_albumCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.right.equalTo(self.view).offset(-15);
    make.top.equalTo(_albumDescField.mas_bottom).offset(15);
    make.height.mas_equalTo(86);
  }];
}

- (void)rightBarButtonPressed:(id)sennder {
  [self showHUD];
  if (_coverImage) {
    [self uploadAlbumCover];
  } else {
    [self createNewAlbum];
  }
}

- (void)createNewAlbum {
  NSString *userId = [UserManager sharedInstance].userId;
  NSString *albumName = self.albumNameField.text;
  NSString *albumDesc = self.albumDescField.text;

  [[SWGIAlbumApi sharedAPI]
      createAlbumGetWithCompletionBlock:userId
                              albumName:albumName
                              albumDesc:albumDesc
                                  cover:_coverKey
                      completionHandler:^(SWGAlbumInfo *output,
                                          NSError *error) {
                        if ([self.delegate
                                respondsToSelector:@selector(newAlbum:)]) {
                          [self.delegate newAlbum:output];
                        }
                        [self hideAllHUDs];
                        [self.navigationController
                            popViewControllerAnimated:YES];
                      }];
}

- (void)uploadAlbumCover {
  QiniuFileUploadManager *manager = [[QiniuFileUploadManager alloc] init];
  [manager
      uploadImageToServce:_coverImage
       withCompletedBlock:^(NSString *key, NSString *hash, NSError *error) {
         if (key && !error) {
           _coverKey = key;
           [self createNewAlbum];
         } else {
           [self createNewAlbum];
         }
       }];
}

- (NSString *)uuidImage {
  CFUUIDRef puuid = CFUUIDCreate(nil);
  CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
  NSString *result =
      (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
  CFRelease(puuid);
  CFRelease(uuidString);
  return [NSString stringWithFormat:@"%@.png", result];
}

- (void)editPortrait {
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker dismissViewControllerAnimated:
              YES completion:^() {
    _coverImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _coverImage = [self imageByScalingToMaxSize:_coverImage];
    _albumCoverImage.image = _coverImage;
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

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
  if (sourceImage.size.width < ORIGINAL_MAX_WIDTH)
    return sourceImage;
  CGFloat btWidth = 0.0f;
  CGFloat btHeight = 0.0f;
  if (sourceImage.size.width > sourceImage.size.height) {
    btHeight = ORIGINAL_MAX_WIDTH;
    btWidth =
        sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
  } else {
    btWidth = ORIGINAL_MAX_WIDTH;
    btHeight =
        sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
  }
  CGSize targetSize = CGSizeMake(btWidth, btHeight);
  return [self imageByScalingAndCroppingForSourceImage:sourceImage
                                            targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage
                                          targetSize:(CGSize)targetSize {
  UIImage *newImage = nil;
  CGSize imageSize = sourceImage.size;
  CGFloat width = imageSize.width;
  CGFloat height = imageSize.height;
  CGFloat targetWidth = targetSize.width;
  CGFloat targetHeight = targetSize.height;
  CGFloat scaleFactor = 0.0;
  CGFloat scaledWidth = targetWidth;
  CGFloat scaledHeight = targetHeight;
  CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
  if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
    CGFloat widthFactor = targetWidth / width;
    CGFloat heightFactor = targetHeight / height;

    if (widthFactor > heightFactor)
      scaleFactor = widthFactor; // scale to fit height
    else
      scaleFactor = heightFactor; // scale to fit width
    scaledWidth = width * scaleFactor;
    scaledHeight = height * scaleFactor;

    // center the image
    if (widthFactor > heightFactor) {
      thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
    } else if (widthFactor < heightFactor) {
      thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
    }
  }
  UIGraphicsBeginImageContext(targetSize); // this will crop
  CGRect thumbnailRect = CGRectZero;
  thumbnailRect.origin = thumbnailPoint;
  thumbnailRect.size.width = scaledWidth;
  thumbnailRect.size.height = scaledHeight;

  [sourceImage drawInRect:thumbnailRect];

  newImage = UIGraphicsGetImageFromCurrentImageContext();
  if (newImage == nil)
    NSLog(@"could not scale image");

  // pop the context to get back to the default
  UIGraphicsEndImageContext();
        return newImage;
}

@end
