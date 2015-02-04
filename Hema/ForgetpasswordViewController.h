//
//  ForgetpasswordViewController.h
//  Hema
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalObjects.h"

typedef enum {
    SLoginTypeNone,
    SLoginTypeCustomer,
    SLoginTypeProvider
} LoginType;

@interface ForgetpasswordViewController : GlobalObjects

@property (assign) LoginType AppLoginType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil LoginType:(LoginType)LoginProcessType;

@end
