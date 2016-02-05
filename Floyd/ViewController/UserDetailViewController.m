//
//  UserDetailViewController.m
//  Floyd
//
//  Created by George She on 16/1/28.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "UserDetailViewController.h"
#import "XMDateSelectView.h"
#import "UIImageView+WebCache.h"
#import "TextEditViewController.h"
#import "SWGICustomerApi.h"
#import "VPImageCropperViewController.h"
#import "SWGIFileApi.h"
#import "QiniuFileUploadManager.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface UserDetailViewController () <
    UINavigationControllerDelegate, TextEditViewControllerDelegate,
    UIImagePickerControllerDelegate, UIActionSheetDelegate,
    VPImageCropperDelegate>
@property(nonatomic, strong) NITableViewActions *action;
@property(nonatomic, strong) UIView *tableHeaderView;
@property(nonatomic, strong) NSDateFormatter *formater;
@property(nonatomic, strong) UIImageView *avatarImage;
@end

@implementation UserDetailViewController
- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  _formater = [[NSDateFormatter alloc] init];
  _formater.dateFormat = @"yyyy-MM-dd";
  [self createHeaderView];
  [self refreshUI];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.rdv_tabBarController.tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.rdv_tabBarController.tabBarHidden = self.tabBarInitStatus;
}

- (void)createHeaderView {
  _tableHeaderView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 100)];
  _tableHeaderView.backgroundColor = [UIColor clearColor];
  _avatarImage = [[UIImageView alloc] init];
  _avatarImage.contentMode = UIViewContentModeScaleAspectFit;
  _avatarImage.clipsToBounds = YES;
  _avatarImage.layer.cornerRadius = 44 / 2;
  _avatarImage.layer.masksToBounds = YES;
  _avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
  _avatarImage.layer.borderWidth = 2.0;
  _avatarImage.layer.allowsEdgeAntialiasing = YES;
  [_avatarImage
      sd_setImageWithURL:[NSURL URLWithString:[UserManager sharedInstance]
                                                  .userAvatarUrl]
        placeholderImage:[UIImage imageNamed:@"avatar_user_man"]];
  UITapGestureRecognizer *portraitTap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(editPortrait)];
  [_tableHeaderView addGestureRecognizer:portraitTap];
  [_tableHeaderView addSubview:_avatarImage];
  [_avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(_tableHeaderView);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];

  UIView *line = [UIView new];
  line.backgroundColor = [UIColor ex_separatorLineColor];
  [_tableHeaderView addSubview:line];
  [line mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(_tableHeaderView).offset(15);
    make.bottom.equalTo(_tableHeaderView);
    make.height.mas_equalTo(0.5);
  }];
  self.tableView.tableHeaderView = _tableHeaderView;
}

- (void)refreshUI {
  self.action = [[NITableViewActions alloc] initWithTarget:self];
  NSMutableArray *tableContents = [NSMutableArray new];
  NSString *userName = [UserManager sharedInstance].userName
                           ? [UserManager sharedInstance].userName
                           : @"请编辑";
  NSString *userBirthday =
      [UserManager sharedInstance].userBirthday
          ? [_formater stringFromDate:[UserManager sharedInstance].userBirthday]
          : @"请编辑";
  NICellObject *userNameObj = [self.action
      attachToObject:[NISubtitleCellObject objectWithTitle:@"用户名"
                                                  subtitle:userName]
         tapSelector:@selector(tappedUserName)];
  [tableContents addObject:userNameObj];

  NICellObject *userBirthdayObj = [self.action
      attachToObject:[NISubtitleCellObject objectWithTitle:@"生日"
                                                  subtitle:userBirthday]
         tapSelector:@selector(tappedBirthday)];
  [tableContents addObject:userBirthdayObj];
  self.tableView.delegate = [self.action forwardingTo:self];
  [self setTableData:tableContents];
}

- (void)tappedUserName {
  TextEditViewController *vc =
      [[TextEditViewController alloc] initWithNibName:nil bundle:nil];
  vc.oldText = [UserManager sharedInstance].userName;
  vc.placeHolder = @"请编辑";
  vc.delegate = self;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)tappedBirthday {
  XMDateSelectView *dateSheet =
      [[XMDateSelectView alloc] initWithFrame:self.view.bounds];
  dateSheet.selectDate = [UserManager sharedInstance].userBirthday
                             ? [UserManager sharedInstance].userBirthday
                             : [NSDate new];
  dateSheet.selectedDateBlock = ^(NSDate *selectedDate) {
    [self changeBirthday:selectedDate];
  };
  [dateSheet show];
}

- (void)changeBirthday:(NSDate *)selectedDate {
  NSString *birthday = [_formater stringFromDate:selectedDate];
  [[SWGICustomerApi sharedAPI]
      updateUserBirthdayGetWithCompletionBlock:[UserManager sharedInstance]
                                                   .userId
                                  userBirthday:birthday
                             completionHandler:^(SWGUserInfo *output,
                                                 NSError *error) {
                               if (!error) {
                                 [UserManager sharedInstance].userBirthday =
                                     selectedDate;
                               } else {
                                 [self showError:error];
                               }
                               [self refreshUI];
                             }];
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

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController
         didFinished:(UIImage *)editedImage {
  _avatarImage.image = editedImage;
  [self uploadAvatar:editedImage];
  [cropperViewController dismissViewControllerAnimated:YES
                                            completion:^{
                                                // TO DO
                                            }];
}

- (void)imageCropperDidCancel:
        (VPImageCropperViewController *)cropperViewController {
  [cropperViewController dismissViewControllerAnimated:YES
                                            completion:^{
                                            }];
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
    UIImage *portraitImg =
        [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    portraitImg = [self imageByScalingToMaxSize:portraitImg];
    // present the cropper view controller
    VPImageCropperViewController *imgCropperVC =
        [[VPImageCropperViewController alloc]
              initWithImage:portraitImg
                  cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width,
                                       self.view.frame.size.width)
            limitScaleRatio:3.0];
    imgCropperVC.delegate = self;
    [self presentViewController:imgCropperVC
                       animated:YES
                     completion:^{
                         // TO DO
                     }];
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

#pragma TextEditViewControllerDelegate
- (void)TextEditVC:(TextEditViewController *)vc
       textChanged:(NSString *)newText {
  [[SWGICustomerApi sharedAPI]
      updateUserNameGetWithCompletionBlock:[UserManager sharedInstance].userId
                                  userName:newText
                         completionHandler:^(SWGUserInfo *output,
                                             NSError *error) {
                           if (!error) {
                             [UserManager sharedInstance].userName = newText;
                           } else {
                             [self showError:error];
                           }
                           [self refreshUI];
                         }];
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

#pragma Avatar Upload
- (void)uploadAvatar:(UIImage *)image {
  QiniuFileUploadManager *manager = [[QiniuFileUploadManager alloc] init];
  [manager
      uploadImageToServce:image
       withCompletedBlock:^(NSString *key, NSString *hash, NSError *error) {
         if (key && !error) {
           [self associateAvatar:key hash:hash];
         } else {
           [self showError:error];
         }
       }];
}

- (void)associateAvatar:(NSString *)avatarKey hash:(NSString *)avatarHash {
  [[SWGICustomerApi sharedAPI]
      updateUserAvatarGetWithCompletionBlock:[UserManager sharedInstance].userId
                                   avatarKey:avatarKey
                                  avatarHash:avatarHash
                           completionHandler:^(SWGUserInfo *output,
                                               NSError *error) {
                             if (!error) {
                               [UserManager sharedInstance].userAvatar =
                                   avatarKey;
                               [UserManager sharedInstance].userAvatarHash =
                                   avatarHash;
                             } else {
                               [self showError:error];
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
@end
