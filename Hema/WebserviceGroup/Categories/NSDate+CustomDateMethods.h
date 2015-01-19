//
//  NSDate+CustomDateMethods.h
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/25/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CustomDateMethods)

-(NSDate *) startOfMonth;
-(NSDate *) endOfMonth;
-(NSDate *) nextOrPreviousMonthDate:(int)offSet;

@end
