#import "SWGCustomerApi.h"
#import "SWGQueryParamCollection.h"
#import "SWGUserInfo.h"
#import "SWGError.h"


@interface SWGCustomerApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation SWGCustomerApi

static SWGCustomerApi* singletonAPI = nil;

#pragma mark - Initialize methods

- (id) init {
    self = [super init];
    if (self) {
        SWGConfiguration *config = [SWGConfiguration sharedConfig];
        if (config.apiClient == nil) {
            config.apiClient = [[SWGApiClient alloc] init];
        }
        self.apiClient = config.apiClient;
        self.defaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id) initWithApiClient:(SWGApiClient *)apiClient {
    self = [super init];
    if (self) {
        self.apiClient = apiClient;
        self.defaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -

+(SWGCustomerApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[SWGCustomerApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(SWGCustomerApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[SWGCustomerApi alloc] init];
    }
    return singletonAPI;
}

-(void) addHeader:(NSString*)value forKey:(NSString*)key {
    [self.defaultHeaders setValue:value forKey:key];
}

-(void) setHeaderValue:(NSString*) value
           forKey:(NSString*)key {
    [self.defaultHeaders setValue:value forKey:key];
}

-(unsigned long) requestQueueSize {
    return [SWGApiClient requestQueueSize];
}

#pragma mark - Api Methods

///
/// associate user information
/// associate information.
///  @param wbUserId 
///
///  @returns SWGUserInfo*
///
-(NSNumber*) associateUserWithWeiboIdGetWithCompletionBlock: (NSString*) wbUserId
        
        completionHandler: (void (^)(SWGUserInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'wbUserId' is set
    if (wbUserId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `wbUserId` when calling `associateUserWithWeiboIdGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/associateUserWithWeiboId"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (wbUserId != nil) {
        
        queryParams[@"wbUserId"] = wbUserId;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"SWGUserInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGUserInfo*)data, error);
              }
          ];
}

///
/// update user avatar
/// user information.
///  @param userId 
///
///  @param avatarKey 
///
///  @param avatarHash 
///
///  @returns SWGUserInfo*
///
-(NSNumber*) updateUserAvatarGetWithCompletionBlock: (NSString*) userId
         avatarKey: (NSString*) avatarKey
         avatarHash: (NSString*) avatarHash
        
        completionHandler: (void (^)(SWGUserInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `updateUserAvatarGet`"];
    }
    
    // verify the required parameter 'avatarKey' is set
    if (avatarKey == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `avatarKey` when calling `updateUserAvatarGet`"];
    }
    
    // verify the required parameter 'avatarHash' is set
    if (avatarHash == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `avatarHash` when calling `updateUserAvatarGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/updateUserAvatar"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (userId != nil) {
        
        queryParams[@"userId"] = userId;
    }
    if (avatarKey != nil) {
        
        queryParams[@"avatarKey"] = avatarKey;
    }
    if (avatarHash != nil) {
        
        queryParams[@"avatarHash"] = avatarHash;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"SWGUserInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGUserInfo*)data, error);
              }
          ];
}

///
/// update user birthday
/// user information.
///  @param userId 
///
///  @param userBirthday 
///
///  @returns SWGUserInfo*
///
-(NSNumber*) updateUserBirthdayGetWithCompletionBlock: (NSString*) userId
         userBirthday: (NSString*) userBirthday
        
        completionHandler: (void (^)(SWGUserInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `updateUserBirthdayGet`"];
    }
    
    // verify the required parameter 'userBirthday' is set
    if (userBirthday == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userBirthday` when calling `updateUserBirthdayGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/updateUserBirthday"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (userId != nil) {
        
        queryParams[@"userId"] = userId;
    }
    if (userBirthday != nil) {
        
        queryParams[@"userBirthday"] = userBirthday;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"SWGUserInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGUserInfo*)data, error);
              }
          ];
}

///
/// update user name
/// user information.
///  @param userId 
///
///  @param userName 
///
///  @returns SWGUserInfo*
///
-(NSNumber*) updateUserNameGetWithCompletionBlock: (NSString*) userId
         userName: (NSString*) userName
        
        completionHandler: (void (^)(SWGUserInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `updateUserNameGet`"];
    }
    
    // verify the required parameter 'userName' is set
    if (userName == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userName` when calling `updateUserNameGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/updateUserName"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (userId != nil) {
        
        queryParams[@"userId"] = userId;
    }
    if (userName != nil) {
        
        queryParams[@"userName"] = userName;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"SWGUserInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGUserInfo*)data, error);
              }
          ];
}

///
/// get user information
/// user information.
///  @param userId 
///
///  @returns SWGUserInfo*
///
-(NSNumber*) userByIdGetWithCompletionBlock: (NSString*) userId
        
        completionHandler: (void (^)(SWGUserInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `userByIdGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/userById"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (userId != nil) {
        
        queryParams[@"userId"] = userId;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"SWGUserInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGUserInfo*)data, error);
              }
          ];
}

///
/// get user information
/// user information.
///  @param wbUserId 
///
///  @returns SWGUserInfo*
///
-(NSNumber*) userByWeiboIdGetWithCompletionBlock: (NSString*) wbUserId
        
        completionHandler: (void (^)(SWGUserInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'wbUserId' is set
    if (wbUserId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `wbUserId` when calling `userByWeiboIdGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/userByWeiboId"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (wbUserId != nil) {
        
        queryParams[@"wbUserId"] = wbUserId;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *files = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithCompletionBlock: resourcePath
                                               method: @"GET"
                                           pathParams: pathParams
                                          queryParams: queryParams
                                           formParams: formParams
                                                files: files
                                                 body: bodyParam
                                         headerParams: headerParams
                                         authSettings: authSettings
                                   requestContentType: requestContentType
                                  responseContentType: responseContentType
                                         responseType: @"SWGUserInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGUserInfo*)data, error);
              }
          ];
}



@end
