//
//  UITextView+Extentation.h
//  Hema
//
//  Created by Mac on 24/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAPlaceholderTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *realTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

@end
