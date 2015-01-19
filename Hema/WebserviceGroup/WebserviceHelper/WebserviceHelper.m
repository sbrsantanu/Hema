//
//  WebserviceHelper.m
//  WhatGym
//
//  Created by Vishal Lohia on 14/03/14.
//  Copyright (c) 2014 MobileProgramming. All rights reserved.
//

#import "WebserviceHelper.h"
#import "MPMobileProgrammingClient.h"
#import "AFNetworking.h"
#import "MPApplicationGlobalConstants.h"

@implementation WebserviceInputParameter

-(id) init
{
    self = [super init];
    
    if (self) {
        self.shouldShowLoadingActivity = YES;
        self.shouldShowNoNetworkAlert = YES;
    }
    
    return self;
}

-(NSMutableDictionary *) dict_postParameters
{
        if (!_dict_postParameters)
            _dict_postParameters = [[NSMutableDictionary alloc] init];
    
    return _dict_postParameters;
}

-(NSMutableDictionary *) dict_getParameters
{
    if (!_dict_getParameters)
        _dict_getParameters = [[NSMutableDictionary alloc] init];
    
    return _dict_getParameters;
}

-(NSMutableDictionary *) dict_httpHeaders
{
    if (_dict_httpHeaders == nil)
        _dict_httpHeaders = [Get_HTTP_HEADERS_Dictionary() mutableCopy];
    
    return _dict_httpHeaders;
}

-(void) dealloc
{
    _dict_httpHeaders = nil;
    _dict_getParameters = nil;
    _dict_postParameters = nil;
}

@end


@implementation WebserviceHelper

+(void) addHeadersFromInputParam:(WebserviceInputParameter *)inputParameter
{
//#if kAND_WS_ENABLE_HEADERS == 1
    
    [inputParameter.dict_httpHeaders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isEqual:[NSNull null]] && obj != nil) {
            [[MPMobileProgrammingClient sharedInstance] setDefaultHeader:key
                                                                   value:obj];
        }
    }];
    
    [MPMobileProgrammingClient sharedInstance].parameterEncoding = AFFormURLParameterEncoding;
//#endif

}

+(void)postPath:(NSString*)pathURL parameters:(NSDictionary*)paramsDict
        success:(successBlock)blckSucess error:(errorBlock)blkError
{
   __block successBlock localBlock = [blckSucess copy];
   __block errorBlock localErrorBlock = [blkError copy];
    
    if (!IS_NETWORK_AVAILABLE())
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            SHOW_NETWORK_ERROR_ALERT();
        });
        
        NSError *error = [NSError noNetworkError];
        localErrorBlock(error);
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        SHOW_LOADING();
    });
    
    [[MPMobileProgrammingClient sharedInstance] postPath:pathURL parameters:paramsDict success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        localBlock(jsonObject);
        localBlock = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            HIDE_LOADING();
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        localErrorBlock(error);
        localErrorBlock = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            HIDE_LOADING();
        });
    }];
}

+(void) callJSONWebServiceWithInputParameter:(WebserviceInputParameter *)inputParameter
                                     success:(successJSONBlock)blkSuccess
                                       error:(errorJSONBlock)blkError
{
    __block successJSONBlock localBlock = [blkSuccess copy];
    __block errorJSONBlock localErrorBlock = [blkError copy];
    
    @try {
        
        if (!IS_NETWORK_AVAILABLE())
        {
            localErrorBlock([NSError noNetworkError],nil);
            localErrorBlock = nil;
            localBlock = nil;
        }
        
        if (inputParameter.shouldShowLoadingActivity)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                SHOW_LOADING();
            });
        }
        
        [self addHeadersFromInputParam:inputParameter];
        
        NSString *webMethod = (inputParameter.serviceMethodType == WEBSERVICE_METHOD_TYPE_POST
                               ? @"POST" : @"GET");
        
         NSMutableURLRequest *request = [[MPMobileProgrammingClient sharedInstance] requestWithMethod:webMethod path:inputParameter.webserviceRelativePath
                            parameters:inputParameter.dict_postParameters];
        
         AFHTTPRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
             
             localBlock(JSON);
             localBlock = nil;
             
             if (inputParameter.shouldShowLoadingActivity) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     HIDE_LOADING();
                 });
                 
             }
             
         } failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON) {
             
             if (inputParameter.shouldShowLoadingActivity) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     HIDE_LOADING();
                 });
             }

             localErrorBlock(error,JSON);
             localErrorBlock = nil;
             
         }];
        
         [operation start];
    }
    @catch (NSException *exception) {
        if (inputParameter.shouldShowLoadingActivity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                HIDE_LOADING();
            });
        }
        
        localErrorBlock([exception exceptionError],nil);
        localErrorBlock = nil;
        localBlock = nil;
    }
    @finally {
        
    }

}


+(void) callWebserviceWithInputParameter:(WebserviceInputParameter *)inputParameter
                                 success:(successBlock)blkSuccess
                                   error:(errorBlock)blkError
{
    __block successBlock localBlock = [blkSuccess copy];
    __block errorBlock localErrorBlock = [blkError copy];

    @try {
        
        if (!IS_NETWORK_AVAILABLE())
        {
            localErrorBlock([NSError noNetworkError]);
            localErrorBlock = nil;
            localBlock = nil;
            return;
        }
        
        if (inputParameter.shouldShowLoadingActivity)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                SHOW_LOADING();
            });
        }
       
        [self addHeadersFromInputParam:inputParameter];
        
        switch (inputParameter.serviceMethodType)
        {
            case WEBSERVICE_METHOD_TYPE_GET:
            {
                [[MPMobileProgrammingClient sharedInstance] getPath:inputParameter.webserviceRelativePath
                                              parameters:inputParameter.dict_getParameters
                                                 success:^(AFHTTPRequestOperation *operation, id jsonObject) {
                                                     localBlock(jsonObject);
                                                     localBlock = nil;
                                                     
                                                     if (inputParameter.shouldShowLoadingActivity) {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             HIDE_LOADING();
                                                         });
                                                     }
                                                     
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     
                                                     if (inputParameter.shouldShowLoadingActivity) {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             HIDE_LOADING();
                                                         });
                                                     }
                                                     
                                                     localErrorBlock(error);
                                                     localErrorBlock = nil;
                                                     localBlock = nil;
                                                 }];
            }
                break;
            case WEBSERVICE_METHOD_TYPE_POST:
            {
                [[MPMobileProgrammingClient sharedInstance] postPath:inputParameter.webserviceRelativePath
                                              parameters:inputParameter.dict_postParameters
                                                 success:^(AFHTTPRequestOperation *operation, id jsonObject) {
                                                     localBlock(jsonObject);
                                                     localBlock = nil;
                                                     localErrorBlock = nil;
                                                     
                                                     if (inputParameter.shouldShowLoadingActivity) {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             HIDE_LOADING();
                                                         });
                                                     }
                                                     
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     
                                                     if (inputParameter.shouldShowLoadingActivity) {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             HIDE_LOADING();
                                                         });
                                                     }

                                                     localErrorBlock(error);
                                                     localErrorBlock = nil;
                                                     localBlock = nil;
                                                 }];
            }
                break;
            default:
                break;
        }
        
    }
    @catch (NSException *exception) {
        
        if (inputParameter.shouldShowLoadingActivity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                HIDE_LOADING();
            });
        }
        
        localErrorBlock([exception exceptionError]);
        localErrorBlock = nil;
        localBlock = nil;
        
    }
    @finally {
    }
}

+(void) callMutualRequestWithInputParameter:(WebserviceInputParameter *)inputParameter
                                    success:(successJSONBlock)blkSuccess
                                      error:(errorJSONBlock)blkError
{
    __block successJSONBlock localBlock = [blkSuccess copy];
    __block errorJSONBlock localErrorBlock = [blkError copy];
    
    @try {
        
        if (!IS_NETWORK_AVAILABLE())
        {
            localErrorBlock([NSError noNetworkError],nil);
            localErrorBlock = nil;
            localBlock = nil;
        }
        
        if (inputParameter.shouldShowLoadingActivity)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                SHOW_LOADING();
            });
        }
        
        NSString *webMethod = (inputParameter.serviceMethodType == WEBSERVICE_METHOD_TYPE_POST
                               ? @"POST" : @"GET");
        
        NSMutableDictionary *dictHeaders = [NSMutableDictionary dictionary];
        
        [inputParameter.dict_httpHeaders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![obj isEqual:[NSNull null]] && obj != nil) {
                [dictHeaders setObject:obj forKey:key];
            }
        }];
        
        [dictHeaders setObject:@"iphone" forKey:@"User-Agent"];
        [dictHeaders setObject:[NSString stringWithFormat:@"%lu",(unsigned long)inputParameter.jsonOrXMLData.length] forKey:@"Content-Length"];
        
        NSMutableURLRequest *r = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[kAPI_BASE_URL stringByAppendingString:inputParameter.webserviceRelativePath]]];
        [r setHTTPMethod:webMethod];
        [r setAllHTTPHeaderFields:dictHeaders];
        [r setHTTPBody:inputParameter.jsonOrXMLData];
        [r setTimeoutInterval:30];
        [NSURLConnection sendAsynchronousRequest:r
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   
                                   if (connectionError)
                                   {
                                       if (inputParameter.shouldShowLoadingActivity) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               HIDE_LOADING();
                                           });
                                       }
                                       
                                       localErrorBlock(connectionError,data);
                                       localErrorBlock = nil;
                                       return ;
                                   }
                                   
                                   localBlock(response);
                                   localBlock = nil;
                                   
                                   if (inputParameter.shouldShowLoadingActivity) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           HIDE_LOADING();
                                       });
                                   }
                               }];
        
    }
    @catch (NSException *exception) {
        if (inputParameter.shouldShowLoadingActivity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                HIDE_LOADING();
            });
        }
        
        localErrorBlock([exception exceptionError],nil);
        localErrorBlock = nil;
        localBlock = nil;
    }
    @finally { }
}



+(void)callSoapWebserviceWithInputParameter:(WebserviceInputParameter *)inputParameter andSoapString:(NSString *)soapString  success:(successBlock)blkSuccess
                         error:(errorBlock)blkError complitionHandler:(complitionHandler)complitionBlock
{
    __block successJSONBlock localBlock = [blkSuccess copy];
    __block errorJSONBlock localErrorBlock = [blkError copy];
    @try
    {
        if (!IS_NETWORK_AVAILABLE())
        {
            localErrorBlock([NSError noNetworkError],nil);
            localErrorBlock = nil;
            localBlock = nil;
        }
        
        if (inputParameter.shouldShowLoadingActivity)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                SHOW_LOADING();
            });
        }
        
        NSString *webMethod = (inputParameter.serviceMethodType == WEBSERVICE_METHOD_TYPE_POST
                               ? @"POST" : @"GET");
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",inputParameter.webserviceRelativePath]];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:URL];
        [theRequest addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPMethod:webMethod];
        [theRequest setHTTPBody: [soapString dataUsingEncoding:NSUTF8StringEncoding]];
      
        
        [NSURLConnection sendAsynchronousRequest:theRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError)
                                   {
                                       if (inputParameter.shouldShowLoadingActivity) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               HIDE_LOADING();
                                           });
                                       }
                                       
                                       localErrorBlock(connectionError,data);
                                       localErrorBlock = nil;
                                       return ;
                                   }
                                   
                                   localBlock(data);
                                   localBlock = nil;
                                   
                                   if (inputParameter.shouldShowLoadingActivity) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           HIDE_LOADING();
                                       });
                                   }
                               }];
       
        
    }
    @catch (NSException *exception) {
        if (inputParameter.shouldShowLoadingActivity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                HIDE_LOADING();
            });
        }
        
        localErrorBlock([exception exceptionError],nil);
        localErrorBlock = nil;
        localBlock = nil;
    }
    @finally { }
}
@end
