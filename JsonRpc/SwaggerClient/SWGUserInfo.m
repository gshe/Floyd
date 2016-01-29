#import "SWGUserInfo.h"

@implementation SWGUserInfo

- (instancetype)init {
  self = [super init];

  if (self) {
    // initalise property's default value, if any
    
  }

  return self;
}

/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"_id": @"_id", @"birthday": @"birthday", @"name": @"name", @"weiboId": @"weiboId", @"weiboToken": @"weiboToken", @"avatarKey": @"avatarKey", @"avatarHash": @"avatarHash", @"created": @"created", @"modified": @"modified" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"_id", @"birthday", @"name", @"weiboId", @"weiboToken", @"avatarKey", @"avatarHash", @"created", @"modified"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

/**
 * Gets the string presentation of the object.
 * This method will be called when logging model object using `NSLog`.
 */
- (NSString *)description {
    return [[self toDictionary] description];
}

@end
