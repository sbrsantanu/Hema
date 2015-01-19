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

#pragma Booking Webservice param

#define BDBookingWSSeperater       @"bookings"
#define BDBookingWSMessage         @"message"
#define BDBookingWSErrorCode       @"errorcode"
#define BDBookingId                @"id"
#define BDBookingcategory          @"category"
#define BDBookingenddate           @"end_date"
#define BDBookingeventplace        @"event_place"
#define BDBookingname              @"name"
#define BDBookingshortdescription  @"short_description"
#define BDBookingstartdate         @"start_date"
#define BDBookingeventLocation     @"event_location"
#define BDBookingWSErrorTitle      @"Sorry"
#define BDBookingWSErrorDesc       @"Uanble To get data"
#define BDBookingWSTryAgain        @"Try Again"
#define BDBookingWScancel          @"Cancel"
#define BDBookingWSOk              @"Ok"

@interface BookingDetailsViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,WebserviceProtocolDelegate,UIAlertViewDelegate>
{
    CGRect mainFrame;
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
@end

@implementation BookingDetailsViewController

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
    [self.view addSubview:[self UIViewSetHeaderAfterLoginNavigationViewWithSelectedTab:@"Dashboard"]];
    
    /**
     *  Scrollview Decleration
     */
    
    float NextTextFiled = 50.0f;
    float NextlabelFiled = 20.0f;
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, mainFrame.size.width, mainFrame.size.height-210)];
    [_mainScrollView setBackgroundColor:[UIColor colorFromHex:0xededf2]];
    [_mainScrollView setBounces:NO];
    [_mainScrollView setUserInteractionEnabled:YES];
    [self.view addSubview:_mainScrollView];
    
    /**
     *  Booking Title Section
     */
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 100, mainFrame.size.width-21, 21)];
    [TitleLabel setFont:[UIFont fontWithName:@"Arial-Bold" size:14.0]];
    [TitleLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [TitleLabel setText:@"Booking"];
    [self.view addSubview:TitleLabel];
    
    UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 111, mainFrame.size.width-170, 1)];
    [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:SeperaterLabel];
    
    _BookingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width-20, 20)];
    [_BookingTitleLabel setText:@"Title"];
    [_mainScrollView addSubview:_BookingTitleLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingTitleTextField setTag:52145];
    [_BookingTitleTextField setText:@"HeaderNavigationViewBackgroundView"];
    [_BookingTitleTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingTitleTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Start Date Section
     */
    
    _BookingStartDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width-20, 20)];
    [_BookingStartDateLabel setText:@"Start Date"];
    [_mainScrollView addSubview:_BookingStartDateLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingStartDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingStartDateTextField setTag:52145];
    [_BookingStartDateTextField setText:@"10/12/2014"];
    [_BookingStartDateTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingStartDateTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking End Date Section
     */
    
    _BookingEndDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingEndDateLabel setText:@"End Date"];
    [_mainScrollView addSubview:_BookingEndDateLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingEndDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingEndDateTextField setTag:52145];
    [_BookingEndDateTextField setText:@"10/12/2015"];
    [_BookingEndDateTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingEndDateTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Location One Section
     */
    
    _BookingPlaceOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingPlaceOneLabel setText:@"Location One"];
    [_mainScrollView addSubview:_BookingPlaceOneLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingPlaceOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingPlaceOneTextField setTag:52145];
    [_BookingPlaceOneTextField setText:@"Kolkata"];
    [_BookingPlaceOneTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingPlaceOneTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Location Two Section
     */
    
    _BookingPlaceTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingPlaceTwoLabel setText:@"Location Two"];
    [_mainScrollView addSubview:_BookingPlaceTwoLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingPlaceTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 40)];
    [_BookingPlaceTwoTextField setTag:52145];
    [_BookingPlaceTwoTextField setText:@"India"];
    [_BookingPlaceTwoTextField setDelegate:self];
    [_mainScrollView addSubview:_BookingPlaceTwoTextField];
    
    NextTextFiled = NextTextFiled + 100;
    
    /**
     *  Booking Description Section
     */
    
    _BookingDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NextlabelFiled, mainFrame.size.width, 20)];
    [_BookingDetailsLabel setText:@"Description"];
    [_mainScrollView addSubview:_BookingDetailsLabel];
    
    NextlabelFiled = NextlabelFiled + 100;
    
    _BookingDetailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(-1, NextTextFiled, mainFrame.size.width+2, 300)];
    [_BookingDetailsTextView setTag:52145];
    [_BookingDetailsTextView setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia erat in arcu viverra venenatis sed sit amet ex. Donec posuere leo urna, ac laoreet urna fermentum a. Nulla nunc mi, hendrerit nec scelerisque vel, auctor et odio. Proin purus velit, semper eget quam ac, lacinia viverra est. Morbi id elit sit amet enim mollis mattis nec ac massa. Sed vitae lectus massa. Duis odio quam, luctus at justo eu, consequat faucibus magna. Sed laoreet maximus velit. Morbi ut metus sit amet risus malesuada dignissim nec pretium sapien. Sed tristique neque tortor, in aliquam lacus volutpat volutpat. "];
    [_BookingDetailsTextView setDelegate:self];
    [_mainScrollView addSubview:_BookingDetailsTextView];
    
    NextTextFiled = NextTextFiled + 300;
    
    [_mainScrollView setContentSize:CGSizeMake(300, NextTextFiled)];
    
    for (id DataSubView in _mainScrollView.subviews) {
        if ([DataSubView isKindOfClass:[UITextField class]]) {
            UITextField *textField=(UITextField*)DataSubView;
            [textField setDelegate:self];
            [textField setBackgroundColor:[UIColor whiteColor]];
            [textField setEnabled:NO];
            [textField.layer setBorderWidth:1.0f];
            [textField.layer setBorderColor:[UIColor colorFromHex:0xc9c8cc].CGColor];
            [textField setTextColor:[UIColor darkGrayColor]];
            [textField setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
            [textField setDelegate:self];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
            [textField setLeftView:paddingView];
            [textField setLeftViewMode:UITextFieldViewModeAlways];
        }
    }
    
    for (id Globallabel in _mainScrollView.subviews) {
        if ([Globallabel isKindOfClass:[UILabel class]]) {
            [Globallabel setBackgroundColor:[UIColor clearColor]];
            [Globallabel setTextColor:[UIColor colorFromHex:0x5e5e5e]];
            [Globallabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
            [Globallabel setTextAlignment:NSTextAlignmentLeft];
        }
    }
    
    for (id DataSubView in _mainScrollView.subviews) {
        if ([DataSubView isKindOfClass:[UITextView class]]) {
            UITextView *textField=(UITextView*)DataSubView;
            [textField setDelegate:self];
            [textField setBackgroundColor:[UIColor whiteColor]];
            [textField setEditable:NO];
            [textField.layer setBorderWidth:1.0f];
            [textField.layer setBorderColor:[UIColor colorFromHex:0xc9c8cc].CGColor];
            [textField setTextColor:[UIColor darkGrayColor]];
            [textField setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
            [textField setDelegate:self];
        }
    }
}

#pragma Webservice protocol returned object

-(void)CallWebserviceForData
{
    NSArray *DataArray = [[NSArray alloc] initWithObjects:self.BookingID, nil];
    WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:[UrlParameterString WebParamCustomerBookingDetails] ValueObject:DataArray UrlParameter:[UrlParameterString URLParamCustomerBookingDetails]];
    [Datadelegate setDelegate:self];
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    if ([[ParamObjectCarrier objectForKey:BDBookingWSErrorCode] intValue] == 1) {
        
        @try {
            
            for (id DataDicrtionary in [ParamObjectCarrier objectForKey:BDBookingWSSeperater]) {
                
                BookingListObjects *Object = [[BookingListObjects alloc]
                                              initWithBookingListId:[DataDicrtionary objectForKey:BDBookingId]
                                              Category:[DataDicrtionary objectForKey:BDBookingcategory]
                                              Name:[DataDicrtionary objectForKey:BDBookingname]
                                              StartDate:[DataDicrtionary objectForKey:BDBookingstartdate]
                                              EndDate:[DataDicrtionary objectForKey:BDBookingenddate]
                                              EventPlace:[DataDicrtionary objectForKey:BDBookingeventplace]
                                              ShortDescription:[DataDicrtionary objectForKey:BDBookingshortdescription] EventLocation:BDBookingeventLocation];
                Object = nil;
            }
        }
        @catch (NSException *exception) {
            
        }
    } else {
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:BDBookingWSErrorTitle message:[ParamObjectCarrier objectForKey:BDBookingWSMessage] delegate:self cancelButtonTitle:BDBookingWSOk otherButtonTitles:BDBookingWSTryAgain, nil];
        [ErrorAlert show];
    }
}
-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier
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
