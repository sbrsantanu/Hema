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

@implementation ProviderViewServicesList

-(id)initWithServiceId:(NSString *)ParamServiceId
           ServiceName:(NSString *)ParamServiceName
ServiceShortDescription:(NSString *)ParamServiceShortDescription
           ServiceRate:(NSString *)ParamServiceRate
   ServiceCurrencyCode:(NSString *)ParamServiceCurrencyCode
  ServiceRateValidTill:(NSString *)ParamServiceRateValidTill
            ServiceTax:(NSString *)ParamServiceTax
       ServiceDiscount:(NSString *)ParamServiceDiscount
   ServiceShippingCost:(NSString *)ParamServiceShippingCost
{
    self = [super init];
    if (self) {
        self.ServiceId                      = ParamServiceId;
        self.ServiceName                    = ParamServiceName;
        self.ServiceShortDescription        = ParamServiceShortDescription;
        self.ServiceRate                    = ParamServiceRate;
        self.ServiceCurrencyCode            = ParamServiceCurrencyCode;
        self.ServiceRateValidTill           = ParamServiceRateValidTill;
        self.ServiceTax                     = ParamServiceTax;
        self.ServiceDiscount                = ParamServiceDiscount;
        self.ServiceShippingCost            = ParamServiceShippingCost;
    }
    return self;
}

@end

@implementation ServiceCategory

-(id)initWithCategoryId:(NSString *)ParamCategoryId
CategoryName:(NSString *)ParamCategoryName
{
    self = [super init];
    if (self) {
        self.CategoryId         = ParamCategoryId;
        self.CategoryName       = ParamCategoryName;
    }
    return self;
}

@end

@implementation ProviderMYQuotationList

-(id)initWithQuotationId:(NSString *)ParamQuotationId
       QuotationModuleId:(NSString *)ParamQuotationModuleId
     QuotationModuleName:(NSString *)ParamQuotationModuleName
      QuotationBidAmount:(NSString *)ParamQuotationBidAmount
      QuotationStartDate:(NSString *)ParamQuotationStartDate
        QuotationEndDate:(NSString *)ParamQuotationEndDate
       QuotationDuration:(NSString *)ParamQuotationDuration
           QuotationNote:(NSString *)ParamQuotationNote
      QuotationIsBlocked:(NSString *)ParamQuotationIsBlocked
      QuotationIsAwarded:(NSString *)ParamQuotationIsAwarded
     QuotationIsDeclined:(NSString *)ParamQuotationIsDeclined
     QuotationIsRevision:(NSString *)ParamQuotationIsRevision
  QuotationQuotationTime:(NSString *)ParamQuotationQuotationTime
  QuotationBookingNumber:(NSString *)ParamQuotationBookingNumber
  QuotationBookingIsPaid:(NSString *)ParamQuotationBookingIsPaid
{
    self = [super init];
    if (self) {
        self.QuotationId            = ParamQuotationId;
        self.QuotationModuleId      = ParamQuotationModuleId;
        self.QuotationModuleName    = ParamQuotationModuleName;
        self.QuotationBidAmount     = ParamQuotationBidAmount;
        self.QuotationStartDate     = ParamQuotationStartDate;
        self.QuotationEndDate       = ParamQuotationEndDate;
        self.QuotationDuration      = ParamQuotationDuration;
        self.QuotationNote          = ParamQuotationNote;
        self.QuotationIsBlocked     = ParamQuotationIsBlocked;
        self.QuotationIsAwarded     = ParamQuotationIsAwarded;
        self.QuotationIsDeclined    = ParamQuotationIsDeclined;
        self.QuotationIsRevision    = ParamQuotationIsRevision;
        self.QuotationQuotationTime = ParamQuotationQuotationTime;
        self.QuotationBookingNumber = ParamQuotationBookingNumber;
        self.QuotationBookingIsPaid = ParamQuotationBookingIsPaid;
    }
    return self;
}

@end

@implementation ProverHistoryOfConversion

-(id)initWithConversionId:(NSString *)ParamConversionId
ConversionReplyCount:(NSString *)ParamConversionReplyCount
ConversionProviderId:(NSString *)ParamConversionProviderId
ConversionMessageTitle:(NSString *)ParamConversionMessageTitle
ConversionMessageDetails:(NSString *)ParamConversionMessageDetails
ConversionMessageTime:(NSString *)ParamConversionMessageTime
ConversionIsBlocked:(NSString *)ParamConversionIsBlocked
ConversionIsReplied:(NSString *)ParamConversionIsReplied
{
    self = [super init];
    if (self) {
        self.ConversionId                   = ParamConversionId;
        self.ConversionReplyCount           = ParamConversionReplyCount;
        self.ConversionProviderId           = ParamConversionProviderId;
        self.ConversionMessageTitle         = ParamConversionMessageTitle;
        self.ConversionMessageDetails       = ParamConversionMessageDetails;
        self.ConversionMessageTime          = ParamConversionMessageTime;
        self.ConversionIsBlocked            = ParamConversionIsBlocked;
        self.ConversionIsReplied            = ParamConversionIsReplied;
    }
    return self;
}

@end

@implementation ProviderIssueList

-(id)initWithIssueListId:(NSString *)ParamIssueListId
       IssueListModuleId:(NSString *)ParamIssueListModuleId
     IssueListModuleName:(NSString *)ParamIssueListModuleName
      IssueListBidAmount:(NSString *)ParamIssueListBidAmount
      IssueListStartDate:(NSString *)ParamIssueListStartDate
        IssueListEndDate:(NSString *)ParamIssueListEndDate
       IssueListDuration:(NSString *)ParamIssueListDuration
           IssueListNote:(NSString *)ParamIssueListNote
      IssueListIsBlocked:(NSString *)ParamIssueListIsBlocked
      IssueListIsAwarded:(NSString *)ParamIssueListIsAwarded
     IssueListIsDeclined:(NSString *)ParamIssueListIsDeclined
     IssueListIsRevision:(NSString *)ParamIssueListIsRevision
  IssueListQuotationTime:(NSString *)ParamIssueListQuotationTime
  IssueListBookingNumber:(NSString *)ParamIssueListBookingNumber
         IssueListIsPaid:(NSString *)ParamIssueListIsPaid
{
    self = [super init];
    if (self) {
        self.IssueListId            = ParamIssueListId;
        self.IssueListModuleId      = ParamIssueListModuleId;
        self.IssueListModuleName    = ParamIssueListModuleName;
        self.IssueListBidAmount     = ParamIssueListBidAmount;
        self.IssueListStartDate     = ParamIssueListStartDate;
        self.IssueListEndDate       = ParamIssueListEndDate;
        self.IssueListDuration      = ParamIssueListDuration;
        self.IssueListNote          = ParamIssueListNote;
        self.IssueListIsBlocked     = ParamIssueListIsBlocked;
        self.IssueListIsAwarded     = ParamIssueListIsAwarded;
        self.IssueListIsDeclined    = ParamIssueListIsDeclined;
        self.IssueListIsRevision    = ParamIssueListIsRevision;
        self.IssueListQuotationTime = ParamIssueListQuotationTime;
        self.IssueListBookingNumber = ParamIssueListBookingNumber;
        self.IssueListIsPaid        = ParamIssueListIsPaid;
    }
    return self;
}

@end
