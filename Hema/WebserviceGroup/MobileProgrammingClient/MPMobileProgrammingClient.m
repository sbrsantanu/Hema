//
//  MPMobileProgrammingClient.m
//  Created by Vishal Lohia on 4/29/14.
//  Copyright (c) 2014 MobileProgramming. All rights reserved.
//

#import "MPMobileProgrammingClient.h"
#import "AFJSONRequestOperation.h"
#import "MPApplicationGlobalConstants.h"

@implementation MPMobileProgrammingClient

+(instancetype) sharedInstance
{
    static MPMobileProgrammingClient *client = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (client == nil) {
            NSURL *url = [NSURL URLWithString:kAPI_BASE_URL];
            client = [[self alloc] initWithBaseURL:url];
            [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        }
    });
    
    return client;
}

@end
