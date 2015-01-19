//
//  HowitWorksViewController.m
//  Hema
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "HowitWorksViewController.h"
#import "HelpViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "UIColor+HexColor.h"

@interface HowitWorksViewController ()

@end

@implementation HowitWorksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"HowitWorksViewController" bundle:nil]:[super initWithNibName:@"HowitWorksViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GlobalObjects *MainObject = [[GlobalObjects alloc] init];
    
    UIView *HeaderViewBackgroundView = [[UIView alloc] init];
    [HeaderViewBackgroundView setFrame:CGRectMake(0, 0, 320, 50)];
    [HeaderViewBackgroundView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *BorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
    [BorderLabel setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [HeaderViewBackgroundView addSubview:BorderLabel];
    
    // Logo Image
    
    UIImageView *LogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(135, 25, 50, 15)];
    [LogoImageView setBackgroundColor:[UIColor clearColor]];
    [LogoImageView setImage:[UIImage imageNamed:@"logo_png.png"]];
    [HeaderViewBackgroundView addSubview:LogoImageView];
    
    UIButton *BackButton =  [[UIButton alloc] initWithFrame:CGRectMake(0, 15, 26, 26)];
    [BackButton setBackgroundColor:[UIColor clearColor]];
    [BackButton setBackgroundImage:[UIImage imageNamed:@"goback.png"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(GotoHelp) forControlEvents:UIControlEventTouchUpInside];
    [HeaderViewBackgroundView addSubview:BackButton];
    
    [self.view addSubview:HeaderViewBackgroundView];
    [self.view addSubview:[MainObject UIViewSetFooterView]];
    
    UIView *HeaderNavigationViewBackgroundView = [[UIView alloc] init];
    [HeaderNavigationViewBackgroundView setFrame:CGRectMake(0, 50, 320, 35)];
    [HeaderNavigationViewBackgroundView setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    
    // Home Button
    
    UIButton *HomeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    [HomeButton setBackgroundColor:[UIColor clearColor]];
    [HomeButton setTitle:@"Home" forState:UIControlStateNormal];
    [HomeButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [HomeButton addTarget:self action:@selector(GotoHome) forControlEvents:UIControlEventTouchUpInside];
    [HomeButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [HeaderNavigationViewBackgroundView addSubview:HomeButton];
    
    // Login Button
    
    UIButton *LoginButton = [[UIButton alloc] initWithFrame:CGRectMake(81, 0, 80, 35)];
    [LoginButton setBackgroundColor:[UIColor clearColor]];
    [LoginButton setTitle:@"Login" forState:UIControlStateNormal];
    [LoginButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [LoginButton addTarget:self action:@selector(GotoLogin) forControlEvents:UIControlEventTouchUpInside];
    [LoginButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [HeaderNavigationViewBackgroundView addSubview:LoginButton];
    
    // Register Button
    
    UIButton *RegisterButton = [[UIButton alloc] initWithFrame:CGRectMake(162, 0, 80, 35)];
    [RegisterButton setBackgroundColor:[UIColor clearColor]];
    [RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    [RegisterButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [RegisterButton addTarget:self action:@selector(GotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [RegisterButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [HeaderNavigationViewBackgroundView addSubview:RegisterButton];
    
    // Help Button
    
    UIButton *HelpButton = [[UIButton alloc] initWithFrame:CGRectMake(243, 0, 80, 35)];
    [HelpButton setBackgroundColor:[UIColor whiteColor]];
    [HelpButton setTitle:@"Help" forState:UIControlStateNormal];
    [HelpButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [HelpButton addTarget:self action:@selector(GotoHelp) forControlEvents:UIControlEventTouchUpInside];
    [HelpButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
    [HeaderNavigationViewBackgroundView addSubview:HelpButton];
    
    [self.view addSubview:HeaderNavigationViewBackgroundView];
}
-(void)GotoHome
{
    HomeViewController *HomeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:HomeView];
}

-(void)GotoLogin
{
    LoginViewController *LoginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:LoginView];
}

-(void)GotoRegister
{
    RegisterViewController *Register = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:Register];
}

-(void)GotoHelp
{
    HelpViewController *HelpView = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:HelpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
