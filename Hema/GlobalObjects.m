//
//  GlobalObjects.m
//  Hema
//
//  Created by Mac on 16/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "GlobalObjects.h"
#import "UIColor+HexColor.h"
#import "GlobalStrings.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HelpViewController.h"
#import "SocialAccount.h"
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
#import <Security/Security.h>
#import "Customerdashboard.h"
#import "Providerdashboard.h"

@interface GlobalObjects()
{
    CGRect mainFrame;
}
@end

@implementation GlobalObjects

-(UIView *)UIViewSetHeaderView
{
    mainFrame = [[UIScreen mainScreen] bounds];
    
    UIView *HeaderViewBackgroundView = [[UIView alloc] init];
    [HeaderViewBackgroundView setFrame:CGRectMake(0, 0, mainFrame.size.width, 50)];
    [HeaderViewBackgroundView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *BorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, mainFrame.size.width, 1)];
    [BorderLabel setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [HeaderViewBackgroundView addSubview:BorderLabel];
    
    
    // Logo Image
    
    UIImageView *LogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-25, 25, 50, 15)];
    [LogoImageView setBackgroundColor:[UIColor clearColor]];
    [LogoImageView setImage:[UIImage imageNamed:@"logo_png.png"]];
    [HeaderViewBackgroundView addSubview:LogoImageView];
    
    return HeaderViewBackgroundView;
}

-(UIView *)UIViewSetHeaderViewWithbackButton:(BOOL)backButton
{
    mainFrame = [[UIScreen mainScreen] bounds];
    
    UIView *HeaderViewBackgroundView = [[UIView alloc] init];
    [HeaderViewBackgroundView setFrame:CGRectMake(0, 0, mainFrame.size.width, 50)];
    [HeaderViewBackgroundView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *BorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, mainFrame.size.width, 1)];
    [BorderLabel setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [HeaderViewBackgroundView addSubview:BorderLabel];
    
    mainFrame = [[UIScreen mainScreen] bounds];
    
    // Back Button
    
    if (backButton) {
        
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 32, 32)];
        [HeaderViewBackgroundView addSubview:backImageView];
        [backImageView setBackgroundColor:[UIColor clearColor]];
        [backImageView setImage:[UIImage imageNamed:@"goback.png"]];
        
        UIButton *SetbackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 49)];
        [SetbackButton addTarget:self action:@selector(Goback:) forControlEvents:UIControlEventTouchUpInside];
        [SetbackButton setBackgroundColor:[UIColor clearColor]];
        [HeaderViewBackgroundView addSubview:SetbackButton];
    }
    
    // Logo Image
    
    UIImageView *LogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-25, 25, 50, 15)];
    [LogoImageView setBackgroundColor:[UIColor clearColor]];
    [LogoImageView setImage:[UIImage imageNamed:@"logo_png.png"]];
    [HeaderViewBackgroundView addSubview:LogoImageView];
    
    return HeaderViewBackgroundView;
}

-(UIView *)UIViewSetHeaderNavigationViewWithSelectedTab:(NSString *)Selectedtab
{
    mainFrame = [[UIScreen mainScreen] bounds];
    
    UIView *HeaderNavigationViewBackgroundView = [[UIView alloc] init];
    [HeaderNavigationViewBackgroundView setFrame:CGRectMake(0, 50, mainFrame.size.width, 35)];
    [HeaderNavigationViewBackgroundView setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    
    // Home Button
    
    UIButton *HomeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width/4, 35)];
    [HomeButton setTitle:@"Home" forState:UIControlStateNormal];
    [HomeButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [HomeButton addTarget:self action:@selector(GotoHome) forControlEvents:UIControlEventTouchUpInside];
    if ([Selectedtab isEqualToString:@"Home"]) {
        [HomeButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [HomeButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    } else {
        [HomeButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [HomeButton setBackgroundColor:[UIColor clearColor]];
    }
    [HeaderNavigationViewBackgroundView addSubview:HomeButton];
    
    // Login Button
    
    if ([[self ISUserLogedin] isEqualToString:@"Y"]) {
        
        UIButton *LoginButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *1 )+1, 0, mainFrame.size.width/4, 35)];
        [LoginButton setTitle:@"Logout" forState:UIControlStateNormal];
        [LoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        [LoginButton addTarget:self action:@selector(DoLogout) forControlEvents:UIControlEventTouchUpInside];
        if ([Selectedtab isEqualToString:@"Logout"]) {
            [LoginButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [LoginButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
        } else {
            [LoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
            [LoginButton setBackgroundColor:[UIColor clearColor]];
        }
        [HeaderNavigationViewBackgroundView addSubview:LoginButton];
        
        // Register Button
        
        UIButton *RegisterButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *2 ), 0, mainFrame.size.width/4, 35)];
        [RegisterButton setTitle:@"Dashboard" forState:UIControlStateNormal];
        [RegisterButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        [RegisterButton addTarget:self action:@selector(GotoDashboard) forControlEvents:UIControlEventTouchUpInside];
        if ([Selectedtab isEqualToString:@"Dashboard"]) {
            [RegisterButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [RegisterButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
        } else {
            [RegisterButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
            [RegisterButton setBackgroundColor:[UIColor clearColor]];
        }
        [HeaderNavigationViewBackgroundView addSubview:RegisterButton];
        
    } else {
        
        UIButton *LoginButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *1 )+1, 0, mainFrame.size.width/4, 35)];
        [LoginButton setTitle:@"Login" forState:UIControlStateNormal];
        [LoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        [LoginButton addTarget:self action:@selector(GotoLogin) forControlEvents:UIControlEventTouchUpInside];
        if ([Selectedtab isEqualToString:@"Login"]) {
            [LoginButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [LoginButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
        } else {
            [LoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
            [LoginButton setBackgroundColor:[UIColor clearColor]];
        }
        [HeaderNavigationViewBackgroundView addSubview:LoginButton];
        
        // Register Button
        
        UIButton *RegisterButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *2 ), 0, mainFrame.size.width/4, 35)];
        [RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
        [RegisterButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        [RegisterButton addTarget:self action:@selector(GotoRegister) forControlEvents:UIControlEventTouchUpInside];
        if ([Selectedtab isEqualToString:@"Register"]) {
            [RegisterButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [RegisterButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
        } else {
            [RegisterButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
            [RegisterButton setBackgroundColor:[UIColor clearColor]];
        }
        [HeaderNavigationViewBackgroundView addSubview:RegisterButton];
    }
    
    // Help Button
    
    UIButton *HelpButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *3 ), 0, mainFrame.size.width/4, 35)];
    [HelpButton setTitle:@"Help" forState:UIControlStateNormal];
    [HelpButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [HelpButton addTarget:self action:@selector(GotoHelp) forControlEvents:UIControlEventTouchUpInside];
    if ([Selectedtab isEqualToString:@"Help"]) {
        [HelpButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [HelpButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    } else {
        [HelpButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [HelpButton setBackgroundColor:[UIColor clearColor]];
    }
    [HeaderNavigationViewBackgroundView addSubview:HelpButton];
    
    return HeaderNavigationViewBackgroundView;
}

-(NSString *)ISUserLogedin
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrIsInvisible)];
}
-(NSString *)GetUserName
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrAccount)];
}
-(NSString *)GetUserPassword
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrComment)];
}
-(NSString *)ISUserRemember
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrIsNegative)];
}
-(NSString *)GetuserType
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrService)];
}
-(NSString *)Getlogedinuserid
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrCreator)];
}
-(NSString *)Getlogedinuseremail
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrLabel)];
}
-(NSString *)Getlogedinusername
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    return [MykeychainWrapper objectForKey:(__bridge id)(kSecAttrDescription)];
}

/**
-(UIView *)UIViewSetHeaderAfterLoginNavigationViewWithSelectedTab:(NSString *)Selectedtab
{
    mainFrame = [[UIScreen mainScreen] bounds];
    
    UIView *HeaderNavigationViewBackgroundView = [[UIView alloc] init];
    [HeaderNavigationViewBackgroundView setFrame:CGRectMake(0, 50, mainFrame.size.width, 35)];
    [HeaderNavigationViewBackgroundView setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    
    // Home Button
    
    UIButton *HomeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width/4, 35)];
    [HomeButton setTitle:@"Home" forState:UIControlStateNormal];
    [HomeButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [HomeButton addTarget:self action:@selector(GotoHome) forControlEvents:UIControlEventTouchUpInside];
    if ([Selectedtab isEqualToString:@"Home"]) {
        [HomeButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [HomeButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    } else {
        [HomeButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [HomeButton setBackgroundColor:[UIColor clearColor]];
    }
    [HeaderNavigationViewBackgroundView addSubview:HomeButton];
    
    // Login Button
    
    UIButton *LoginButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *1 )+1, 0, mainFrame.size.width/4, 35)];
    [LoginButton setTitle:@"Logout" forState:UIControlStateNormal];
    [LoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [LoginButton addTarget:self action:@selector(DoLogout) forControlEvents:UIControlEventTouchUpInside];
    if ([Selectedtab isEqualToString:@"Logout"]) {
        [LoginButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [LoginButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    } else {
        [LoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [LoginButton setBackgroundColor:[UIColor clearColor]];
    }
    [HeaderNavigationViewBackgroundView addSubview:LoginButton];
    
    // Register Button
    
    UIButton *RegisterButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *2 ), 0, mainFrame.size.width/4, 35)];
    [RegisterButton setTitle:@"Dashboard" forState:UIControlStateNormal];
    [RegisterButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [RegisterButton addTarget:self action:@selector(GotoRegister) forControlEvents:UIControlEventTouchUpInside];
    if ([Selectedtab isEqualToString:@"Dashboard"]) {
        [RegisterButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [RegisterButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    } else {
        [RegisterButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [RegisterButton setBackgroundColor:[UIColor clearColor]];
    }
    [HeaderNavigationViewBackgroundView addSubview:RegisterButton];
    
    // Help Button
    
    UIButton *HelpButton = [[UIButton alloc] initWithFrame:CGRectMake((mainFrame.size.width/4 *3 ), 0, mainFrame.size.width/4, 35)];
    [HelpButton setTitle:@"Help" forState:UIControlStateNormal];
    [HelpButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [HelpButton addTarget:self action:@selector(GotoHelp) forControlEvents:UIControlEventTouchUpInside];
    if ([Selectedtab isEqualToString:@"Help"]) {
        [HelpButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [HelpButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
    } else {
        [HelpButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [HelpButton setBackgroundColor:[UIColor clearColor]];
    }
    [HeaderNavigationViewBackgroundView addSubview:HelpButton];
    
    return HeaderNavigationViewBackgroundView;
}
*/
-(UIView *)UIViewSetFooterView
{
    UIView *FooterBackgroundView = [[UIView alloc] init];
    [FooterBackgroundView setFrame:CGRectMake([GlobalStrings.FooterXposition floatValue], [GlobalStrings.FooterYposition floatValue], [GlobalStrings.FooterWidth floatValue], [GlobalStrings.FooterHeight floatValue])];
    [FooterBackgroundView setBackgroundColor:[UIColor colorFromHex:0x452715]];
    
    /**
     *  Add social Icon
     */
    
    CGRect mainFrameone = [[UIScreen mainScreen] bounds];
    
    // Twitter Button
    
    float XPositionStart = mainFrameone.size.width/2-74;
    float XGapStart      = 40.00;
    float YPositionStart = 10.0f;
    float ImageHeight    = 28.0f;
    
    UIButton *FooterTwitterButton = [[UIButton alloc] initWithFrame:CGRectMake(XPositionStart, YPositionStart, ImageHeight, ImageHeight)];
    [FooterTwitterButton setBackgroundColor:[UIColor clearColor]];
    [FooterTwitterButton setBackgroundImage:[UIImage imageNamed:[GlobalStrings FooterSocialTwitterIcon]] forState:UIControlStateNormal];
    [FooterTwitterButton addTarget:self action:@selector(FooterLinkClicked:) forControlEvents:UIControlEventTouchUpInside];
    [FooterTwitterButton setTag:10024];
    [FooterBackgroundView addSubview:FooterTwitterButton];
    
    // Facebook Button
    
    UIButton *FooterFacebookButton = [[UIButton alloc] initWithFrame:CGRectMake(XPositionStart+XGapStart*1, YPositionStart, ImageHeight, ImageHeight)];
    [FooterFacebookButton setBackgroundColor:[UIColor clearColor]];
    [FooterFacebookButton setBackgroundImage:[UIImage imageNamed:[GlobalStrings FooterSocialFacebookIcon]] forState:UIControlStateNormal];
    [FooterFacebookButton setTag:10025];
    [FooterFacebookButton addTarget:self action:@selector(FooterLinkClicked:) forControlEvents:UIControlEventTouchUpInside];
    [FooterBackgroundView addSubview:FooterFacebookButton];
    
    // Youtube Button
    
    UIButton *FooterYoutubeButton = [[UIButton alloc] initWithFrame:CGRectMake(XPositionStart+XGapStart*2, YPositionStart, ImageHeight, ImageHeight)];
    [FooterYoutubeButton setBackgroundColor:[UIColor clearColor]];
    [FooterYoutubeButton setBackgroundImage:[UIImage imageNamed:[GlobalStrings FooterSocialYoutubeIcon]] forState:UIControlStateNormal];
    [FooterYoutubeButton setTag:10026];
    [FooterYoutubeButton addTarget:self action:@selector(FooterLinkClicked:) forControlEvents:UIControlEventTouchUpInside];
    [FooterBackgroundView addSubview:FooterYoutubeButton];
    
    // GooglePlus Button
    
    UIButton *FooterGooglePlusButton = [[UIButton alloc] initWithFrame:CGRectMake(XPositionStart+XGapStart*3, YPositionStart, ImageHeight, ImageHeight)];
    [FooterGooglePlusButton setBackgroundColor:[UIColor clearColor]];
    [FooterGooglePlusButton setBackgroundImage:[UIImage imageNamed:[GlobalStrings FooterSocialGoogleplusIcon]] forState:UIControlStateNormal];
    [FooterGooglePlusButton setTag:10027];
    [FooterGooglePlusButton addTarget:self action:@selector(FooterLinkClicked:) forControlEvents:UIControlEventTouchUpInside];
    [FooterBackgroundView addSubview:FooterGooglePlusButton];
    
    
    
    
    /**
     *  Add Copyright text into footer
     */
    
    UILabel *CopyrightFooter = [[UILabel alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-130, 40, mainFrame.size.width, 15)];
    [CopyrightFooter setBackgroundColor:[UIColor clearColor]];
    [CopyrightFooter setText:GlobalStrings.FooterCopyrightText];
    [CopyrightFooter setFont:[UIFont fontWithName:GlobalStrings.GlobalFontname size:[GlobalStrings.FooterCopyrightFontSize floatValue]]];
    [CopyrightFooter setTextColor:[UIColor colorFromHex:0xffffff]];
    [FooterBackgroundView addSubview:CopyrightFooter];
    
    /**
     *  @return Footerview
     */
    return FooterBackgroundView;
}

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}
-(IBAction)FooterLinkClicked:(UIButton *)sender
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    SocialAccount *FooterAccount = [[SocialAccount alloc] init];
    switch (sender.tag) {
        case 10024:
            [mainDelegate setAccountType:SocialAccountTypeTwitter];
            break;
        case 10025:
            [mainDelegate setAccountType:SocialAccountTypeFacebook];
            break;
        case 10026:
            [mainDelegate setAccountType:SocialAccountTypeYoutube];
            break;
        case 10027:
            [mainDelegate setAccountType:SocialAccountTypeGooglePlus];
            break;
        default:
            [mainDelegate setAccountType:SocialAccountTypeNone];
            break;
    }
    [self presentViewController:FooterAccount animated:YES completion:nil];
}

-(void)GotoHome
{
    HomeViewController *HomeView = [[HomeViewController alloc] init];
    [self GotoDifferentViewWithAnimation:HomeView];
}

-(void)GotoLogin
{
    LoginViewController *LoginView = [[LoginViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginView];
}

-(void)GotoRegister
{
    RegisterViewController *Register = [[RegisterViewController alloc] init];
    [self GotoDifferentViewWithAnimation:Register];
}

-(void)GotoHelp
{
    HelpViewController *HelpView = [[HelpViewController alloc] init];
    [self GotoDifferentViewWithAnimation:HelpView];
}
-(void)DoLogout
{
    KeychainItemWrapper *MykeychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"HEMA_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    
    NSArray *secItemClasses = @[(__bridge id)kSecAttrAccessGroup,
                                (__bridge id)kSecAttrCreationDate,
                                (__bridge id)kSecAttrModificationDate,
                                (__bridge id)kSecAttrDescription,
                                (__bridge id)kSecAttrComment,
                                (__bridge id)kSecAttrCreator,
                                (__bridge id)kSecAttrType,
                                (__bridge id)kSecAttrLabel,
                                (__bridge id)kSecAttrIsInvisible,
                                (__bridge id)kSecAttrIsNegative,
                                (__bridge id)kSecAttrAccount,
                                (__bridge id)kSecAttrService,
                                (__bridge id)kSecAttrGeneric];
    for (id secItemClass in secItemClasses) {
        NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
        SecItemDelete((__bridge CFDictionaryRef)spec);
    }
    
    [MykeychainWrapper resetKeychainItem];
    
    LoginViewController *LoginView = [[LoginViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginView];
}
-(void)GotoDashboard
{
    if ([[self GetuserType] isEqualToString:@"P"]) {
        Providerdashboard *ProvDashboard = [[Providerdashboard alloc] init];
        [self GotoDifferentViewWithAnimation:ProvDashboard];
    } else {
        Customerdashboard *CustmerDashBoard = [[Customerdashboard alloc] init];
        [self GotoDifferentViewWithAnimation:CustmerDashBoard];
    }
}

-(IBAction)Goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
