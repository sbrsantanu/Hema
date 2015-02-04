//
//  FPassword.h
//  Hema
//
//  Created by Mac on 04/02/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalObjects.h"

typedef enum {
    LoginTypeNone,
    LoginTypeCustomer,
    LoginTypeProvider
} SLoginType;

@interface FPassword : GlobalObjects

@property (assign) SLoginType AppLoginType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil LoginType:(SLoginType)LoginProcessType;

@end