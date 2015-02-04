//
//  UITextField+Attribute.h
//  Hema
//
//  Created by Mac on 11/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Attribute)

- (void) customizeWithplaceholderText:(NSString *)text
                   andImage:(NSString *)image;

-(void) customizeWithPlaceholderText:(NSString *)Text
                 andImageOnRightView:(NSString *)Image
                      andLeftBarText:(NSString *)laftBarText;

-(void) customizeCalenderFieldWithPlaceholderText:(NSString *)Text
                                   andLeftBarText:(NSString *)laftBarText;

-(void) customizeDropdownFieldWithPlaceholderText:(NSString *)Text
                                   andLeftBarText:(NSString *)laftBarText;

-(void) customizeWithPlaceholderText:(NSString *)Text
           andButtonImageOnRightView:(NSString *)Image
                      andLeftBarText:(NSString *)laftBarText
                         andSelecter:(SEL)Selecter;
@end
