//
//  NSError+CustomErrors.h
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/15/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int ERROR_CODE_NO_NETWORK;

@interface NSError (CustomErrors)

+(NSError *) noNetworkError;
+(NSError *) ParamCountError;
@end
