//
//  UIButton+Dashboard.m
//  Hema
//
//  Created by Mac on 07/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "UIButton+Dashboard.h"
#import "UIColor+HexColor.h"

@implementation UIButton (Dashboard)

-(id)CustomizeDashboardButtonWithImagename:(NSString *)ImageName WithTitle:(NSString *)TitleString
{
    self.layer.borderColor = [UIColor colorFromHex:0xcfcfcf].CGColor;
    self.layer.borderWidth = 1.0f;
    [self setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    
    UIImageView *ButtonImage = [[UIImageView alloc]
                                initWithFrame:CGRectMake(self.layer.frame.size.width/2-11, 10, 22, 22)];
    [ButtonImage setBackgroundColor:[UIColor clearColor]];
    [ButtonImage setImage:[UIImage imageNamed:ImageName]];
    [self addSubview:ButtonImage];
    
    UILabel *Titlelabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(0, self.layer.frame.size.height/2+5, self.layer.frame.size.width, 20)];
    [Titlelabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [Titlelabel setTextColor:[UIColor colorFromHex:0x614332]];
    [Titlelabel setNumberOfLines:0];
    [Titlelabel setText:TitleString];
    [Titlelabel setBackgroundColor:[UIColor clearColor]];
    [Titlelabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:Titlelabel];
    
    return self;
}

@end
