//
//  GlobalStrings.h
//  Hema
//
//  Created by Mac on 17/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
