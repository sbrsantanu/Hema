//
//  BookingDetailsViewController.h
//  Hema
//
//  Created by Mac on 31/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

typedef enum {
    SelectedBookingDetailsTypeNone,
    SelectedBookingDetailsTypeConference,
    SelectedBookingDetailsTypeEvent,
    SelectedBookingDetailsTypeDestination
} SelectedBookingDetailsType;

#import <UIKit/UIKit.h>
#import "GlobalObjects.h"

@interface BookingDetailsViewController : GlobalObjects
@property (assign) SelectedBookingDetailsType BookingDetailsType;
@property (nonatomic,retain) NSString *BookingID;
@property BOOL BookingOption;
- (id)initWithBookingId:(NSString *)aBookingId WithBookingOption:(BOOL)BookingOption;
@end
