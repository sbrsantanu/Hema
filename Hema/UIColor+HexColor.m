//
//  UIColor+HexColor.m
//  OCRScanner
//
//  Created by Mac on 26/09/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorFromHex:(unsigned long)hex
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

@end
