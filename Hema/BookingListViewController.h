//
//  BookingListViewController.h
//  Hema
//
//  Created by Mac on 29/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

typedef enum {
    SelectedBookingTypeNone,
    SelectedBookingTypeConference,
    SelectedBookingTypeEvent,
    SelectedBookingTypeDestination
} SelectedBookingType;

#import <UIKit/UIKit.h>
#import "GlobalObjects.h"

@interface BookingListViewController : GlobalObjects

-(id)initWithBookingCategory:(SelectedBookingType)ParamBookingCategory CityorHotelname:(NSString *)ParamCityorHotelname StartDate:(NSString *)ParamStartDate EndDate:(NSString *)ParamEndDate;
@end
