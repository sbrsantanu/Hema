//
//  MPMobileProgrammingClient.h
//  MobileProgrammingWebserviceDemo
//
//  Created by Vishal Lohia on 4/29/14.
//  Copyright (c) 2014 MobileProgramming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface MPMobileProgrammingClient : AFHTTPClient

+(instancetype) sharedInstance;

@end
