//
//  LoginViewController.m
//  Hema
//
//  Created by Mac on 15/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "LoginViewController.h"
#import "UITextField+Attribute.h"
#import "UIColor+HexColor.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HelpViewController.h"
#import "RegisterViewController.h"
#import "ForgetpasswordViewController.h"
#import "Customerdashboard.h"
#import "Providerdashboard.h"

typedef enum {
    UserLoginTypeNone,
    UserLoginTypeCustomer,
    UserLoginTypeprovider
} UserLoginType;

typedef enum {
    RememberMeTypenone,
    RememberMeTypeyes
} RememberMeType;

@interface LoginViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    CGRect mainFrame;
}
@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) UITextField *UsernameTextField;
@property (nonatomic,retain) UITextField *userpasswordtextField;
@property (nonatomic,retain) UIButton *RemembermeButton;
@property (nonatomic,retain) UIButton *LoginButton;
@property (assign) UserLoginType UserloginMode;
@property (assign) RememberMeType UserRememberMeMode;

@property (nonatomic,retain) UIButton *CustomerLoginButton;
@property (nonatomic,retain) UIButton *ProviderLoginButton;

@property (nonatomic,retain) UITextField *UserId;
@property (nonatomic,retain) UITextField *UserPassword;

@property (nonatomic,retain) UIView *CustomerLoginFooter;
@property (nonatomic,retain) UIView *ProviderLoginFooter;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        mainFrame = [[UIScreen mainScreen] bounds];
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _UserloginMode = UserLoginTypeCustomer;
    _UserRememberMeMode = RememberMeTypenone;
    
    [self.view addSubview:[self UIViewSetHeaderView]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Login"]];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, mainFrame.size.width, mainFrame.size.height-150)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    _CustomerLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(19, 11, mainFrame.size.width/2-20, 40)];
    [_CustomerLoginButton setBackgroundColor:[UIColor colorFromHex:0x452715]];
    [_CustomerLoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_CustomerLoginButton setTitle:@"Customer Login" forState:UIControlStateNormal];
    [_CustomerLoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_CustomerLoginButton addTarget:self action:@selector(LoginTypeAccess) forControlEvents:UIControlEventTouchUpInside];
    [_CustomerLoginButton setTag:121];
    [_MainScrollView addSubview:_CustomerLoginButton];
    
    _ProviderLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(mainFrame.size.width/2, 11, mainFrame.size.width/2-20, 40)];
    [_ProviderLoginButton setBackgroundColor:[UIColor clearColor]];
    [_ProviderLoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_ProviderLoginButton setTitle:@"Provider Login" forState:UIControlStateNormal];
    [_ProviderLoginButton setTitleColor:[UIColor colorFromHex:0x452715] forState:UIControlStateNormal];
    [_ProviderLoginButton addTarget:self action:@selector(LoginTypeAccess) forControlEvents:UIControlEventTouchUpInside];
    [_ProviderLoginButton setTag:122];
    [_MainScrollView addSubview:_ProviderLoginButton];
    
    UILabel *Deviderlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, mainFrame.size.width-40, 1)];
    [Deviderlabel setBackgroundColor:[UIColor lightGrayColor]];
    [_MainScrollView addSubview:Deviderlabel];
    
    _UserId = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, mainFrame.size.width-40, 40)];
    [_UserId customizeWithplaceholderText:@"Username" andImage:@" "];
    [_UserId setTag:443];
    [_MainScrollView addSubview:_UserId];

    _UserPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, mainFrame.size.width-40, 40)];
    [_UserPassword customizeWithplaceholderText:@"Passowrd" andImage:@" "];
    [_UserPassword setTag:444];
    [_MainScrollView addSubview:_UserPassword];
    
    UIImageView *UsernameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 71, 12, 12)];
    [UsernameImageView setBackgroundColor:[UIColor clearColor]];
    [UsernameImageView setImage:[UIImage imageNamed:@"icon1.png"]];
    [_MainScrollView addSubview:UsernameImageView];
    
    UIImageView *PasswordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 144, 12, 12)];
    [PasswordImageView setBackgroundColor:[UIColor clearColor]];
    [PasswordImageView setImage:[UIImage imageNamed:@"icon2-1.png"]];
    [_MainScrollView addSubview:PasswordImageView];
    
    UILabel *UsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 71, 200, 12)];
    [UsernameLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [UsernameLabel setText:@"Username"];
    [UsernameLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [_MainScrollView addSubview:UsernameLabel];
    
    UILabel *PasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 143, 200, 12)];
    [PasswordLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [PasswordLabel setText:@"Password"];
    [PasswordLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [_MainScrollView addSubview:PasswordLabel];
    
    _RemembermeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 210, 22, 22)];
    [_RemembermeButton setBackgroundColor:[UIColor clearColor]];
    [_RemembermeButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [_RemembermeButton addTarget:self action:@selector(Rememberme) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:_RemembermeButton];
    
    
    UILabel *RemembermeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 210, 200, 22)];
    [RemembermeLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [RemembermeLabel setText:@"Remember Me"];
    [RemembermeLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [_MainScrollView addSubview:RemembermeLabel];
    
    // Find Now Button
    
    _LoginButton = [[UIButton alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-70 ,250, 140, 40)];
    [_LoginButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_LoginButton setTitle:@"Login" forState:UIControlStateNormal];
    [_LoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_LoginButton.layer setCornerRadius:3.0f];
    [_LoginButton addTarget:self action:@selector(LoginProcess) forControlEvents:UIControlEventTouchUpInside];
    [_LoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_LoginButton setTag:104];
    [_MainScrollView addSubview:_LoginButton];
    
    //
    
    _CustomerLoginFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 295, mainFrame.size.width, 50)];
    
    UIButton *CRegisterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
    [CRegisterButton setBackgroundColor:[UIColor clearColor]];
    [CRegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    [CRegisterButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [CRegisterButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
    [CRegisterButton addTarget:self action:@selector(GotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [_CustomerLoginFooter addSubview:CRegisterButton];
    
    UILabel *Seperaterlabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 1, 10)];
    [Seperaterlabel setBackgroundColor:[UIColor lightGrayColor]];
    [_CustomerLoginFooter addSubview:Seperaterlabel];
    
    UIButton *CForgetpassButton = [[UIButton alloc] initWithFrame:CGRectMake(71, 0, 120, 50)];
    [CForgetpassButton setBackgroundColor:[UIColor clearColor]];
    [CForgetpassButton setTitle:@"Forget Password" forState:UIControlStateNormal];
    [CForgetpassButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [CForgetpassButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
    [CForgetpassButton addTarget:self action:@selector(Forgetpassword) forControlEvents:UIControlEventTouchUpInside];
    [_CustomerLoginFooter addSubview:CForgetpassButton];
    
    [_MainScrollView addSubview:_CustomerLoginFooter];
    //
    
    _ProviderLoginFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 295, mainFrame.size.width, 50)];
    [_ProviderLoginFooter setHidden:YES];
    
    UIButton *PForgetpassButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    [PForgetpassButton setBackgroundColor:[UIColor clearColor]];
    [PForgetpassButton setTitle:@"Forget Password" forState:UIControlStateNormal];
    [PForgetpassButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [PForgetpassButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
    [PForgetpassButton addTarget:self action:@selector(Forgetpassword) forControlEvents:UIControlEventTouchUpInside];
    [_ProviderLoginFooter addSubview:PForgetpassButton];
    
    [_MainScrollView addSubview:_ProviderLoginFooter];
    
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField setDelegate:self];
        }
    }
    
    [_MainScrollView setContentSize:CGSizeMake(mainFrame.size.width, mainFrame.size.height)];
}
-(void)LoginProcess
{
    if (_UserloginMode == UserLoginTypeprovider) {
        Providerdashboard *Pdashboard = [[Providerdashboard alloc] init];
        [self.navigationController pushViewController:Pdashboard animated:YES];
    } else {
        Customerdashboard *CdashBoard = [[Customerdashboard alloc] init];
        [self.navigationController pushViewController:CdashBoard animated:YES];
    }
}
-(void)Forgetpassword
{
    ForgetpasswordViewController *forgetpassword = [[ForgetpasswordViewController alloc] init];
    [self GotoDifferentViewWithAnimation:forgetpassword];
}
-(void)Rememberme
{
    if (_UserRememberMeMode == RememberMeTypenone) {
        [_RemembermeButton setImage:[UIImage imageNamed:@"tick.png"] forState:UIControlStateNormal];
        _UserRememberMeMode = RememberMeTypeyes;
    } else {
        [_RemembermeButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        _UserRememberMeMode = RememberMeTypenone;
    }
}
-(void)LoginTypeAccess
{
    if (_UserloginMode == UserLoginTypeCustomer) {
        
        [_CustomerLoginButton setTitleColor:[UIColor colorFromHex:0x452715] forState:UIControlStateNormal];
        [_CustomerLoginButton setBackgroundColor:[UIColor clearColor]];
        
        [_ProviderLoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [_ProviderLoginButton setBackgroundColor:[UIColor colorFromHex:0x452715]];
        
        _UserloginMode = UserLoginTypeprovider;
        
        [UIView animateWithDuration:1.0f animations:^(void){
            [_CustomerLoginFooter setHidden:YES];
        } completion:^(BOOL finished){
            [_ProviderLoginFooter setHidden:NO];
        }];
        
    } else {
        
        [_CustomerLoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [_CustomerLoginButton setBackgroundColor:[UIColor colorFromHex:0x452715]];
        
        [_ProviderLoginButton setTitleColor:[UIColor colorFromHex:0x452715] forState:UIControlStateNormal];
        [_ProviderLoginButton setBackgroundColor:[UIColor clearColor]];
        
        _UserloginMode = UserLoginTypeCustomer;
        
        [UIView animateWithDuration:1.0f animations:^(void){
            [_ProviderLoginFooter setHidden:YES];
        } completion:^(BOOL finished){
            [_CustomerLoginFooter setHidden:NO];
        }];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 443) {
        [UIView animateWithDuration:1.0 animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 80)];
        } completion:nil];
    } else if (textField.tag == 444) {
        [UIView animateWithDuration:1.0 animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 145)];
        } completion:nil];
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:1.0 animations:^(void){
        [_MainScrollView setContentOffset:CGPointMake(0, -20)];
    } completion:nil];
    return YES;
}

-(void)FindNow
{
    NSLog(@"FindNow");
}

-(void)viewDidDisappear:(BOOL)animated
{
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField resignFirstResponder];
            [DatatextField setText:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
