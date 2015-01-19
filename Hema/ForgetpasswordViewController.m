//
//  ForgetpasswordViewController.m
//  Hema
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "ForgetpasswordViewController.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"

@interface ForgetpasswordViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    CGRect mainFrame;
}
@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) UITextField *EmailTextField;
@end

@implementation ForgetpasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mainFrame = [[UIScreen mainScreen] bounds];
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Login"]];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 135, mainFrame.size.width, mainFrame.size.height-150)];
    [_MainScrollView setContentSize:CGSizeMake(mainFrame.size.width, 250)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    UILabel *TitleLabel = (UILabel *)[self.view viewWithTag:11];
    [TitleLabel setFont:[UIFont fontWithName:@"Arial-Bold" size:14.0]];
    [TitleLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    
    // Put Email id
    
    _EmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, mainFrame.size.width-40, 40)];
    [_EmailTextField customizeWithplaceholderText:@"Email Id" andImage:@" "];
    [_EmailTextField setTag:443];
    [_EmailTextField setDelegate:self];
    [_MainScrollView addSubview:_EmailTextField];
    
    // Submit Button
    
    UIButton *SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-70 ,80, 140, 40)];
    [SubmitButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [SubmitButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [SubmitButton.layer setCornerRadius:3.0f];
    [SubmitButton addTarget:self action:@selector(Recoverpassword) forControlEvents:UIControlEventTouchUpInside];
    [SubmitButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [SubmitButton setTag:104];
    [_MainScrollView addSubview:SubmitButton];
    
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField setDelegate:self];
        }
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
        [_MainScrollView setContentOffset:CGPointMake(0, 0)];
    } completion:nil];
    return YES;
}

-(void)GobacktoPrevPage
{
    LoginViewController *LoginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:LoginView];
}

-(void)Recoverpassword
{
    
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
