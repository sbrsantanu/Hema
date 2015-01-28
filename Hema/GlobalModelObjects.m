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

@implementation ProviderAccountDetails

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
                       Website:(NSString *)paramWebsite
{
    self = [super init];
    if (self) {
        self.AllowAdvanceOrder          = ParamAllowAdvanceOrder;
        self.BusinessDays               = ParamBusinessDays;
        self.BusinessHours              = ParamBusinessHours;
        self.CurrencyId                 = ParamCurrencyId;
        self.DeliveryCharge             = ParamDeliveryCharge;
        self.DeliveryMode               = ParamDeliveryMode;
        self.Description                = ParamDescription;
        self.Logo                       = ParamLogo;
        self.MaxBillingValue            = ParamMaxBillingValue;
        self.MinBillingValue            = ParamMinBillingValue;
        self.MinDeliveryTime            = ParamMinDeliveryTime;
        self.Name                       = ParamName;
        self.Phone                      = paramPhone;
        self.Questions                  = ParamQuestions;
        self.SalesTax                   = ParamSalesTax;
        self.ServiceTax                 = paramServiceTax;
        self.Vat                        = ParamVat;
        self.Website                    = paramWebsite;
    }
    return self;
}

@end
