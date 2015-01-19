//
//  GlobalModalObjects.m
//  Hema
//
//  Created by Mac on 19/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "GlobalModelObjects.h"

@implementation BookingListObjects

-(id)initWithBookingListId:(NSString *)ParamBookingListId
                  Category:(NSString *)ParamCategory
                      Name:(NSString *)ParamName
                 StartDate:(NSString *)ParamStartDate
                   EndDate:(NSString *)ParamEndDate
                EventPlace:(NSString *)ParamEventPlace
          ShortDescription:(NSString *)ParamShortDescription
{
    self = [super init];
    if (self) {
        self.BookingListId          = ParamBookingListId;
        self.Category               = ParamCategory;
        self.Name                   = ParamName;
        self.StartDate              = ParamStartDate;
        self.EndDate                = ParamEndDate;
        self.EventPlace             = ParamEventPlace;
        self.ShortDescription       = ParamShortDescription;
    }
    return self;
}

-(id)initWithBookingListId:(NSString *)ParamBookingListId
                  Category:(NSString *)ParamCategory
                      Name:(NSString *)ParamName
                 StartDate:(NSString *)ParamStartDate
                   EndDate:(NSString *)ParamEndDate
                EventPlace:(NSString *)ParamEventPlace
          ShortDescription:(NSString *)ParamShortDescription
             EventLocation:(NSString *)ParamEventLocation
{
    self = [super init];
    if (self) {
        self.BookingListId      = ParamBookingListId;
        self.Category           = ParamCategory;
        self.Name               = ParamName;
        self.StartDate          = ParamStartDate;
        self.EndDate            = ParamEndDate;
        self.EventPlace         = ParamEventPlace;
        self.ShortDescription   = ParamShortDescription;
        self.EventLocation      = ParamEventLocation;
    }
    return self;
}

@end
