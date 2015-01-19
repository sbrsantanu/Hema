//
//  NSDate+CustomDateMethods.m
//  MobileProgramming
//
//  Created by Vishal Lohia on 3/25/14.
//  Copyright (c) 2014 a1. All rights reserved.
//

#import "NSDate+CustomDateMethods.h"

@implementation NSDate (CustomDateMethods)

-(NSDate *) startOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:self];
    components.day = 1;
    
    NSDate *firstDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents: components];
    
    return firstDayOfMonthDate;
}

- (NSDate *) dateByAddingMonths: (NSInteger) monthsToAdd
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * months = [[NSDateComponents alloc] init];
    [months setMonth: monthsToAdd];
    
    return [calendar dateByAddingComponents: months toDate: self options: 0];
}

- (NSDate *) endOfMonth
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * plusOneMonthDate = [self dateByAddingMonths: 1];
    NSDateComponents * plusOneMonthDateComponents = [calendar components: NSYearCalendarUnit | NSMonthCalendarUnit fromDate: plusOneMonthDate];
    NSDate * endOfMonth = [[calendar dateFromComponents: plusOneMonthDateComponents] dateByAddingTimeInterval: -1];
    // One second before the start of next month
    
    return endOfMonth;
}

-(NSDate *) nextOrPreviousMonthDate:(int)offSet
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = offSet;
    
    NSDate *currentDatePlus1Month = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                                  toDate:self
                                                                                 options:0];
    return currentDatePlus1Month;
}

@end
