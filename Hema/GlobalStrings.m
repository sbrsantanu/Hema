//
//  GlobalStrings.m
//  Hema
//
//  Created by Mac on 17/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "GlobalStrings.h"
#import "Strings.h"
#import "AppDelegate.h"

@implementation GlobalStrings

/**
 *  Footer Data
 */

+(NSString *)FooterSocialTwitterIcon { return knsocialTwitter; }
+(NSString *)FooterSocialFacebookIcon { return knsocialfacebook; }
+(NSString *)FooterSocialYoutubeIcon { return knsocialYoutube; }
+(NSString *)FooterSocialGoogleplusIcon { return knsocialGooglePlus; }
+(NSString *)FooterCopyrightText { return knCopyrightText; }


/**
 * Font
 */

+(NSString *)GlobalFontname { return knGlobalFontname; };

+(NSString *)FooterCopyrightFontSize { return knFooterCopyrightFontSize;}

/**
 *  View position
 */

+(NSString *)FooterXposition { return knFooterXposition; }
+(NSString *)FooterYposition {
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    float Yposition           = mainDelegate.window.frame.size.height - [knFooterHeight floatValue];
    return [NSString stringWithFormat:@"%f",Yposition];
}
+(NSString *)FooterWidth {
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [NSString stringWithFormat:@"%f",mainDelegate.window.frame.size.width];
}
+(NSString *)FooterHeight {return knFooterHeight; }

@end
