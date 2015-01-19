//
//  UIAlertView+AlertCustomMethod.m
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/14/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import "UIAlertView+AlertCustomMethod.h"

@implementation UIAlertView (AlertCustomMethod)

+(void) showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Alert.OK", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

+(void) showAlertWithError:(NSError *)error shouldDisplayErrorTitle:(BOOL)shouldDisplayTitle
{
    NSString *title = shouldDisplayTitle ? error.domain : NSLocalizedString(@"Alert.Error.Title", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Alert.OK", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

+(void) showAlertWithException:(NSException *)exception shouldDisplayExceptionTitle:(BOOL)shouldDisplayTitle
{
    NSString *title = shouldDisplayTitle ? exception.name : NSLocalizedString(@"Alert.Exception.Title", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:exception.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Alert.OK", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

@end
