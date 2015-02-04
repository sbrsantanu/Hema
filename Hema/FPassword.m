//
//  FPassword.m
//  Hema
//
//  Created by Mac on 04/02/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "FPassword.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "NSString+PJR.h"
#import "MPApplicationGlobalConstants.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"

@interface FPassword ()<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,WebserviceProtocolDelegate>{
    CGRect mainFrame;
}
@property (nonatomic,retain) UIScrollView       *MainScrollView;
@property (nonatomic,retain) UITextField        *EmailTextField;
@property (nonatomic,retain) NSArray            *DataStringArray;
@end

@implementation FPassword

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil LoginType:(SLoginType)LoginProcessType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.AppLoginType = LoginProcessType;
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
    
    mainFrame = [[UIScreen mainScreen] bounds];
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, mainFrame.size.width, mainFrame.size.height-150)];
    [_MainScrollView setContentSize:CGSizeMake(mainFrame.size.width, mainFrame.size.height)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setBackgroundColor:[UIColor clearColor]];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 19, mainFrame.size.width-21, 21)];
    [TitleLabel setFont:[UIFont fontWithName:@"Arial-Bold" size:14.0]];
    [TitleLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [TitleLabel setText:@"Forget Password"];
    [_MainScrollView addSubview:TitleLabel];
    
    UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 29, mainFrame.size.width-170, 1)];
    [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_MainScrollView addSubview:SeperaterLabel];
    
    // Put Email id
    
    _EmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, mainFrame.size.width-40, 40)];
    [_EmailTextField customizeWithplaceholderText:@"Email Id" andImage:@"*"];
    [_EmailTextField setTag:443];
    [_EmailTextField setDelegate:self];
    [_MainScrollView addSubview:_EmailTextField];
    
    // Submit Button
    
    UIButton *SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-70 ,200, 140, 40)];
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

#pragma webservice data delegate

-(void)GetProviderServiceListDetails
{
    if (!IS_NETWORK_AVAILABLE())
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            SHOW_NETWORK_ERROR_ALERT();
        });
    } else { //WebParamCustomerForgetPassword
        
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:(_AppLoginType == LoginTypeCustomer)?UrlParameterString.WebParamCustomerForgetPassword:UrlParameterString.WebParamProviderForgetPassword ValueObject:self.DataStringArray UrlParameter:(_AppLoginType == LoginTypeCustomer)?UrlParameterString.URLParamCustomerForgetPassword:UrlParameterString.URLParamProviderForgetPassword];
        [Datadelegate setDelegate:self];
    }
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    NSLog(@"Success with ParamObjectCarrier -- %@",ParamObjectCarrier);
    
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField setText:nil];
        }
    }
    
    UIAlertView *DataAlertView = [[UIAlertView alloc] initWithTitle:([[ParamObjectCarrier objectForKey:@"errorcode"] intValue] == 1)?@"Success":@"Error" message:[ParamObjectCarrier objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [DataAlertView show];
    
}
-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier
{
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField setText:nil];
        }
    }
    
    UIAlertView *DataAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",ParamObjectCarrier] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [DataAlertView show];
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
    LoginViewController *LoginView = [[LoginViewController alloc] init];
    [self GotoDifferentViewWithAnimation:LoginView];
}

-(void)Recoverpassword
{
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField resignFirstResponder];
        }
    }
    
    BOOL IsValidated = YES;
     if ([_EmailTextField.text CleanTextField].length == 0) {
         [self ShowAletviewWIthTitle:@"Error" Tag:121 Message:@"Email Please"];
         IsValidated = NO;
     } else if (![[_EmailTextField.text CleanTextField] isEmail]) {
         [self ShowAletviewWIthTitle:@"Error" Tag:121 Message:@"valied Email Please"];
         IsValidated = NO;
     }
     
     if (IsValidated) {
         _DataStringArray = [[NSArray alloc] initWithObjects:[_EmailTextField.text CleanTextField], nil];
         [self GetProviderServiceListDetails];
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)ShowAletviewWIthTitle:(NSString *)ParamTitle Tag:(int)ParamTag Message:(NSString *)ParamMessage
{
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:ParamTitle message:ParamMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [AlertView setTag:ParamTag];
    [AlertView show];
}

@end
