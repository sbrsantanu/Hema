//
//  WebserviceProtocol.m
//  Hema
//
//  Created by Mac on 05/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "WebserviceProtocol.h"
#import "SOAPEnvelope.h"
#import "UrlParameterString.h"
#import "WebserviceHelper.h"
#import "NSError+CustomErrors.h"

@implementation WebserviceProtocol
@synthesize delegate = _delegate;

-(id)initWithParamObject:(NSArray *)DataParamObject
             ValueObject:(NSArray *)DataValueObject
            UrlParameter:(NSString *)DataUrlParameter
{
    NSLog(@"Webservice call");
    self = [super init];
    if (self) {
        self.ParamArray = DataParamObject;
        self.ValueArray = DataValueObject;
        self.ParamUrl   = DataUrlParameter;
    }
    [self AccessWebservice];
    return self;
}


-(void)AccessWebservice
{
    if ([self.ParamArray count] != [self.ValueArray count]) {
        
        [self WebaccessCompleteWithRetrnedErrorObject:NSError.ParamCountError];
    } else {

        WebserviceInputParameter *inputParam = [[WebserviceInputParameter alloc] init];
        inputParam.webserviceRelativePath = [self GenerateURLFromString];
        inputParam.serviceMethodType = WEBSERVICE_METHOD_TYPE_POST;
        
        for (int I = 0; I<[self.ParamArray count];I++) {
            [inputParam.dict_postParameters setObject:[self.ValueArray objectAtIndex:I]
                                               forKey:[self.ParamArray objectAtIndex:I]];
        }
        
        
        NSLog(@"inputParam.dict_postParameters === %@ ++++++++++++ url is +++++++++ %@",inputParam.dict_postParameters,self.ParamUrl);
        typedef void (^successBlock)(id response);
        
      [WebserviceHelper callWebserviceWithInputParameter:inputParam
                                                       success:^(id response) {                                                           
                                                           
                                                           [self WebaccessCompleteWithRetrnedSuccessObject:response];
                                                           
                                                       } error:^(NSError *error) {
                                                           [self WebaccessCompleteWithRetrnedErrorObject:error];
                                                       }];
      /*
        
       [WebserviceHelper callMutualRequestWithInputParameter:inputParam
                                                   success:^(id response) {
                                                       if (response) {
                                                           [self WebaccessCompleteWithRetrnedSuccessObject:response];
                                                       }
                                                   } error:^(NSError *error) {
                                                       [self WebaccessCompleteWithRetrnedErrorObject:error];
                                                   }];
       */
    }
}

-(void)WebaccessCompleteWithRetrnedSuccessObject:(NSData *)ParamSuccessObject
{
    if ([ParamSuccessObject isKindOfClass:[NSData class]]) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:ParamSuccessObject
                                                             options:kNilOptions
                                                               error:&error];
        
        [_delegate RetunWebserviceDataWithSuccess:self ObjectCarrier:json];
    }
}

-(void)WebaccessCompleteWithRetrnedErrorObject:(NSError *)ParamErrorObject
{
    [_delegate RetunWebserviceDataWithError:self ObjectCarrier:ParamErrorObject];
}

-(NSString *)GenerateURLFromString
{
    NSString *URLstring = [NSString stringWithFormat:@"%@%@",UrlParameterString.GlobalURL,self.ParamUrl];
    return URLstring;
}

@end
