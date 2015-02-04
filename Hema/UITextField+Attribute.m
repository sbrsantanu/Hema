//
//  UITextField+Attribute.m
//  Hema
//
//  Created by Mac on 11/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "UITextField+Attribute.h"
#import "UIColor+HexColor.h"
#import "Strings.h"

@implementation UITextField (Attribute)

- (void) customizeWithplaceholderText:(NSString *)text
                   andImage:(NSString *)image
{
    [self.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
    [self.layer setBorderWidth:1.0f];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorFromHex:0x755049], NSFontAttributeName: [UIFont fontWithName:@"arial" size:12.0f]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
    [self leftViewRectForBounds:CGRectMake(0, 0, self.layer.frame.size.height, self.layer.frame.size.height)];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,25, self.layer.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *AstaricLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 20, 30)];
    [AstaricLabel setBackgroundColor:[UIColor clearColor]];
    [AstaricLabel setText:image];
    [AstaricLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [paddingView addSubview:AstaricLabel];
    
    [self setFont:[UIFont fontWithName:@"arial" size:12.0f]];
    [self setTextColor:[UIColor colorFromHex:0x755049]];
}

-(void) customizeWithPlaceholderText:(NSString *)Text
                 andImageOnRightView:(NSString *)Image
                      andLeftBarText:(NSString *)laftBarText
{
    [self.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
    [self.layer setBorderWidth:1.0f];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorFromHex:0x755049], NSFontAttributeName: [UIFont fontWithName:@"arial" size:12.0f]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Text attributes:attributes];
    
    [self leftViewRectForBounds:CGRectMake(0, 0, self.layer.frame.size.height, self.layer.frame.size.height)];
    
    UIView *LeftpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,25, self.layer.frame.size.height)];
    self.leftView = LeftpaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *AstaricLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 20, 30)];
    [AstaricLabel setBackgroundColor:[UIColor clearColor]];
    [AstaricLabel setText:laftBarText];
    [AstaricLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [LeftpaddingView addSubview:AstaricLabel];
    
    UIView *RightpaddingView = [[UIView alloc] initWithFrame:CGRectMake(self.layer.frame.size.width-self.layer.frame.size.height, 0,self.layer.frame.size.height, self.layer.frame.size.height)];
    self.rightView = RightpaddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *RightBarImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, self.layer.frame.size.height/1.5, self.layer.frame.size.height/1.5)];
    [RightBarImage setBackgroundColor:[UIColor clearColor]];
    [RightBarImage setImage:[UIImage imageNamed:Image]];
    [RightpaddingView addSubview:RightBarImage];
    
    [self setFont:[UIFont fontWithName:@"arial" size:12.0f]];
    [self setTextColor:[UIColor colorFromHex:0x755049]];
}

-(void) customizeWithPlaceholderText:(NSString *)Text
                 andButtonImageOnRightView:(NSString *)Image
                      andLeftBarText:(NSString *)laftBarText
                         andSelecter:(SEL)Selecter
{
    [self.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
    [self.layer setBorderWidth:1.0f];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorFromHex:0x755049], NSFontAttributeName: [UIFont fontWithName:@"arial" size:12.0f]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Text attributes:attributes];
    
    [self leftViewRectForBounds:CGRectMake(0, 0, self.layer.frame.size.height, self.layer.frame.size.height)];
    
    UIView *LeftpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,25, self.layer.frame.size.height)];
    self.leftView = LeftpaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *AstaricLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 20, 30)];
    [AstaricLabel setBackgroundColor:[UIColor clearColor]];
    [AstaricLabel setText:laftBarText];
    [AstaricLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [LeftpaddingView addSubview:AstaricLabel];
    
    UIView *RightpaddingView = [[UIView alloc] initWithFrame:CGRectMake(self.layer.frame.size.width-self.layer.frame.size.height, 0,self.layer.frame.size.height, self.layer.frame.size.height)];
    self.rightView = RightpaddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *RightBarImage = [[UIButton alloc] initWithFrame:CGRectMake(5, 6, self.layer.frame.size.height/1.5, self.layer.frame.size.height/1.5)];
    [RightBarImage setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [RightBarImage addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    [RightpaddingView addSubview:RightBarImage];
    
    [self setFont:[UIFont fontWithName:@"arial" size:12.0f]];
    [self setTextColor:[UIColor colorFromHex:0x755049]];
}

-(void) customizeCalenderFieldWithPlaceholderText:(NSString *)Text
                                   andLeftBarText:(NSString *)laftBarText
{
    [self.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
    [self.layer setBorderWidth:1.0f];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorFromHex:0x755049], NSFontAttributeName: [UIFont fontWithName:@"arial" size:12.0f]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Text attributes:attributes];
    
    [self leftViewRectForBounds:CGRectMake(0, 0, self.layer.frame.size.height, self.layer.frame.size.height)];
    
    UIView *LeftpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,25, self.layer.frame.size.height)];
    self.leftView = LeftpaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *AstaricLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 20, 30)];
    [AstaricLabel setBackgroundColor:[UIColor clearColor]];
    [AstaricLabel setText:laftBarText];
    [AstaricLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [LeftpaddingView addSubview:AstaricLabel];
    
    UIView *RightpaddingView = [[UIView alloc] initWithFrame:CGRectMake(self.layer.frame.size.width-self.layer.frame.size.height, 0,self.layer.frame.size.height, self.layer.frame.size.height)];
    self.rightView = RightpaddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *RightBarImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, self.layer.frame.size.height/1.5, self.layer.frame.size.height/1.5)];
    [RightBarImage setBackgroundColor:[UIColor clearColor]];
    [RightBarImage setImage:[UIImage imageNamed:@"calender.png"]];
    [RightpaddingView addSubview:RightBarImage];
    
    [self setFont:[UIFont fontWithName:@"arial" size:12.0f]];
    [self setTextColor:[UIColor colorFromHex:0x755049]];
}


-(void) customizeDropdownFieldWithPlaceholderText:(NSString *)Text
                                   andLeftBarText:(NSString *)laftBarText
{
    [self.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
    [self.layer setBorderWidth:1.0f];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorFromHex:0x755049], NSFontAttributeName: [UIFont fontWithName:@"arial" size:12.0f]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Text attributes:attributes];
    
    [self leftViewRectForBounds:CGRectMake(0, 0, self.layer.frame.size.height, self.layer.frame.size.height)];
    
    UIView *LeftpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,25, self.layer.frame.size.height)];
    self.leftView = LeftpaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *AstaricLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, 20, 30)];
    [AstaricLabel setBackgroundColor:[UIColor clearColor]];
    [AstaricLabel setText:laftBarText];
    [AstaricLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [LeftpaddingView addSubview:AstaricLabel];
    
    UIView *RightpaddingView = [[UIView alloc] initWithFrame:CGRectMake(self.layer.frame.size.width-self.layer.frame.size.height, 0,self.layer.frame.size.height, self.layer.frame.size.height)];
    self.rightView = RightpaddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *RightBarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.layer.frame.size.height, self.layer.frame.size.height)];
    [RightBarImage setBackgroundColor:[UIColor clearColor]];
    [RightBarImage setImage:[UIImage imageNamed:@"dropdownicon.png"]];
    [RightpaddingView addSubview:RightBarImage];
    
    [self setFont:[UIFont fontWithName:@"arial" size:12.0f]];
    [self setTextColor:[UIColor colorFromHex:0x755049]];
}
@end
