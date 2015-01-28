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

@interface ProviderAccountDetails : NSObject

@property (nonatomic,retain) NSString *AllowAdvanceOrder;
@property (nonatomic,retain) NSString *BusinessDays;
@property (nonatomic,retain) NSString *BusinessHours;
@property (nonatomic,retain) NSString *CurrencyId;
@property (nonatomic,retain) NSString *DeliveryCharge;
@property (nonatomic,retain) NSString *DeliveryMode;
@property (nonatomic,retain) NSString *Description;
@property (nonatomic,retain) NSString *Logo;
@property (nonatomic,retain) NSString *MaxBillingValue;
@property (nonatomic,retain) NSString *MinBillingValue;
@property (nonatomic,retain) NSString *MinDeliveryTime;
@property (nonatomic,retain) NSString *Name;
@property (nonatomic,retain) NSString *Phone;
@property (nonatomic,retain) NSString *Questions;
@property (nonatomic,retain) NSString *SalesTax;
@property (nonatomic,retain) NSString *ServiceTax;
@property (nonatomic,retain) NSString *Vat;
@property (nonatomic,retain) NSString *Website;

-(id)initWithAllowAdvanceOrder:(NSString *)ParamAllowAdvanceOrder
                  BusinessDays:(NSString *)ParamBusinessDays
                 BusinessHours:(NSString *)ParamBusinessHours
                    CurrencyId:(NSString *)ParamCurrencyId
                DeliveryCharge:(NSString *)ParamDeliveryCharge
                  DeliveryMode:(NSString *)ParamDeliveryMode
                   Description:(NSString *)ParamDescription
                          Logo:(NSString *)ParamLogo
               MaxBillingValue:(NSString *)ParamMaxBillingValue
               MinBillingValue:(NSString *)ParamMinBillingValue
               MinDeliveryTime:(NSString *)ParamMinDeliveryTime
                          Name:(NSString *)ParamName
                         Phone:(NSString *)paramPhone
                     Questions:(NSString *)ParamQuestions
                      SalesTax:(NSString *)ParamSalesTax
                    ServiceTax:(NSString *)paramServiceTax
                           Vat:(NSString *)ParamVat
                       Website:(NSString *)paramWebsite;
@end