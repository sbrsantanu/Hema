//
//  WebserviceProtocol.h
//  Hema
//
//  Created by Mac on 05/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WebserviceProtocol;

@protocol WebserviceProtocolDelegate <NSObject>

@required

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier;
-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier;

@end

@interface WebserviceProtocol : NSObject
{
    __weak id <WebserviceProtocolDelegate> _delegate;
}
@property (nonatomic, retain) NSArray *ParamArray;
@property (nonatomic, retain) NSArray *ValueArray;
@property (nonatomic, retain) NSString *ParamUrl;

@property (nonatomic, weak) id <WebserviceProtocolDelegate> delegate;

-(id)initWithParamObject:(NSArray *)DataParamObject
             ValueObject:(NSArray *)DataValueObject
            UrlParameter:(NSString *)DataUrlParameter;

-(void)AccessWebservice;

@end
