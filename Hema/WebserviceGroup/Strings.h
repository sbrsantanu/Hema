//
//  Strings.h
//  Hema
//
//  Created by Mac on 08/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#ifndef Hema_Strings_h
#define Hema_Strings_h

static NSString * const kNWEBMainDomain                         = @"http://myphpdevelopers.com/dev/hema/app/webroot/hema/";
static NSString * const kNWEBParamSeperater                     = @"&&";

/**
 *  Data String for WebService URL
 */

/* ************************ Customer *************************** */

static NSString * const kNWEBCustomerBookingSearchParamURL      = @"search_booking.php";
static NSString * const kNWEBCustomerBookingDetailsParamURL     = @"view_booking.php";
static NSString * const kNWEBCustomerBookingApplyParamURL       = @"booking_apply.php";

static NSString * const kNWEBCustomerRegistrationParamURL       = @"registration.php";
static NSString * const kNWEBCustomerLoginParamURL              = @"customer_login.php";
static NSString * const kNWEBCustomerDashboardParamURL          = @"customer_dashboard.php";
static NSString * const kNWEBCustomerViewProfileParamURL        = @"customer_veiw_profile.php";
static NSString * const kNWEBCustomerEditProfileParamURL        = @"customer_edit.php";
static NSString * const kNWEBCustomerChangePasswordParamURL     = @"customer_change_password.php";
static NSString * const kNWEBCustomerAddEventParamURL           = @"customer_add_event.php";
static NSString * const kNWEBCustomerviewhistoryParamURL        = @"customer_view_history.php";
static NSString * const kNWEBCustomervieweventParamURL          = @"customer_veiw_event.php";
static NSString * const kNWEBCustomerCompletedEventParamURL     = @"customer_completed_event_list.php";
static NSString * const kNWEBCustomerViewCompletedEventParamURL = @"customer_veiw_completed_event.php";
static NSString * const kNWEBCustomerFeedbackParamURL           = @"customer_feedback.php";
static NSString * const kNWEBCustomerAddFeedbackParamURL        = @"";
static NSString * const kNWEBCustomerContactWithAdminParamURL   = @"customer_contact_with_hema_admin.php";
static NSString * const kNWEBCustomerCustomerHistoryOfConversationParamURL
= @"customer_history_of_conversation.php";
static NSString * const kNWEBCustomerCustomerHistoryOfConversationDetailViewParamURL
= @"customer_reply_list.php";
static NSString * const kNWEBCustomerAddReplyParamURL           = @"customer_add_reply.php";
static NSString * const kNWEBCustomerNotificationParamURL       = @"customer_notification_list.php";

/* ************************ Provider *************************** */

static NSString * const kNWEBProviderConversionHistoryParamURL  = @"provider_history_of_conversation.php";
static NSString * const kNWEBProviderLoginParamURL              = @"provider_login.php";
static NSString * const kNWEBProviderDashboardParamURL          = @"";
static NSString * const kNWEBProviderViewProfileParamURL        = @"provider_veiw_profile.php";
static NSString * const kNWEBProviderEditProfileParamURL        = @"";
static NSString * const kNWEBProviderChangePasswordParamURL     = @"";
static NSString * const kNWEBProviderAddServiceParamURL         = @"";
static NSString * const kNWEBProviderViewServicelistParamURL    = @"provider_service_list.php";
static NSString * const kNWEBProviderViewServiceDetailParamURL  = @"provider_veiw_service.php";
static NSString * const kNWEBProviderEditServiceParamURL        = @"";
static NSString * const kNWEBProviderQuotaionRequestsListParamURL
= @"";
static NSString * const kNWEBProviderQuotaionRequestsDetailParamURL
= @"";
static NSString * const kNWEBProviderAddQuotationParamURL       = @"";
static NSString * const kNWEBProviderMyQuotationRequestsListParamURL
= @"provider_my_quotation_list.php";
static NSString * const kNWEBProviderQuotationDetailParamURL    = @"provider_my_quotation_detail.php";
static NSString * const kNWEBProviderAddMessageParamURL         = @"";
static NSString * const kNWEBProviderQuotationHistoryConversationListParamURL
= @"";
static NSString * const kNWEBProviderAddReplyParamURL           = @"provider_add_reply.php";
static NSString * const kNWEBProviderContactWithHemaAdminParamURL
= @"provider_contact_with_hema_admin.php";
static NSString * const kNWEBProviderHistoryConversationListParamURL
= @"provider_history_of_conversation.php";
static NSString * const kNWEBProviderReplyListforaSingleMessageParamURL
= @"provider_reply_list.php";
static NSString * const kNWEBProviderMyIssuesParamURL           = @"provider_awarded_module_list.php";
static NSString * const kNWEBProviderMyIssuesIndividualAwardedParamURL
= @"provider_my_issue_list.php";
static NSString * const kNWEBProviderMyIssuesIndividualListofRepliesforasingleissueParamURL
= @"provider_issue_reply_list.php";
static NSString * const kNWEBProviderAddReplyforanissueParamURL = @"provider_add_issue_reply.php";

/**
 *  Data String for WebService parameters
 */

static NSString * const kNWEBParamCustomerBookingSearch         = @"RadioGroup1&&city&&end_date&&start_date";
static NSString * const kNWEBParamCustomerBookingDetails        = @"booking_id";
static NSString * const kNWEBParamCustomerBookingApply          = @"name&&email&&title&&body&&booking_id";

/* ************************ Customer *************************** */

static NSString * const kNWEBParamCustomerRegistration          = @"group&&name&&phone&&mobile&&title&&fax&&assign_to&&address&&city&&state&&zip&&email&&password&&password2&&lead_source&&service_required&&description&&subscribeme";
static NSString * const kNWEBParamCustomerLogin                 = @"email&&password";
static NSString * const kNWEBParamCustomerDashboard             = @"customer_id";
static NSString * const kNWEBParamCustomerViewProfile           = @"customer_id";
static NSString * const kNWEBParamCustomerEditProfile           = @"group&&name&&phone&&mobile&&title&&fax&&assign_to&&address&&city&&state&&zip&&lead_source&&service_required&&description&&subscribeme&&user_id";
static NSString * const kNWEBParamCustomerChangePassword        = @"password&&password2&&user_id";
static NSString * const kNWEBParamCustomerAddEvent              = @"title&&location&&company_name&&contact_name&&phone&&email_address&&no_of_guest&&date_from&&date_to&&closing_date&&signatory&&event_requirements&&budget&&contract_date&&preferred_alternate_location&&preferred_room_rate&&auxiliary_services&&is_compleated&&customer_id";
static NSString * const kNWEBParamCustomerviewhistory           = @"customer_id";
static NSString * const kNWEBParamCustomerviewevent             = @"event_id";
static NSString * const kNWEBParamCustomerCompletedEvent        = @"customer_id";
static NSString * const kNWEBParamCustomerViewCompletedEvent    = @"event_id";
static NSString * const kNWEBParamCustomerFeedback              = @"customer_id";
static NSString * const kNWEBParamCustomerAddFeedback           = @"";
static NSString * const kNWEBParamCustomerContactWithAdmin      = @"customer_id&&msg_title&&msg";
static NSString * const kNWEBParamCustomerHistoryOfConversation = @"customer_id";
static NSString * const kNWEBParamCustomerHistoryOfConversationDetailView
= @"msg_id";
static NSString * const kNWEBParamCustomerAddReply              = @"msg_id&&reply_msg";
static NSString * const kNWEBParamCustomerNotification          = @"customer_id";

/* ************************ Provider *************************** */

static NSString * const kNWEBParamProviderConversionHistory     = @"provider_id";
static NSString * const kNWEBParamProviderLogin                 = @"email&&password";
static NSString * const kNWEBParamProviderDashboard             = @"";
static NSString * const kNWEBParamProviderViewProfile           = @"provider_id";
static NSString * const kNWEBParamProviderEditProfile           = @"";
static NSString * const kNWEBParamProviderChangePassword        = @"";
static NSString * const kNWEBParamProviderAddService            = @"";
static NSString * const kNWEBParamProviderViewServicelist       = @"provider_id";
static NSString * const kNWEBParamProviderViewServiceDetail     = @"service_id";
static NSString * const kNWEBParamProviderEditService           = @"";
static NSString * const kNWEBParamProviderQuotaionRequestsList  = @"";
static NSString * const kNWEBParamProviderProviderQuotaionRequestsDetail
= @"";
static NSString * const kNWEBParamProviderProviderAddQuotation  = @"";
static NSString * const kNWEBParamProviderMyQuotationRequestsListAddQuotation
= @"provider_id";
static NSString * const kNWEBParamProviderQuotationDetail       = @"quotation_id";
static NSString * const kNWEBParamProviderAddMessage            = @"";
static NSString * const kNWEBParamProviderQuotationHistoryConversationList
= @"";
static NSString * const kNWEBParamProviderAddReply              = @"msg_id&&reply_msg";
static NSString * const kNWEBParamProviderContactWithHemaAdmin  = @"provider_id&&msg_title&&msg";
static NSString * const kNWEBParamProviderHistoryConversationList
= @"provider_id";
static NSString * const kNWEBParamProviderReplyListforaSingleMessage
= @"msg_id";
static NSString * const kNWEBParamProviderMyIssues              = @"provider_id";
static NSString * const kNWEBParamProviderMyIssuesIndividualAwarded
= @"module_id";
static NSString * const kNWEBParamProviderMyIssuesListofRepliesforasingleissue
= @"issue_id";
static NSString * const kNWEBParamProviderAddReplyforanissue    = @"issue_id&&reply_msg";



/************************************************************************************/
/**************************** Go for other static strings ****************************/
/************************************************************************************/


/**
 *  Color
 */

static NSString * const knHemaRed                               = @"E66A4C";
static NSString * const knHemaBrown                             = @"6E4F46";
static NSString * const knHemaWhite                             = @"FFFFFF";
static NSString * const knHemaBlack                             = @"000000";
static NSString * const knHemaFooterBg                          = @"452715";
static NSString * const knHemaHeaderBg                          = @"452715";
static NSString * const knHemaHeaderLine                        = @"D9D5D0";
static NSString * const knHemaTextfieldBorder                   = @"f2beb1";
static NSString * const knHemaTextfieldPlaceHolder              = @"755049";
static NSString * const knHemaTextfieldColor                    = @"755049";
static NSString * const knHemaBlackShadow                       = @"a3a3a2";

/**
 *      Text
 */


// Copyright Text

static NSString * const knCopyrightText                           = @"Copyright (c) 2014 Hema. All rights reserved.";



/**
 *  Images
 */

// Footer social Icons

static NSString * const knsocialTwitter                         = @"tw.png";
static NSString * const knsocialfacebook                        = @"fb.png";
static NSString * const knsocialYoutube                         = @"yt.png";
static NSString * const knsocialGooglePlus                      = @"gp.png";

/**
 *  Font
 */

static NSString * const knGlobalFontname                        = @"Arial";

static NSString * const knFooterCopyrightFontSize               = @"12.0";

/**
 * view positions
 */

static NSString * const knFooterXposition                       = @"0.0";
static NSString * const knFooterHeight                          = @"60.0";

#endif



















