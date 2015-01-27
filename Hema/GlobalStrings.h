//
//  GlobalStrings.h
//  Hema
//
//  Created by Mac on 17/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isLogedin                   @"isLogedin"
#define SetUserName                 @"SetUserName"
#define SetUserPassword             @"SetUserPassword"
#define SetUserRemember             @"SetUserRemember"
#define userType                    @"userType"
#define logedinuserid               @"logedinuserid"
#define logedinuseremail            @"logedinuseremail"
#define logedinusername             @"logedinusername"

@interface GlobalStrings : NSObject


/**
 *  Footer Data
 */

+(NSString *)FooterSocialTwitterIcon;
+(NSString *)FooterSocialFacebookIcon;
+(NSString *)FooterSocialYoutubeIcon;
+(NSString *)FooterSocialGoogleplusIcon;
+(NSString *)FooterCopyrightText;

/**
 *  Font
 */

+(NSString *)GlobalFontname;

+(NSString *)FooterCopyrightFontSize;


/**
 *  View position
 *  @return type
 *  @VXCord, for view x cordinate
 *  @VYCord, for view y cordinate
 *  @VWidth, for view width
 *  @VHeight,for view height
 */


+(NSString *)FooterXposition;
+(NSString *)FooterYposition;
+(NSString *)FooterWidth;
+(NSString *)FooterHeight;

/**
 *      Keychain data access string
 */

+(NSString *)KCisLogedinString;
+(NSString *)KCSetUserNameString;
+(NSString *)KCSetUserPasswordString;
+(NSString *)KCSetUserRememberString;
+(NSString *)KCuserTypeString;
+(NSString *)KClogedinuseridString;
+(NSString *)KClogedinuseremailString;
+(NSString *)KClogedinusernameString;
@end
