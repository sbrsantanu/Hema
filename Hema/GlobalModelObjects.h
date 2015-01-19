//
//  GlobalModalObjects.h
//  Hema
//
//  Created by Mac on 19/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookingListObjects : NSObject

@property (nonatomic,retain) NSString *BookingListId;
@property (nonatomic,retain) NSString *Category;
@property (nonatomic,retain) NSString *Name;
@property (nonatomic,retain) NSString *StartDate;
@property (nonatomic,retain) NSString *EndDate;
@property (nonatomic,retain) NSString *EventPlace;
@property (nonatomic,retain) NSString *ShortDescription;
@property (nonatomic,retain) NSString *EventLocation;

-(id)initWithBookingListId:(NSString *)ParamBookingListId
                  Category:(NSString *)ParamCategory
                      Name:(NSString *)ParamName
                 StartDate:(NSString *)ParamStartDate
                   EndDate:(NSString *)ParamEndDate
                EventPlace:(NSString *)ParamEventPlace
          ShortDescription:(NSString *)ParamShortDescription;

-(id)initWithBookingListId:(NSString *)ParamBookingListId
                  Category:(NSString *)ParamCategory
                      Name:(NSString *)ParamName
                 StartDate:(NSString *)ParamStartDate
                   EndDate:(NSString *)ParamEndDate
                EventPlace:(NSString *)ParamEventPlace
          ShortDescription:(NSString *)ParamShortDescription
             EventLocation:(NSString *)ParamEventLocation;

@end


{"errorcode":1,"message":"Booking found!","Booking":{"id":"18","name":"Test conference on 18.11.2014","event_place":"Jersey City","start_date":"2014-11-16","end_date":"2014-11-30","long_description":"Test conference on 18.11.2014Test conference on 18.11.2014Test conference on 18.11.2014Test conference on 18.11.2014Test conference on 18.11.2014Test conference on 18.11.2014","event_location":"New Jersey"}}