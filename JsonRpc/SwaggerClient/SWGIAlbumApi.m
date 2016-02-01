#import "SWGIAlbumApi.h"
#import "SWGQueryParamCollection.h"
#import "SWGPhotoInfo.h"
#import "SWGError.h"
#import "SWGAlbumInfo.h"


@interface SWGIAlbumApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation SWGIAlbumApi

static SWGIAlbumApi* singletonAPI = nil;

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

+(SWGIAlbumApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[SWGIAlbumApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(SWGIAlbumApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[SWGIAlbumApi alloc] init];
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
/// add photo to album
/// add photo to album.
///  @param albumId 
///
///  @param photoName 
///
///  @param photoUrl 
///
///  @returns SWGPhotoInfo*
///
-(NSNumber*) addPhotoToAlbumGetWithCompletionBlock: (NSString*) albumId
         photoName: (NSString*) photoName
         photoUrl: (NSString*) photoUrl
        
        completionHandler: (void (^)(SWGPhotoInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'albumId' is set
    if (albumId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `albumId` when calling `addPhotoToAlbumGet`"];
    }
    
    // verify the required parameter 'photoName' is set
    if (photoName == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `photoName` when calling `addPhotoToAlbumGet`"];
    }
    
    // verify the required parameter 'photoUrl' is set
    if (photoUrl == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `photoUrl` when calling `addPhotoToAlbumGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/addPhotoToAlbum"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (albumId != nil) {
        
        queryParams[@"albumId"] = albumId;
    }
    if (photoName != nil) {
        
        queryParams[@"photoName"] = photoName;
    }
    if (photoUrl != nil) {
        
        queryParams[@"photoUrl"] = photoUrl;
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
                                         responseType: @"SWGPhotoInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGPhotoInfo*)data, error);
              }
          ];
}

///
/// get album info by id
/// album information.
///  @param albumId 
///
///  @returns SWGAlbumInfo*
///
-(NSNumber*) albumByIdGetWithCompletionBlock: (NSString*) albumId
        
        completionHandler: (void (^)(SWGAlbumInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'albumId' is set
    if (albumId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `albumId` when calling `albumByIdGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/albumById"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (albumId != nil) {
        
        queryParams[@"albumId"] = albumId;
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
                                         responseType: @"SWGAlbumInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGAlbumInfo*)data, error);
              }
          ];
}

///
/// get all user albums
/// album information.
///  @param userId 
///
///  @returns NSArray<SWGAlbumInfo>*
///
-(NSNumber*) allAlbumsGetWithCompletionBlock: (NSString*) userId
        
        completionHandler: (void (^)(NSArray<SWGAlbumInfo>* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `allAlbumsGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/allAlbums"];

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
                                         responseType: @"NSArray<SWGAlbumInfo>*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((NSArray<SWGAlbumInfo>*)data, error);
              }
          ];
}

///
/// create a new album
/// create album.
///  @param userId 
///
///  @param albumName 
///
///  @param albumDesc 
///
///  @param cover 
///
///  @returns SWGAlbumInfo*
///
-(NSNumber*) createAlbumGetWithCompletionBlock: (NSString*) userId
         albumName: (NSString*) albumName
         albumDesc: (NSString*) albumDesc
         cover: (NSString*) cover
        
        completionHandler: (void (^)(SWGAlbumInfo* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `createAlbumGet`"];
    }
    
    // verify the required parameter 'albumName' is set
    if (albumName == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `albumName` when calling `createAlbumGet`"];
    }
    
    // verify the required parameter 'albumDesc' is set
    if (albumDesc == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `albumDesc` when calling `createAlbumGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/createAlbum"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (userId != nil) {
        
        queryParams[@"userId"] = userId;
    }
    if (albumName != nil) {
        
        queryParams[@"albumName"] = albumName;
    }
    if (albumDesc != nil) {
        
        queryParams[@"albumDesc"] = albumDesc;
    }
    if (cover != nil) {
        
        queryParams[@"cover"] = cover;
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
                                         responseType: @"SWGAlbumInfo*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((SWGAlbumInfo*)data, error);
              }
          ];
}

///
/// get all photos in album
/// all photos in album.
///  @param albumId 
///
///  @returns NSArray<SWGPhotoInfo>*
///
-(NSNumber*) photosInAlbumGetWithCompletionBlock: (NSString*) albumId
        
        completionHandler: (void (^)(NSArray<SWGPhotoInfo>* output, NSError* error))completionBlock { 
        

    
    // verify the required parameter 'albumId' is set
    if (albumId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `albumId` when calling `photosInAlbumGet`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/photosInAlbum"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (albumId != nil) {
        
        queryParams[@"albumId"] = albumId;
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
                                         responseType: @"NSArray<SWGPhotoInfo>*"
                                      completionBlock: ^(id data, NSError *error) {
                  
                  completionBlock((NSArray<SWGPhotoInfo>*)data, error);
              }
          ];
}



@end
