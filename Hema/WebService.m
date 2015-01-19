//
//  WebService.m
//  Post
//
//  Created by Rodrigo Cavalcante on 5/29/14.
//  Copyright (c) 2014 Rodrigo Cavalcante. All rights reserved.
//

#import "WebService.h"

@implementation WebService

@synthesize url,data,delegate,rawJson;

-(id)init
{
    if (self = [super init]) {
        self.data = [[NSMutableDictionary alloc] init];
        self.rawJson = YES;
    }
    
    return self;
}

-(id)initWithURL:(NSURL *)URL
{
    if (self = [super init]) {
        self.data = [[NSMutableDictionary alloc] init];
        self.url = URL;
        self.rawJson = YES;
    }
    
    return self;
}

-(id)initWithURL:(NSURL *)URL andDictionary:(NSMutableDictionary *)dictionary
{
    if (self = [super init]) {
        self.data = dictionary;
        
        self.method = @"no method found";
        if(![[self.data objectForKey:@"method"] isEqualToString:@""])
            self.method = [self.data objectForKey:@"method"];
        
        self.url = URL;
        self.rawJson = YES;
    }
    
    return self;
}

-(void)addObject:(id)object forKey:(NSString *)key;
{
    if(self.data)
        [self.data setObject:object forKey:key];
}

-(void)request
{
    if ([delegate respondsToSelector:@selector(startRequest)]) {
        [delegate startRequest];
    }
    
    if ([delegate respondsToSelector:@selector(startRequestForMethod:)]) {
        [delegate startRequestForMethod:self.method];
    }
    
    if (self.rawJson)
        [self requestRawJson];
    else
        [self requestPost];
}

-(void)requestRawJson{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSError *error = NULL;
        NSURLResponse *response = NULL;
        
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:self.data options:0 error:NULL];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:jsondata];
        
        NSData *dados = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        
        if(error != nil)
        {
            [self performSelectorOnMainThread:@selector(delegateError:) withObject:error waitUntilDone:NO];
        }
        else
        {
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = [HTTPResponse statusCode];
            if(statusCode != 200)
            {
                [self performSelectorOnMainThread:@selector(delegateInvalideStatusCodeAndResponse:) withObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)statusCode],response, nil] waitUntilDone:NO];
            }
            else
            {
                NSDictionary *dictionary = [[NSDictionary alloc] init];
                
                Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
                
                if (jsonSerializationClass) {
                    NSError *jsonParssingError = nil;
                    if (dados != nil) {
                        dictionary = [NSJSONSerialization JSONObjectWithData:dados options:0 error:&jsonParssingError];
                        if(jsonParssingError != nil)
                            NSLog(@"Error: %@",jsonParssingError.description);
                    }
                    else
                        NSLog(@"Returned data is nil.");
                }
                else
                    NSLog(@"jsonSerializationClass not found.");
                
                [self performSelectorOnMainThread:@selector(delegateFinishRequest) withObject:nil waitUntilDone:NO];
                
                [self performSelectorOnMainThread:@selector(delegateFinishRequestWithResponse:) withObject:dictionary waitUntilDone:NO];
            }
        }
    });
}


-(void)requestPost{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSError *error = NULL;
        NSURLResponse *response = NULL;
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        [req setHTTPMethod:@"POST"];
        
        NSString *postString = @"";
        
        for (NSString *key in [self.data allKeys]) {
            postString = [postString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[self.data objectForKey:key]]];
        }
        postString = [postString substringToIndex:[postString length] - 1];
        
        [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *dados = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        
        NSString *stringDados = [[NSString alloc] initWithData:dados encoding:NSUTF8StringEncoding];
        
        if(error != nil)
        {
            [self performSelectorOnMainThread:@selector(delegateError:) withObject:error waitUntilDone:NO];
        }
        else
        {
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = [HTTPResponse statusCode];
            if(statusCode != 200)
            {
                [self performSelectorOnMainThread:@selector(delegateInvalideStatusCodeAndResponse:) withObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)statusCode],response, nil] waitUntilDone:NO];
            }
            else
            {
                NSDictionary *dictionary = [[NSDictionary alloc] init];
                Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
                
                if (jsonSerializationClass) {
                    NSError *jsonParssingError = nil;
                    if (dados != nil) {
                        dictionary = [NSJSONSerialization JSONObjectWithData:[stringDados dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonParssingError];
                        if(jsonParssingError != nil)
                            NSLog(@"Error: %@",jsonParssingError.description);
                    }
                    else
                        NSLog(@"Returned data is nil.");
                }
                else
                    NSLog(@"jsonSerializationClass not found.");
                
                [self performSelectorOnMainThread:@selector(delegateFinishRequest) withObject:nil waitUntilDone:NO];
                
                [self performSelectorOnMainThread:@selector(delegateFinishRequestWithResponse:) withObject:dictionary waitUntilDone:NO];
            }
        }
    });
}

-(void)delegateInvalideStatusCodeAndResponse:(NSMutableArray *)response
{
    if ([delegate respondsToSelector:@selector(invalideStatusCode:andResponse:)]) {
        [delegate invalideStatusCode:[[response objectAtIndex:0] intValue] andResponse:[response objectAtIndex:1]];
    }
}

-(void)delegateError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(error:)]) {
        [delegate error:error];
    }
}

-(void)delegateFinishRequest
{
    if ([delegate respondsToSelector:@selector(finishRequest)]) {
        [delegate finishRequest];
    }
}

-(void)delegateFinishRequestWithResponse:(NSMutableDictionary *)response
{
    if ([delegate respondsToSelector:@selector(finishWithResponse:forMethod:)]) {
        [delegate finishWithResponse:response forMethod:self.method];
    }
}


@end
