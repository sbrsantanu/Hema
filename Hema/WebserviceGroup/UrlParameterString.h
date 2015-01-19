//
//  UrlParameterString.h
//  Hema
//
//  Created by Mac on 05/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlParameterString : NSObject

+(NSString *)GlobalURL;

/* ************************ Customer *************************** */

+(NSString *)URLParamCustomerBookingSearch;

+(NSString *)URLParamCustomerBookingDetails;

+(NSString *)URLParamCustomerRegistration;

+(NSString *)URLParamCustomerLogin;

+(NSString *)URLParamCustomerDashboard;

+(NSString *)URLParamCustomerViewProfile;

+(NSString *)URLParamCustomerEditProfile;

+(NSString *)URLParamCustomerChangePassword;

+(NSString *)URLParamCustomerAddEvent;

+(NSString *)URLParamCustomerviewhistory;

+(NSString *)URLParamCustomerviewevent;

+(NSString *)URLParamCustomerCompletedEvent;

+(NSString *)URLParamCustomerViewCompletedEvent;

+(NSString *)URLParamCustomerFeedback;

+(NSString *)URLParamCustomerContactWithAdmin;

+(NSString *)URLParamCustomerHistoryOfConversation;

+(NSString *)URLParamCustomerHistoryOfConversationDetailView;

+(NSString *)URLParamCustomerAddReply;

+(NSString *)URLParamCustomerNotification;

/* ************************ Provider *************************** */

+(NSString *)URLParamProviderConversionHistory;

+(NSString *)URLParamProviderLogin;

+(NSString *)URLParamProviderDashboard;

+(NSString *)URLParamProviderViewProfile;

+(NSString *)URLParamProviderEditProfile;

+(NSString *)URLParamProviderChangePassword;

+(NSString *)URLParamProviderAddService;

+(NSString *)URLParamProviderViewServicelist;

+(NSString *)URLParamProviderViewServiceDetail;

+(NSString *)URLParamProviderEditService;

+(NSString *)URLParamProviderQuotaionRequestsList;

+(NSString *)URLParamProviderQuotaionRequestsDetail;

+(NSString *)URLParamProviderAddQuotation;

+(NSString *)URLParamProviderMyQuotationRequestsListAddQuotation;

+(NSString *)URLParamProviderQuotationDetail;

+(NSString *)URLParamProviderAddMessage;

+(NSString *)URLParamProviderQuotationHistoryConversationList;

+(NSString *)URLParamProviderAddReply;

+(NSString *)URLParamProviderContactWithHemaAdmin;

+(NSString *)URLParamProviderHistoryConversationList;

+(NSString *)URLParamProviderReplyListforaSingleMessage;

+(NSString *)URLParamProviderMyIssues;

+(NSString *)URLParamProviderMyIssuesIndividualAwarded;

+(NSString *)URLParamProviderMyIssuesListofRepliesforasingleissue;

+(NSString *)URLParamProviderAddReplyforanissue;

/* ************************ Customer *************************** */

+(NSArray *)WebParamCustomerBookingSearch;

+(NSArray *)WebParamCustomerBookingDetails;

+(NSArray *)WebParamCustomerRegistration;

+(NSArray *)WebParamCustomerLogin;

+(NSArray *)WebParamCustomerDashboard;

+(NSArray *)WebParamCustomerViewProfile;

+(NSArray *)WebParamCustomerEditProfile;

+(NSArray *)WebParamCustomerChangePassword;

+(NSArray *)WebParamCustomerAddEvent;

+(NSArray *)WebParamCustomerviewhistory;

+(NSArray *)WebParamCustomerviewevent;

+(NSArray *)WebParamCustomerCompletedEvent;

+(NSArray *)WebParamCustomerViewCompletedEvent;

+(NSArray *)WebParamCustomerFeedback;

+(NSArray *)WebParamCustomerContactWithAdmin;

+(NSArray *)WebParamCustomerHistoryOfConversation;

+(NSArray *)WebParamCustomerHistoryOfConversationDetailView;

+(NSArray *)WebParamCustomerAddReply;

+(NSArray *)WebParamCustomerNotification;

/* ************************ Provider *************************** */

+(NSArray *)WebParamProviderConversionHistory;

+(NSArray *)WebParamProviderLogin;

+(NSArray *)WebParamProviderDashboard;

+(NSArray *)WebParamProviderViewProfile;

+(NSArray *)WebParamProviderEditProfile;

+(NSArray *)WebParamProviderChangePassword;

+(NSArray *)WebParamProviderAddService;

+(NSArray *)WebParamProviderViewServicelist;

+(NSArray *)WebParamProviderViewServiceDetail;

+(NSArray *)WebParamProviderEditService;

+(NSArray *)WebParamProviderQuotaionRequestsList;

+(NSArray *)WebParamProviderQuotaionRequestsDetail;

+(NSArray *)WebParamProviderAddQuotation;

+(NSArray *)WebParamProviderMyQuotationRequestsListAddQuotation;

+(NSArray *)WebParamProviderQuotationDetail;

+(NSArray *)WebParamProviderAddMessage;

+(NSArray *)WebParamProviderQuotationHistoryConversationList;

+(NSArray *)WebParamProviderAddReply;

+(NSArray *)WebParamProviderContactWithHemaAdmin;

+(NSArray *)WebParamProviderHistoryConversationList;

+(NSArray *)WebParamProviderReplyListforaSingleMessage;

+(NSArray *)WebParamProviderMyIssues;

+(NSArray *)WebParamProviderMyIssuesIndividualAwarded;

+(NSArray *)WebParamProviderMyIssuesListofRepliesforasingleissue;

+(NSArray *)WebParamProviderAddReplyforanissue;

@end
