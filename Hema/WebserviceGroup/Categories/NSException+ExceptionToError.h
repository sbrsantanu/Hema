//
//  NSException+ExceptionToError.h
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/15/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int ERROR_CODE_EXCEPTION;

@interface NSException (ExceptionToError)

-(NSError *) exceptionError;

@end
