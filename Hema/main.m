//
//  main.m
//  Hema
//
//  Created by Mac on 03/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    @try {
        @autoreleasepool {
           return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    @catch (NSException *exception) {
        NSLog(@"There is exception --- %@",exception);
    }
}
