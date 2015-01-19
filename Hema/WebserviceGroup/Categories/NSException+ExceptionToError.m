//
//  NSException+ExceptionToError.m
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/15/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import "NSException+ExceptionToError.h"

const int ERROR_CODE_EXCEPTION = 12345;
@implementation NSException (ExceptionToError)

-(NSError *) exceptionError
{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.name forKey:NSMachErrorDomain];
    [dict setObject:self.description forKey:NSLocalizedDescriptionKey];
    
    for (NSString *key in [self.userInfo allKeys]) {
        [dict setObject:[self.userInfo objectForKey:key] forKey:key];
    }

    NSError *error = [[NSError alloc] initWithDomain:self.name
                                                code:ERROR_CODE_EXCEPTION
                                            userInfo:dict];
    
    return error;
}

@end
