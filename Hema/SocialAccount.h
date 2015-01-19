//
//  SocialAccount.h
//  Hema
//
//  Created by Mac on 08/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalObjects.h"

@interface SocialAccount : GlobalObjects <UIWebViewDelegate>
@property (nonatomic,retain) NSString *DataString;
@end
