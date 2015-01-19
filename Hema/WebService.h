//
//  WebService.h
//  Post
//
//  Created by Rodrigo Cavalcante on 5/29/14.
//  Copyright (c) 2014 Rodrigo Cavalcante. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceDelegate <NSObject>

@optional
-(void)finishWithResponse:(NSDictionary *)response forMethod:(NSString *)method;
-(void)startRequestForMethod:(NSString *)method;
-(void)startRequest;
-(void)finishRequest;
-(void)error:(NSError *)error;
-(void)invalideStatusCode:(int )statusCode andResponse:(NSURLResponse *)response;
@end

@interface WebService : NSObject
{
    id<WebServiceDelegate>delegate;
}

@property(strong, nonatomic) NSString *method;
@property(strong, nonatomic) NSMutableDictionary *data;
@property(strong,nonatomic) NSURL *url;
@property(nonatomic) BOOL rawJson;
@property(nonatomic,retain)id<WebServiceDelegate>delegate;

-(id)init;
-(id)initWithURL:(NSURL *)URL;
-(id)initWithURL:(NSURL *)URL andDictionary:(NSMutableDictionary *)dictionary;
-(void)addObject:(id)object forKey:(NSString *)key;
-(void)request;
@end

