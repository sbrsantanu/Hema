//
//  WebserviceHelper.h
//  WhatGym
//
//  Created by Vishal Lohia on 14/03/14.
//  Copyright (c) 2014 AND Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

enum _webserviceMethodType
{
    WEBSERVICE_METHOD_TYPE_GET,
    WEBSERVICE_METHOD_TYPE_POST
};
typedef enum _webserviceMethodType WebserviceMethodType;

@interface WebserviceInputParameter : NSObject

@property (nonatomic, copy) NSString *webserviceRelativePath;

@property (nonatomic, strong) NSMutableDictionary *dict_getParameters;
@property (nonatomic, strong) NSMutableDictionary *dict_postParameters;
@property (nonatomic, strong) NSMutableDictionary *dict_httpHeaders;
@property (nonatomic, strong) NSData *jsonOrXMLData;
@property (nonatomic, assign) WebserviceMethodType serviceMethodType;
@property (nonatomic, assign) BOOL shouldShowLoadingActivity;
@property (nonatomic, assign) BOOL shouldShowNoNetworkAlert;

@end

typedef void (^successBlock)(id response);
typedef void (^errorBlock)(NSError *error);
typedef void (^complitionHandler)(id ,NSError *);
typedef void (^successJSONBlock)(id response);
typedef void (^errorJSONBlock)(NSError *error, id JSON);

@interface WebserviceHelper : NSObject
+(void)postPath:(NSString*)pathURL parameters:(NSDictionary*)paramsDict
        success:(successBlock)blckSucess error:(errorBlock)blkError;

+(void) callWebserviceWithInputParameter:(WebserviceInputParameter *)inputParameter
                                 success:(successBlock)blkSuccess error:(errorBlock)blkError;

+(void) callJSONWebServiceWithInputParameter:(WebserviceInputParameter *)inputParameter
                                     success:(successJSONBlock)blkSuccess
                                       error:(errorJSONBlock)blkError;

+(void) callMutualRequestWithInputParameter:(WebserviceInputParameter *)inputParameter
                                    success:(successJSONBlock)blkSuccess
                                      error:(errorJSONBlock)blkError;

+(void)callSoapWebserviceWithInputParameter:(WebserviceInputParameter *)inputParameter andSoapString:(NSString *)soapString  success:(successBlock)blkSuccess
                         error:(errorBlock)blkError complitionHandler:(complitionHandler)complitionBlock;


@end
