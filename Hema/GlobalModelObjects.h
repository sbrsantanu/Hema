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

@interface ProviderViewServicesList : NSObject

@property (nonatomic,retain) NSString *ServiceId;
@property (nonatomic,retain) NSString *ServiceName;
@property (nonatomic,retain) NSString *ServiceShortDescription;
@property (nonatomic,retain) NSString *ServiceRate;
@property (nonatomic,retain) NSString *ServiceCurrencyCode;
@property (nonatomic,retain) NSString *ServiceRateValidTill;
@property (nonatomic,retain) NSString *ServiceTax;
@property (nonatomic,retain) NSString *ServiceDiscount;
@property (nonatomic,retain) NSString *ServiceShippingCost;

-(id)initWithServiceId:(NSString *)ParamServiceId
           ServiceName:(NSString *)ParamServiceName
ServiceShortDescription:(NSString *)ParamServiceShortDescription
           ServiceRate:(NSString *)ParamServiceRate
   ServiceCurrencyCode:(NSString *)ParamServiceCurrencyCode
  ServiceRateValidTill:(NSString *)ParamServiceRateValidTill
            ServiceTax:(NSString *)ParamServiceTax
       ServiceDiscount:(NSString *)ParamServiceDiscount
   ServiceShippingCost:(NSString *)ParamServiceShippingCost;

@end

@interface ServiceCategory : NSObject

@property (nonatomic,retain) NSString *CategoryId;
@property (nonatomic,retain) NSString *CategoryName;

-(id)initWithCategoryId:(NSString *)ParamCategoryId
           CategoryName:(NSString *)ParamCategoryName;

@end

@interface ProviderMYQuotationList : NSObject


@property (nonatomic,retain) NSString *QuotationId;
@property (nonatomic,retain) NSString *QuotationModuleId;
@property (nonatomic,retain) NSString *QuotationModuleName;
@property (nonatomic,retain) NSString *QuotationBidAmount;
@property (nonatomic,retain) NSString *QuotationStartDate;
@property (nonatomic,retain) NSString *QuotationEndDate;
@property (nonatomic,retain) NSString *QuotationDuration;
@property (nonatomic,retain) NSString *QuotationNote;
@property (nonatomic,retain) NSString *QuotationIsBlocked;
@property (nonatomic,retain) NSString *QuotationIsAwarded;
@property (nonatomic,retain) NSString *QuotationIsDeclined;
@property (nonatomic,retain) NSString *QuotationIsRevision;
@property (nonatomic,retain) NSString *QuotationQuotationTime;
@property (nonatomic,retain) NSString *QuotationBookingNumber;
@property (nonatomic,retain) NSString *QuotationBookingIsPaid;

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
  QuotationBookingIsPaid:(NSString *)ParamQuotationBookingIsPaid;

@end


@interface ProverHistoryOfConversion : NSObject

@property (nonatomic,retain) NSString *ConversionId;
@property (nonatomic,retain) NSString *ConversionReplyCount;
@property (nonatomic,retain) NSString *ConversionProviderId;
@property (nonatomic,retain) NSString *ConversionMessageTitle;
@property (nonatomic,retain) NSString *ConversionMessageDetails;
@property (nonatomic,retain) NSString *ConversionMessageTime;
@property (nonatomic,retain) NSString *ConversionIsBlocked;
@property (nonatomic,retain) NSString *ConversionIsReplied;

-(id)initWithConversionId:(NSString *)ParamConversionId
     ConversionReplyCount:(NSString *)ParamConversionReplyCount
     ConversionProviderId:(NSString *)ParamConversionProviderId
   ConversionMessageTitle:(NSString *)ParamConversionMessageTitle
 ConversionMessageDetails:(NSString *)ParamConversionMessageDetails
    ConversionMessageTime:(NSString *)ParamConversionMessageTime
      ConversionIsBlocked:(NSString *)ParamConversionIsBlocked
      ConversionIsReplied:(NSString *)ParamConversionIsReplied;
@end

@interface ProviderIssueList : NSObject

@property (nonatomic,retain) NSString *IssueListId;
@property (nonatomic,retain) NSString *IssueListModuleId;
@property (nonatomic,retain) NSString *IssueListModuleName;
@property (nonatomic,retain) NSString *IssueListBidAmount;
@property (nonatomic,retain) NSString *IssueListStartDate;
@property (nonatomic,retain) NSString *IssueListEndDate;
@property (nonatomic,retain) NSString *IssueListDuration;
@property (nonatomic,retain) NSString *IssueListNote;
@property (nonatomic,retain) NSString *IssueListIsBlocked;
@property (nonatomic,retain) NSString *IssueListIsAwarded;
@property (nonatomic,retain) NSString *IssueListIsDeclined;
@property (nonatomic,retain) NSString *IssueListIsRevision;
@property (nonatomic,retain) NSString *IssueListQuotationTime;
@property (nonatomic,retain) NSString *IssueListBookingNumber;
@property (nonatomic,retain) NSString *IssueListIsPaid;


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
         IssueListIsPaid:(NSString *)ParamIssueListIsPaid;

@end

@interface ProviderQuotationRequest : NSObject

@property (nonatomic,retain) NSString *QuotationId;
@property (nonatomic,retain) NSString *QuotationEventId;
@property (nonatomic,retain) NSString *QuotationModuleName;
@property (nonatomic,retain) NSString *QuotationModuleDetails;
@property (nonatomic,retain) NSString *QuotationStartDate;
@property (nonatomic,retain) NSString *QuotationEndDate;
@property (nonatomic,retain) NSString *QuotationBudget;
@property (nonatomic,retain) NSString *QuotationCurrencyCode;
@property (nonatomic,retain) NSString *QuotationDuration;

-(id)initWithQuotationId:(NSString *)ParamQuotationId
        QuotationEventId:(NSString *)ParamQuotationEventId
     QuotationModuleName:(NSString *)ParamQuotationModuleName
  QuotationModuleDetails:(NSString *)ParamQuotationModuleDetails
      QuotationStartDate:(NSString *)ParamQuotationStartDate
        QuotationEndDate:(NSString *)ParamQuotationEndDate
         QuotationBudget:(NSString *)ParamQuotationBudget
   QuotationCurrencyCode:(NSString *)ParamQuotationCurrencyCode
       QuotationDuration:(NSString *)paramQuotationDuration;

@end

@interface ProviderQuotationDetails : NSObject

@property (nonatomic,retain) NSString *QDetailsId;
@property (nonatomic,retain) NSString *QDetailsModuleName;
@property (nonatomic,retain) NSString *QDetailsModuleDetails;
@property (nonatomic,retain) NSString *QDetailsStartDate;
@property (nonatomic,retain) NSString *QDetailsEndDate;
@property (nonatomic,retain) NSString *QDetailsBudget;
@property (nonatomic,retain) NSString *QDetailsCurrency;
@property (nonatomic,retain) NSString *QDetailsDuration;
@property (nonatomic,retain) NSString *QDetailsLocation;

-(id)initWithQDetailsId:(NSString *)ParamQDetailsId
     QDetailsModuleName:(NSString *)ParamQDetailsModuleName
  QDetailsModuleDetails:(NSString *)ParamQDetailsModuleDetails
      QDetailsStartDate:(NSString *)ParamQDetailsStartDate
        QDetailsEndDate:(NSString *)ParamQDetailsEndDate
         QDetailsBudget:(NSString *)ParamQDetailsBudget
       QDetailsCurrency:(NSString *)ParamQDetailsCurrency
       QDetailsDuration:(NSString *)ParamQDetailsDuration
       QDetailsLocation:(NSString *)ParamQDetailsLocation;

@end

@interface ProviderServiceDetails : NSObject

@property (nonatomic,retain) NSString *SDetailsId;
@property (nonatomic,retain) NSString *SDetailsProviderId;
@property (nonatomic,retain) NSString *SDetailsName;
@property (nonatomic,retain) NSString *SDetailsShortDescription;
@property (nonatomic,retain) NSString *SDetailsFullDescription;
@property (nonatomic,retain) NSString *SDetailsRate;
@property (nonatomic,retain) NSString *SDetailsServiceCategory;
@property (nonatomic,retain) NSString *SDetailsCategoryName;
@property (nonatomic,retain) NSString *SDetailsCurrencyCode;
@property (nonatomic,retain) NSString *SDetailsLogo;
@property (nonatomic,retain) NSString *SDetailsRateValidTill;
@property (nonatomic,retain) NSString *SDetailsTax;
@property (nonatomic,retain) NSString *SDetailsAllowDiscount;
@property (nonatomic,retain) NSString *SDetailsDiscount;
@property (nonatomic,retain) NSString *SDetailsShipping;
@property (nonatomic,retain) NSString *SDetailsShippingCost;

-(id)initWithSDetailsId:(NSString *)ParamSDetailsId
     SDetailsProviderId:(NSString *)ParamSDetailsProviderId
           SDetailsName:(NSString *)ParamSDetailsName
SDetailsShortDescription:(NSString *)ParamSDetailsShortDescription
SDetailsFullDescription:(NSString *)ParamSDetailsFullDescription
           SDetailsRate:(NSString *)ParamSDetailsRate
SDetailsServiceCategory:(NSString *)ParamSDetailsServiceCategory
   SDetailsCategoryName:(NSString *)ParamSDetailsCategoryName
   SDetailsCurrencyCode:(NSString *)ParamSDetailsCurrencyCode
           SDetailsLogo:(NSString *)ParamSDetailsLogo
  SDetailsRateValidTill:(NSString *)ParamSDetailsRateValidTill
            SDetailsTax:(NSString *)ParamSDetailsTax
  SDetailsAllowDiscount:(NSString *)ParamSDetailsAllowDiscount
       SDetailsDiscount:(NSString *)ParamSDetailsDiscount
       SDetailsShipping:(NSString *)ParamSDetailsShipping
   SDetailsShippingCost:(NSString *)ParamSDetailsShippingCost;

@end

