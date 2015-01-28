//
//  UrlParameterString.m
//  Hema
//
//  Created by Mac on 05/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "UrlParameterString.h"
#import "Strings.h"

@implementation UrlParameterString

/**
 *  Public Functions
 */

+(NSString *)GlobalURL { return kNWEBMainDomain; }

/**
 *  WebService URL List
 */

+(NSString *)URLParamCustomerBookingSearch { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerBookingDetails { return kNWEBCustomerBookingDetailsParamURL; }

+(NSString *)URLParamCustomerBookingApply { return kNWEBCustomerBookingApplyParamURL; }

+(NSString *)URLParamCustomerRegistration  { return kNWEBCustomerRegistrationParamURL; }

+(NSString *)URLParamCustomerLogin  { return kNWEBCustomerLoginParamURL; }

+(NSString *)URLParamCustomerDashboard  { return kNWEBCustomerDashboardParamURL; }

+(NSString *)URLParamCustomerViewProfile  { return kNWEBCustomerViewProfileParamURL; }

+(NSString *)URLParamCustomerEditProfile  { return kNWEBCustomerEditProfileParamURL; }

+(NSString *)URLParamCustomerChangePassword  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerAddEvent  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerviewhistory  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerviewevent  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerCompletedEvent  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerViewCompletedEvent  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerFeedback  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerContactWithAdmin  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerHistoryOfConversation  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerHistoryOfConversationDetailView  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerAddReply  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamCustomerNotification  { return kNWEBCustomerBookingSearchParamURL; }

/* ************************ Provider *************************** */

+(NSString *)URLParamProviderConversionHistory  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderLogin  { return kNWEBProviderLoginParamURL; }

+(NSString *)URLParamProviderDashboard  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderViewProfile  { return kNWEBProviderViewProfileParamURL; }

+(NSString *)URLParamProviderEditProfile  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderChangePassword  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderAddService  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderViewServicelist  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderViewServiceDetail  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderEditService  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderQuotaionRequestsList  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderQuotaionRequestsDetail  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderAddQuotation  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderMyQuotationRequestsListAddQuotation  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderQuotationDetail  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderAddMessage  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderQuotationHistoryConversationList  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderAddReply  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderContactWithHemaAdmin  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderHistoryConversationList  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderReplyListforaSingleMessage  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderMyIssues  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderMyIssuesIndividualAwarded  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderMyIssuesListofRepliesforasingleissue  { return kNWEBCustomerBookingSearchParamURL; }

+(NSString *)URLParamProviderAddReplyforanissue  { return kNWEBCustomerBookingSearchParamURL; }

/**
 *  Web Service Array Lists
 */

+(NSArray *)WebParamCustomerBookingSearch { return [self ReturnWebArrayFromString:kNWEBParamCustomerBookingSearch]; }

+(NSArray *)WebParamCustomerBookingDetails { return [self ReturnWebArrayFromString:kNWEBParamCustomerBookingDetails]; }

+(NSArray *)WebParamCustomerBookingApply { return [self ReturnWebArrayFromString:kNWEBParamCustomerBookingApply]; }

/* ************************ Customer *************************** */

+(NSArray *)WebParamCustomerRegistration { return [self ReturnWebArrayFromString:kNWEBParamCustomerRegistration]; }

+(NSArray *)WebParamCustomerLogin { return [self ReturnWebArrayFromString:kNWEBParamCustomerLogin]; }

+(NSArray *)WebParamCustomerDashboard { return [self ReturnWebArrayFromString:kNWEBParamCustomerDashboard]; }

+(NSArray *)WebParamCustomerViewProfile { return [self ReturnWebArrayFromString:kNWEBParamCustomerViewProfile]; }

+(NSArray *)WebParamCustomerEditProfile { return [self ReturnWebArrayFromString:kNWEBParamCustomerEditProfile]; }

+(NSArray *)WebParamCustomerChangePassword { return [self ReturnWebArrayFromString:kNWEBParamCustomerChangePassword]; }

+(NSArray *)WebParamCustomerAddEvent { return [self ReturnWebArrayFromString:kNWEBParamCustomerAddEvent]; }

+(NSArray *)WebParamCustomerviewhistory { return [self ReturnWebArrayFromString:kNWEBParamCustomerviewhistory]; }

+(NSArray *)WebParamCustomerviewevent { return [self ReturnWebArrayFromString:kNWEBParamCustomerviewevent]; }

+(NSArray *)WebParamCustomerCompletedEvent { return [self ReturnWebArrayFromString:kNWEBParamCustomerCompletedEvent]; }

+(NSArray *)WebParamCustomerViewCompletedEvent { return [self ReturnWebArrayFromString:kNWEBParamCustomerViewCompletedEvent]; }

+(NSArray *)WebParamCustomerFeedback { return [self ReturnWebArrayFromString:kNWEBParamCustomerFeedback]; }

+(NSArray *)WebParamCustomerContactWithAdmin { return [self ReturnWebArrayFromString:kNWEBParamCustomerContactWithAdmin]; }

+(NSArray *)WebParamCustomerHistoryOfConversation { return [self ReturnWebArrayFromString:kNWEBParamCustomerHistoryOfConversation]; }

+(NSArray *)WebParamCustomerHistoryOfConversationDetailView { return [self ReturnWebArrayFromString:kNWEBParamCustomerHistoryOfConversationDetailView]; }

+(NSArray *)WebParamCustomerAddReply { return [self ReturnWebArrayFromString:kNWEBParamCustomerAddReply]; }

+(NSArray *)WebParamCustomerNotification { return [self ReturnWebArrayFromString:kNWEBParamCustomerNotification]; }

/* ************************ Provider *************************** */

+(NSArray *)WebParamProviderConversionHistory { return [self ReturnWebArrayFromString:kNWEBParamProviderConversionHistory]; }

+(NSArray *)WebParamProviderLogin { return [self ReturnWebArrayFromString:kNWEBParamProviderLogin]; }

+(NSArray *)WebParamProviderDashboard { return [self ReturnWebArrayFromString:kNWEBParamProviderDashboard]; }

+(NSArray *)WebParamProviderViewProfile { return [self ReturnWebArrayFromString:kNWEBParamProviderViewProfile]; }

+(NSArray *)WebParamProviderEditProfile { return [self ReturnWebArrayFromString:kNWEBParamProviderEditProfile]; }

+(NSArray *)WebParamProviderChangePassword { return [self ReturnWebArrayFromString:kNWEBParamProviderChangePassword]; }

+(NSArray *)WebParamProviderAddService { return [self ReturnWebArrayFromString:kNWEBParamProviderAddService]; }

+(NSArray *)WebParamProviderViewServicelist { return [self ReturnWebArrayFromString:kNWEBParamProviderViewServicelist]; }

+(NSArray *)WebParamProviderViewServiceDetail { return [self ReturnWebArrayFromString:kNWEBParamProviderViewServiceDetail]; }

+(NSArray *)WebParamProviderEditService { return [self ReturnWebArrayFromString:kNWEBParamProviderEditService]; }

+(NSArray *)WebParamProviderQuotaionRequestsList { return [self ReturnWebArrayFromString:kNWEBParamProviderQuotaionRequestsList]; }

+(NSArray *)WebParamProviderQuotaionRequestsDetail { return [self ReturnWebArrayFromString:kNWEBParamProviderProviderQuotaionRequestsDetail]; }

+(NSArray *)WebParamProviderAddQuotation { return [self ReturnWebArrayFromString:kNWEBParamProviderProviderAddQuotation]; }

+(NSArray *)WebParamProviderMyQuotationRequestsListAddQuotation { return [self ReturnWebArrayFromString:kNWEBParamProviderMyQuotationRequestsListAddQuotation]; }

+(NSArray *)WebParamProviderQuotationDetail { return [self ReturnWebArrayFromString:kNWEBParamProviderQuotationDetail]; }

+(NSArray *)WebParamProviderAddMessage { return [self ReturnWebArrayFromString:kNWEBParamProviderAddMessage]; }

+(NSArray *)WebParamProviderQuotationHistoryConversationList { return [self ReturnWebArrayFromString:kNWEBParamProviderQuotationHistoryConversationList]; }

+(NSArray *)WebParamProviderAddReply { return [self ReturnWebArrayFromString:kNWEBParamProviderAddReply]; }

+(NSArray *)WebParamProviderContactWithHemaAdmin { return [self ReturnWebArrayFromString:kNWEBParamProviderContactWithHemaAdmin]; }

+(NSArray *)WebParamProviderHistoryConversationList { return [self ReturnWebArrayFromString:kNWEBParamProviderHistoryConversationList]; }

+(NSArray *)WebParamProviderReplyListforaSingleMessage { return [self ReturnWebArrayFromString:kNWEBParamProviderReplyListforaSingleMessage]; }

+(NSArray *)WebParamProviderMyIssues { return [self ReturnWebArrayFromString:kNWEBParamProviderMyIssues]; }

+(NSArray *)WebParamProviderMyIssuesIndividualAwarded { return [self ReturnWebArrayFromString:kNWEBParamProviderMyIssuesIndividualAwarded]; }

+(NSArray *)WebParamProviderMyIssuesListofRepliesforasingleissue { return [self ReturnWebArrayFromString:kNWEBParamProviderMyIssuesListofRepliesforasingleissue]; }

+(NSArray *)WebParamProviderAddReplyforanissue { return [self ReturnWebArrayFromString:kNWEBParamProviderAddReplyforanissue]; }

/**
 *  NonPublic Functions
 */

+(NSString *)GlobalSeperaterString { return kNWEBParamSeperater; }

+(NSArray *)ReturnWebArrayFromString:(NSString *)DataString { return [DataString componentsSeparatedByString:UrlParameterString.GlobalSeperaterString]; }

@end
