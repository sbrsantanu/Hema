
#import <Availability.h>
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

#import "ANDProgressHUD.h"
#import "Reachability.h"
#import "NSError+CustomErrors.h"
#import "UIAlertView+AlertCustomMethod.h"
#import "NSException+ExceptionToError.h"
#import "NSDate+CustomDateMethods.h"
#import "WebserviceHelper.h"
#import "MPMobileProgrammingClient.h"

/*
 * Loading defines
 */
#define SCREEN_WINDOW   [[[UIApplication sharedApplication] delegate] window]
#define HIDE_LOADING()  [ANDProgressHUD hideHUDForView:SCREEN_WINDOW animated:YES]
#define SHOW_LOADING()  [ANDProgressHUD showHUDAddedTo:SCREEN_WINDOW animated:NO]

/*
 * NSLocalization
 */
#define LOCALISE_STRING(TEXT)         NSLocalizedString(TEXT, nil)

/*
 * Network Reachabilty Constants
 */
#define IS_NETWORK_AVAILABLE()            [[Reachability reachabilityForInternetConnection] currentReachabilityStatus]

#define SHOW_NETWORK_ERROR_ALERT()        [UIAlertView showAlertWithTitle:LOCALISE_STRING(@"Alert.Title") message:LOCALISE_STRING(@"ReachabilityNoNetwork.Message")]

/**
 * APP ID
 */
#define appID @"0a2886a0"
#define kAND_APP_ID @"0a2886a0"

#define kAND_WS_ENABLE_HEADERS 0
#define kAND_WS_HEADER_KEY_APPID @"X-WellnessConnected-AppId"
#define kAND_WS_HEADER_KEY_AUTHTOKEN @"X-WellnessConnected-AuthToken"

#define kHEADER_KEY_CONTENT_TYPE @"Content-Type"
#define kHEADER_KEY_ACCEPT @"Accept"
#define kHEADER_VALUE_CONTENT_TYPE @"application/x-www-form-urlencoded"
#define kHEADER_VALUE_ACCEPT @"*/*"

#define kHEADER_KEY_APPID @"X-WellnessConnected-AppId"
#define kHEADER_KEY_AUTHTOKEN @"X-WellnessConnected-AuthToken"

#define kHEADER_VALUE_APPID @"0a2886a0"
#define kHEADER_VALUE_AUTHTOKEN [NSNull null]


static NSMutableDictionary * Get_HTTP_HEADERS_Dictionary()
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:kHEADER_VALUE_CONTENT_TYPE  forKey:kHEADER_KEY_CONTENT_TYPE];
    [dict setObject:kHEADER_VALUE_ACCEPT  forKey:kHEADER_KEY_ACCEPT];

#if kAND_WS_ENABLE_HEADERS
    [dict setObject:kHEADER_VALUE_APPID  forKey:kHEADER_KEY_APPID];
    [dict setObject:kHEADER_VALUE_AUTHTOKEN  forKey:kHEADER_KEY_AUTHTOKEN];
#endif
    
    return dict;
}

#define HTTP_HEADER_DICT Get_HTTP_HEADERS_Dictionary()

/*
 *  URL constants
 */
#define kAPI_BASE_URL @"http://173.201.188.12:1005/"

#define kWS_Login @"authservice/login"

#define is_iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// DLog will output like NSLog only when the DEBUG variable is set
#if  TARGET_IPHONE_SIMULATOR //DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#define IS_VALID_STRING(_str_) _str_ && ![_str_ isEqual:[NSNull null]] && ![_str_ isEqualToString:@"(null)"]  ? TRUE : FALSE

#define GET_VALID_STRING(_str_) _str_ && ![_str_ isEqualToString:@"(null)"] && ![_str_ isEqual:[NSNull null]]  ? _str_ : @""

#define GetBundleImagePath(_imgName_,_ext_) [[NSBundle mainBundle] pathForResource:_imgName_ ofType:_ext_]

