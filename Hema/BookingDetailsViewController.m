//
//  BookingDetailsViewController.m
//  Hema
//
//  Created by Mac on 31/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "BookingDetailsViewController.h"
#import "AppDelegate.h"
#import "UIColor+HexColor.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "RegisterViewController.h"
#import "BookingListViewController.h"
#import "HomeViewController.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"
#import "NSString+PJR.h"

#pragma Booking Webservice param

#define BDBookingWSSeperater       @"Booking"
#define BDBookingWSMessage         @"message"
#define BDBookingWSErrorCode       @"errorcode"
#define BDBookingId                @"id"
#define BDBookingcategory          @"category"
#define BDBookingenddate           @"end_date"
#define BDBookingeventplace        @"event_place"
#define BDBookingname              @"name"
#define BDBookingshortdescription  @"long_description"
#define BDBookingstartdate         @"start_date"
#define BDBookingeventLocation     @"event_location"
#define BDBookingWSErrorTitle      @"Sorry"
#define BDBookingWSErrorDesc       @"Uanble To get data"
#define BDBookingWSTryAgain        @"Try Again"
#define BDBookingWScancel          @"Cancel"
#define BDBookingWSOk              @"Ok"

#pragma Form Validation String

#define BDFVnameblank              @"Name Can't Be Blank"
#define BDFVemailblank             @"Email Can't Be Blank"
#define BDFVEmailValied            @"Email is not valied"
#define BDFVTitleblankn            @"Title can't be blank"
#define BDFVDescblank              @"Description can't be blank"

#pragma labelText

#define BookingTitleText           @"Title"
#define BookingStartDateText       @"Start Date"
#define BookingEndDateText         @"End Date"
#define BookingPlaceOneText        @"Event Location"
#define BookingPlaceTwoText        @"Event Place"
#define BookingDetailsText         @"Description"
#define BDHemaAdminContactText     @"Contact With HEMA Admin"
#define CTUserNameText             @"Contact Name"
#define CTUserEmailText            @"Email"
#define CTMessageTitleText         @"Message Title"
#define CTMDetailsText             @"Description"

#define ApplyButtonText            @"Apply"
#define SubmitButtonText           @"Submit"

#define BDNewlineText              @"\n"
#define BDFontName                 @"Helvetica"

typedef enum {
    ContactSectionDisplaynone,
    ContactSectionDisplayBlock
} ContactSectionDisplay;

typedef enum {
    WebserviceTypeNone,
    WebserviceTypeBookingDetails,
    WebserviceTypeBookingApply
} WebserviceType;

@interface BookingDetailsViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,WebserviceProtocolDelegate,UIAlertViewDelegate>
{
    CGRect mainFrame;
    float NextTextFiled,NextlabelFiled,Difference,TextfieldWidth,TextfieldHeight,TextfieldXposition,SubmitButtonWidth,SubmitButtonHeight,SubmitButtonxposition;
    int nextdatatag;
}
@property (nonatomic,retain) UIScrollView *mainScrollView;

@property (nonatomic,retain) NSString *BookingTitle;
@property (nonatomic,retain) UILabel *BookingTitleLabel;
@property (nonatomic,retain) UITextField *BookingTitleTextField;

@property (nonatomic,retain) NSString *BookingStartDate;
@property (nonatomic,retain) UILabel *BookingStartDateLabel;
@property (nonatomic,retain) UITextField *BookingStartDateTextField;

@property (nonatomic,retain) NSString *BookingEndDate;
@property (nonatomic,retain) UILabel *BookingEndDateLabel;
@property (nonatomic,retain) UITextField *BookingEndDateTextField;

@property (nonatomic,retain) NSString *BookingPlaceOne;
@property (nonatomic,retain) UILabel *BookingPlaceOneLabel;
@property (nonatomic,retain) UITextField *BookingPlaceOneTextField;

@property (nonatomic,retain) NSString *BookingPlaceTwo;
@property (nonatomic,retain) UILabel *BookingPlaceTwoLabel;
@property (nonatomic,retain) UITextField *BookingPlaceTwoTextField;

@property (nonatomic,retain) NSString *BookingDetails;
@property (nonatomic,retain) UILabel *BookingDetailsLabel;
@property (nonatomic,retain) UITextView *BookingDetailsTextView;

@property (nonatomic,retain) UITextField * CTUserName;
@property (nonatomic,retain) UITextField * CTUserEmail;
@property (nonatomic,retain) UITextField * CTMessageTitle;
@property (nonatomic,retain) SDAPlaceholderTextView *CTMDetails;
@property (nonatomic,retain) UIButton * SubmitButton;

@property (nonatomic,retain) UIButton * ApplyButton;
@property (nonatomic,retain) UILabel *HemaAdminContactlabel;
@property (nonatomic,retain) NSMutableArray *ObjectArray;

@property (assign) WebserviceType WebserviceMethod;

@property (assign) ContactSectionDisplay ContactSectionDisplayStatus;

@end

@implementation BookingDetailsViewController

- (id)initWithBookingId:(NSString *)aBookingId WithBookingOption:(BOOL)BookingOption
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        mainFrame                   = [[UIScreen mainScreen] bounds];
        self.view.layer.frame       = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        self.BookingID              = aBookingId;
        self.BookingOption          = BookingOption;
        self.WebserviceMethod       = WebserviceTypeNone;
        [self CallWebserviceForData];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Dashboard"]];
    
    /**
     *  Scrollview Decleration
     */
    
    NextTextFiled               = 50.0f;
    NextlabelFiled              = 20.0f;
    Difference                  = 50.0f;
    nextdatatag                 = 2001;
    TextfieldHeight             = 40;
    TextfieldXposition          = 20;
    SubmitButtonWidth           = 140.0f;
    SubmitButtonHeight          = 40.0f;
    TextfieldWidth              = mainFrame.size.width-40;
    SubmitButtonxposition       = (mainFrame.size.width-SubmitButtonWidth)/2;
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, mainFrame.size.width, mainFrame.size.height-190)];
    [_mainScrollView setBackgroundColor:[UIColor colorFromHex:0xededf2]];
    [_mainScrollView setBounces:YES];
    [_mainScrollView setUserInteractionEnabled:YES];
    [self.view addSubview:_mainScrollView];
    
    /**
     *  Booking Title Section
     */
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 100, mainFrame.size.width-21, 21)];
    [TitleLabel setFont:[UIFont fontWithName:BDFontName size:16.0]];
    [TitleLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [TitleLabel setText:@"Booking"];
    [self.view addSubview:TitleLabel];
    
    UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 111, mainFrame.size.width-170, 1)];
    [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:SeperaterLabel];
    
    _BookingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width-20, 20)];
    [_BookingTitleLabel setText:BookingTitleText];
    [_mainScrollView addSubview:_BookingTitleLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingTitleTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingTitleTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Start Date Section
     */
    
    _BookingStartDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width-20, 20)];
    [_BookingStartDateLabel setText:BookingStartDateText];
    [_mainScrollView addSubview:_BookingStartDateLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingStartDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingStartDateTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingStartDateTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking End Date Section
     */
    
    _BookingEndDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingEndDateLabel setText:BookingEndDateText];
    [_mainScrollView addSubview:_BookingEndDateLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingEndDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingEndDateTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingEndDateTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Location One Section
     */
    
    _BookingPlaceOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingPlaceOneLabel setText:BookingPlaceOneText];
    [_mainScrollView addSubview:_BookingPlaceOneLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingPlaceOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingPlaceOneTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingPlaceOneTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Location Two Section
     */
    
    _BookingPlaceTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingPlaceTwoLabel setText:BookingPlaceTwoText];
    [_mainScrollView addSubview:_BookingPlaceTwoLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingPlaceTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingPlaceTwoTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingPlaceTwoTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Description Section
     */
    
    _BookingDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingDetailsLabel setText:BookingDetailsText];
    [_mainScrollView addSubview:_BookingDetailsLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingDetailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 300)];
    [_BookingDetailsTextView setDelegate:self];
    [_mainScrollView addSubview:_BookingDetailsTextView];
    
    NextTextFiled = NextTextFiled + 270;
    
    _ApplyButton = [[UIButton alloc] initWithFrame:CGRectMake(20 ,NextTextFiled+50, SubmitButtonWidth, SubmitButtonHeight)];
    [_ApplyButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_ApplyButton setTitle:ApplyButtonText forState:UIControlStateNormal];
    [_ApplyButton.titleLabel setFont:[UIFont fontWithName:BDFontName size:12.0f]];
    [_ApplyButton.layer setCornerRadius:3.0f];
    [_ApplyButton addTarget:self action:@selector(ShowContactSection:) forControlEvents:UIControlEventTouchUpInside];
    [_ApplyButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_ApplyButton setTag:104];
    [_mainScrollView addSubview:_ApplyButton];
    
    NextTextFiled = NextTextFiled + 120;
    
    /**
     *  Booking Title Section
     */
    
    self.HemaAdminContactlabel = [[UILabel alloc] initWithFrame:CGRectMake(21, NextTextFiled, mainFrame.size.width-21, 21)];
    [self.HemaAdminContactlabel setFont:[UIFont fontWithName:BDFontName size:14.0]];
    [self.HemaAdminContactlabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [self.HemaAdminContactlabel setText:BDHemaAdminContactText];
    [_mainScrollView addSubview:self.HemaAdminContactlabel];
    
    NextTextFiled = NextTextFiled +40.0f;
    
    self.CTUserName = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, NextTextFiled, TextfieldWidth, TextfieldHeight)];
    [self.CTUserName customizeWithPlaceholderText:CTUserNameText andImageOnRightView:nil andLeftBarText:@"*"];
    [self.CTUserName setTag:nextdatatag];
    [_mainScrollView addSubview:self.CTUserName];
    
    NextTextFiled = NextTextFiled + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.CTUserEmail = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, NextTextFiled, TextfieldWidth, TextfieldHeight)];
    [self.CTUserEmail customizeWithPlaceholderText:CTUserEmailText andImageOnRightView:nil andLeftBarText:@"*"];
    [self.CTUserEmail setTag:nextdatatag];
    [_mainScrollView addSubview:self.CTUserEmail];
    
    NextTextFiled = NextTextFiled + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Password *
    
    self.CTMessageTitle = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, NextTextFiled, TextfieldWidth, TextfieldHeight)];
    [self.CTMessageTitle customizeWithPlaceholderText:CTMessageTitleText andImageOnRightView:nil andLeftBarText:@"*"];
    [self.CTMessageTitle setTag:nextdatatag];
    [_mainScrollView addSubview:self.CTMessageTitle];
    
    NextTextFiled = NextTextFiled + Difference;
    nextdatatag  = nextdatatag +1;
    // Confirm Password *
    
    self.CTMDetails = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, NextTextFiled, TextfieldWidth, 100)];
    [self.CTMDetails setPlaceholder:CTMDetailsText];
    [self.CTMDetails setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.CTMDetails setTag:nextdatatag];
    [_mainScrollView addSubview:self.CTMDetails];
    
    NextTextFiled = NextTextFiled + 70;
    nextdatatag  = nextdatatag +1;
    
    _SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(SubmitButtonxposition ,NextTextFiled+50, SubmitButtonWidth, SubmitButtonHeight)];
    [_SubmitButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_SubmitButton setTitle:SubmitButtonText forState:UIControlStateNormal];
    [_SubmitButton.titleLabel setFont:[UIFont fontWithName:BDFontName size:12.0f]];
    [_SubmitButton.layer setCornerRadius:3.0f];
    [_SubmitButton addTarget:self action:@selector(ContactWithHemaAdmin:) forControlEvents:UIControlEventTouchUpInside];
    [_SubmitButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_SubmitButton setTag:104];
    [_mainScrollView addSubview:_SubmitButton];
    
    NextTextFiled = NextTextFiled + 300;
    
    [_mainScrollView setContentSize:CGSizeMake(mainFrame.size.width, NextTextFiled)];
    
    for (id DataSubView in _mainScrollView.subviews) {
        if ([DataSubView isKindOfClass:[UITextField class]]) {
            UITextField *textField=(UITextField*)DataSubView;
            [textField setDelegate:self];
            [textField setBackgroundColor:[UIColor whiteColor]];
            if (textField.tag == 2001 || textField.tag == 2002 || textField.tag == 2003) {
                [textField setEnabled:YES];
            } else {
                [textField setEnabled:NO];
            }
            [textField.layer setBorderWidth:1.0f];
            [textField.layer setBorderColor:[UIColor colorFromHex:0xc9c8cc].CGColor];
            [textField setTextColor:[UIColor darkGrayColor]];
            [textField setFont:[UIFont fontWithName:BDFontName size:13.0f]];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
            [textField setLeftView:paddingView];
            [textField setLeftViewMode:UITextFieldViewModeAlways];
        }
    }
    
    for (id Globallabel in _mainScrollView.subviews) {
        if ([Globallabel isKindOfClass:[UILabel class]]) {
            [Globallabel setBackgroundColor:[UIColor clearColor]];
            [Globallabel setTextColor:[UIColor colorFromHex:0x5e5e5e]];
            [Globallabel setFont:[UIFont fontWithName:BDFontName size:12.0f]];
            [Globallabel setTextAlignment:NSTextAlignmentLeft];
        }
    }
    
    for (id DataSubView in _mainScrollView.subviews) {
        if ([DataSubView isKindOfClass:[UITextView class]]) {
            UITextView *textField=(UITextView*)DataSubView;
            [textField setDelegate:self];
            [textField setBackgroundColor:[UIColor whiteColor]];
            [textField setEditable:NO];
            if (textField.tag == 2004) {
                [textField setEditable:YES];
            } else {
                [textField setEditable:NO];
            }
            [textField.layer setBorderWidth:1.0f];
            [textField.layer setBorderColor:[UIColor colorFromHex:0xc9c8cc].CGColor];
            [textField setTextColor:[UIColor darkGrayColor]];
            [textField setFont:[UIFont fontWithName:BDFontName size:13.0f]];
        }
    }
    [_mainScrollView setHidden:YES];
}

-(IBAction)ContactWithHemaAdmin:(id)sender
{
    if ([_CTUserName.text CleanTextField].length == 0) {
        [self ShowAlertWithTitle:BDBookingWSErrorTitle Description:BDFVnameblank Tag:121 cancelButtonTitle:BDBookingWSOk];
    } else if([_CTUserEmail.text CleanTextField].length == 0) {
        [self ShowAlertWithTitle:BDBookingWSErrorTitle Description:BDFVemailblank Tag:122 cancelButtonTitle:BDBookingWSOk];
    } else if (![[_CTUserEmail.text CleanTextField] isEmail]) {
        [self ShowAlertWithTitle:BDBookingWSErrorTitle Description:BDFVEmailValied Tag:123 cancelButtonTitle:BDBookingWSOk];
    } else if ([_CTMessageTitle.text CleanTextField].length == 0) {
        [self ShowAlertWithTitle:BDBookingWSErrorTitle Description:BDFVTitleblankn Tag:124 cancelButtonTitle:BDBookingWSOk];
    } else if ([_CTMDetails.text CleanTextField].length == 0) {
        [self ShowAlertWithTitle:BDBookingWSErrorTitle Description:BDFVDescblank Tag:125 cancelButtonTitle:BDBookingWSOk];
    } else {
        NSArray *BookingData = [[NSArray alloc] initWithObjects:[_CTUserName.text CleanTextField],[_CTUserEmail.text CleanTextField],[_CTMessageTitle.text CleanTextField],[_CTMDetails.text CleanTextField],self.BookingID, nil];
        
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:[UrlParameterString WebParamCustomerBookingApply] ValueObject:BookingData UrlParameter:[UrlParameterString URLParamCustomerBookingApply]];
        [Datadelegate setDelegate:self];
    }
}

-(void)ShowAlertWithTitle:(NSString *)ParamTitle Description:(NSString *)ParamDescription Tag:(int)ParamTag cancelButtonTitle:(NSString *)ParamcancelButtonTitle
{
    UIAlertView *ShowAlert = [[UIAlertView alloc] initWithTitle:ParamTitle message:ParamDescription delegate:self cancelButtonTitle:ParamcancelButtonTitle otherButtonTitles:nil, nil];
    [ShowAlert setTag:ParamTag];
    [ShowAlert show];
}

#pragma AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self CleanAllTextFieldValue];
    if (alertView.tag == 12456) {
        [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

-(void)CleanAllTextFieldValue
{
    self.CTUserName.text    = nil;
    self.CTUserEmail.text   = nil;
    self.CTMessageTitle.text= nil;
    self.CTMDetails.text    = nil;
}

-(IBAction)ShowContactSection:(id)sender
{
    if (self.ContactSectionDisplayStatus == ContactSectionDisplaynone) {
        [self ShowHideContactSection:YES];
        self.ContactSectionDisplayStatus = ContactSectionDisplayBlock;
    } else {
        [self ShowHideContactSection:NO];
        self.ContactSectionDisplayStatus = ContactSectionDisplaynone;
    }
}

-(void)ShowHideContactSection:(BOOL)SetHidden
{
    [self CleanAllTextFieldValue];
    
    if (SetHidden) {
        [self.HemaAdminContactlabel setHidden:NO];
        [self.CTUserName setHidden:NO];
        [self.CTUserEmail setHidden:NO];
        [self.CTMessageTitle setHidden:NO];
        [self.CTMDetails setHidden:NO];
        [self.SubmitButton setHidden:NO];
    } else {
        [self.HemaAdminContactlabel setHidden:YES];
        [self.CTUserName setHidden:YES];
        [self.CTUserEmail setHidden:YES];
        [self.CTMessageTitle setHidden:YES];
        [self.CTMDetails setHidden:YES];
        [self.SubmitButton setHidden:YES];
    }
}

-(void)ShowBookingDetails
{
    self.WebserviceMethod               = WebserviceTypeNone;
    BookingListObjects *LocalObject = [self.ObjectArray objectAtIndex:0];
    [_BookingTitleTextField setText:[LocalObject Name]];
    [_BookingStartDateTextField setText:[LocalObject StartDate]];
    [_BookingEndDateTextField setText:[LocalObject EndDate]];
    [_BookingPlaceOneTextField setText:[LocalObject EventLocation]];
    [_BookingPlaceTwoTextField setText:[LocalObject EventPlace]];
    [_BookingDetailsTextView setText:[LocalObject ShortDescription]];
    [_mainScrollView setHidden:NO];
    
    if (self.BookingOption) {
        [UIView animateWithDuration:2.0f animations:^(void){
            [self ShowHideContactSection:YES];
            [_mainScrollView setContentOffset:CGPointMake(0, 930) animated:YES];
        } completion:nil];
        self.ContactSectionDisplayStatus = ContactSectionDisplayBlock;
    } else {
        [self ShowHideContactSection:NO];
        self.ContactSectionDisplayStatus = ContactSectionDisplaynone;
    }
}

#pragma Webservice protocol returned object

-(void)CallWebserviceForData
{
    NSArray *DataArray                  = [[NSArray alloc] initWithObjects:self.BookingID, nil];
    WebserviceProtocol *Datadelegate    = [[WebserviceProtocol alloc] initWithParamObject:[UrlParameterString WebParamCustomerBookingDetails] ValueObject:DataArray UrlParameter:[UrlParameterString URLParamCustomerBookingDetails]];
    self.WebserviceMethod               = WebserviceTypeBookingDetails;
    [Datadelegate setDelegate:self];
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    if ([[ParamObjectCarrier objectForKey:BDBookingWSErrorCode] intValue] == 1) {
        
        @try {
            
            if (self.WebserviceMethod == WebserviceTypeBookingDetails) {
                
                self.ObjectArray = [[NSMutableArray alloc] init];
                
                BookingListObjects *Object = [[BookingListObjects alloc]
                                              initWithBookingListId:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingId]
                                              Category:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingcategory]
                                              Name:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingname]
                                              StartDate:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingstartdate]
                                              EndDate:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingenddate]
                                              EventPlace:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingeventplace]
                                              ShortDescription:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingshortdescription]EventLocation:[[ParamObjectCarrier objectForKey:BDBookingWSSeperater] objectForKey:BDBookingeventLocation]];
                [self.ObjectArray addObject:Object];
                Object = nil;
                [self ShowBookingDetails];
            } else {
                UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:[ParamObjectCarrier objectForKey:@"message"] delegate:self cancelButtonTitle:BDBookingWSOk otherButtonTitles:nil, nil];
                [ErrorAlert setTag:12456];
                [ErrorAlert show];
            }
        }
        @catch (NSException *exception) {
            UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:BDBookingWSErrorTitle message:[NSString stringWithFormat:@"%@",exception] delegate:self cancelButtonTitle:BDBookingWSOk otherButtonTitles:BDBookingWSTryAgain, nil];
            [ErrorAlert show];
        }
   } else {
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:BDBookingWSErrorTitle message:[ParamObjectCarrier objectForKey:BDBookingWSMessage] delegate:self cancelButtonTitle:BDBookingWSOk otherButtonTitles:BDBookingWSTryAgain, nil];
        [ErrorAlert show];
    }
}
-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier
{
    NSLog(@"error");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma UITextfiled Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2001) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_mainScrollView setContentOffset:CGPointMake(0, 950) animated:YES];
        }];
    } else if (textField.tag == 2002) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_mainScrollView setContentOffset:CGPointMake(0, 1000) animated:YES];
        }];
    } else if (textField.tag == 2003) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_mainScrollView setContentOffset:CGPointMake(0, 1050) animated:YES];
        }];
    }
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for(id aSubView in [_mainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1.0f animations:^(void){
        //[_MainScrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }];
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

#pragma UITextview Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:BDNewlineText]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark textview begin editing

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 2004) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_mainScrollView setContentOffset:CGPointMake(0, 1100) animated:YES];
        }];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}


@end
