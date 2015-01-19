//
//  UIAlertView+AlertCustomMethod.h
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/14/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (AlertCustomMethod)

+(void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
+(void) showAlertWithError:(NSError *)error shouldDisplayErrorTitle:(BOOL)shouldDisplayTitle;
+(void) showAlertWithException:(NSException *)exception shouldDisplayExceptionTitle:(BOOL)shouldDisplayTitle;

@end
