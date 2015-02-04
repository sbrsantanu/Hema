//
//  BookingListViewController.m
//  Hema
//
//  Created by Mac on 29/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "BookingListViewController.h"
#import "UITextField+Attribute.h"
#import "UIColor+HexColor.h"
#import "AppDelegate.h"
#import "BookingDetailsViewController.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"
#import "MPApplicationGlobalConstants.h"

#pragma Booking Webservice param

#define BLBookingWSSeperater       @"bookings"
#define BLBookingWSMessage         @"message"
#define BLBookingWSErrorCode       @"errorcode"
#define BLBookingId                @"id"
#define BLBookingcategory          @"category"
#define BLBookingenddate           @"end_date"
#define BLBookingeventplace        @"event_place"
#define BLBookingname              @"name"
#define BLBookingshortdescription  @"short_description"
#define BLBookingstartdate         @"start_date"
#define BLBookingWSErrorTitle      @"Sorry"
#define BLBookingWSErrorDesc       @"Uanble To get data"
#define BLBookingWSTryAgain        @"Try Again"
#define BLBookingWScancel          @"Cancel"
#define BLBookingWSOk              @"Ok"

#pragma Define BookingType

#define BookingTypeconference      @"conference"
#define BookingTypeevent           @"event"
#define BookingTypedestination     @"destination"

@interface BookingListViewController ()<UITableViewDataSource,UITableViewDelegate,WebserviceProtocolDelegate,UIAlertViewDelegate>{
    CGRect mainFrame;
    NSArray *SearchparamObject;
}

@property (nonatomic,retain) UITableView *BookingTable;
@property (nonatomic,retain) NSMutableArray *BookingDataArray;
@property (assign) SelectedBookingType BookingType;
@end

@implementation BookingListViewController

int BookingListWebAlertTag = 9658;

/**

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
 */

-(id)initWithBookingCategory:(SelectedBookingType)ParamBookingCategory CityorHotelname:(NSString *)ParamCityorHotelname StartDate:(NSString *)ParamStartDate EndDate:(NSString *)ParamEndDate
{
    self = [super init];
    if(self)
    {
        mainFrame = [[UIScreen mainScreen] bounds];
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.BookingType = ParamBookingCategory;
        
        NSString *BookingType = nil;
        if(ParamBookingCategory == SelectedBookingTypeConference)
            BookingType = BookingTypeconference;
        else if(ParamBookingCategory == SelectedBookingTypeEvent)
            BookingType = BookingTypeevent;
        else if(ParamBookingCategory == SelectedBookingTypeDestination)
            BookingType = BookingTypedestination;
        
        SearchparamObject = [[NSArray alloc] initWithObjects:BookingType,ParamCityorHotelname,ParamEndDate,ParamStartDate, nil];
        [self CallWebserviceForData];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Dashboard"]];
    
    UILabel *TitleLabel = (UILabel *)[self.view viewWithTag:11];
    [TitleLabel setFont:[UIFont fontWithName:@"Arial-Bold" size:14.0]];
    [TitleLabel setText:@"Booking"];
    [TitleLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    
    /**
     *  TableView Decleration
     */
    
    _BookingTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 120, mainFrame.size.width-20, mainFrame.size.height-180)];
    [_BookingTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_BookingTable];
    [_BookingTable setDataSource:self];
    [_BookingTable setSeparatorColor:[UIColor clearColor]];
    [_BookingTable setDelegate:self];
    [_BookingTable setBounces:YES];
    [_BookingTable setHidden:YES];
    
}

#pragma Webservice protocol returned object

-(void)CallWebserviceForData
{
    WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:[UrlParameterString WebParamCustomerBookingSearch] ValueObject:SearchparamObject UrlParameter:[UrlParameterString URLParamCustomerBookingSearch]];
    [Datadelegate setDelegate:self];
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    self.BookingDataArray = [[NSMutableArray alloc] init];
    
    if ([[ParamObjectCarrier objectForKey:BLBookingWSErrorCode] intValue] == 1) {
        
        @try {
            
            for (id DataDicrtionary in [ParamObjectCarrier objectForKey:BLBookingWSSeperater]) {
                
                BookingListObjects *LocalObject = [[BookingListObjects alloc]
                                              initWithBookingListId:[DataDicrtionary objectForKey:BLBookingId]
                                              Category:[DataDicrtionary objectForKey:BLBookingcategory]
                                              Name:[DataDicrtionary objectForKey:BLBookingname]
                                              StartDate:[DataDicrtionary objectForKey:BLBookingstartdate]
                                              EndDate:[DataDicrtionary objectForKey:BLBookingenddate]
                                              EventPlace:[DataDicrtionary objectForKey:BLBookingeventplace]
                                              ShortDescription:[DataDicrtionary objectForKey:BLBookingshortdescription]];
                [self.BookingDataArray addObject:LocalObject];
                LocalObject = nil;
            }
            [_BookingTable setHidden:NO];
            [_BookingTable reloadData];
        }
        @catch (NSException *exception) {
            [self ShowAlert];
        }
    } else {
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:BLBookingWSErrorTitle message:[ParamObjectCarrier objectForKey:BLBookingWSMessage] delegate:self cancelButtonTitle:BLBookingWSOk otherButtonTitles:BLBookingWSTryAgain, nil];
        [ErrorAlert setTag:BookingListWebAlertTag];
        [ErrorAlert show];
    }
}
-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier
{
    [self ShowAlert];
}

#pragma Booking Error Alert

-(void)ShowAlert
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:BLBookingWSErrorTitle message:BLBookingWSErrorDesc     delegate:self cancelButtonTitle:BLBookingWSOk otherButtonTitles:BLBookingWSTryAgain, nil];
    [ErrorAlert setTag:BookingListWebAlertTag];
    [ErrorAlert show];
}

#pragma AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == BookingListWebAlertTag) {
        if (buttonIndex == 1) {
            [self Goback:nil];
        }
    }
}

#pragma tableview datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *mainTableCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width-20, 100)];
    
    BookingListObjects *LocalObject = [self.BookingDataArray objectAtIndex:indexPath.row];
    
    UIView *DataContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width-20, 145)];
    [DataContainerView.layer setBorderWidth:1.0f];
    [DataContainerView.layer setBorderColor:[UIColor colorFromHex:0xf0f0f0].CGColor];
    [DataContainerView setBackgroundColor:[UIColor clearColor]];
    [mainTableCell addSubview:DataContainerView];
    
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, mainFrame.size.width-30, 15)];
    [Titlelabel setBackgroundColor:[UIColor clearColor]];
    [Titlelabel setFont:[UIFont fontWithName:@"Arial" size:14.0f]];
    [Titlelabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [Titlelabel setText:[LocalObject ShortDescription]];
    [DataContainerView addSubview:Titlelabel];
    
    UILabel *StartDatelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, mainFrame.size.width-30, 15)];
    [StartDatelabel setBackgroundColor:[UIColor clearColor]];
    [StartDatelabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [StartDatelabel setTextColor:[UIColor darkTextColor]];
    [StartDatelabel setText:[NSString stringWithFormat:@"Start Date : %@",[LocalObject StartDate]]];
    [DataContainerView addSubview:StartDatelabel];
    
    UILabel *EndDatelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, mainFrame.size.width-30, 15)];
    [EndDatelabel setBackgroundColor:[UIColor clearColor]];
    [EndDatelabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [EndDatelabel setTextColor:[UIColor darkTextColor]];
    [EndDatelabel setText:[NSString stringWithFormat:@"End Date : %@",[LocalObject EndDate]]];
    [DataContainerView addSubview:EndDatelabel];
    
    UILabel *Placelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 55, mainFrame.size.width-30, 15)];
    [Placelabel setBackgroundColor:[UIColor clearColor]];
    [Placelabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [Placelabel setTextColor:[UIColor darkTextColor]];
    [Placelabel setText:[NSString stringWithFormat:@"Place : %@",[LocalObject EventPlace]]];
    [DataContainerView addSubview:Placelabel];
    
    UILabel *Desclabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 70, mainFrame.size.width-30, 25)];
    [Desclabel setBackgroundColor:[UIColor clearColor]];
    [Desclabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [Desclabel setTextColor:[UIColor darkTextColor]];
    [Desclabel setNumberOfLines:0];
    [Desclabel setText:[LocalObject ShortDescription]];
    [DataContainerView addSubview:Desclabel];
    
    UIView *FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, mainFrame.size.width-20, 44)];
    [FooterView setBackgroundColor:[UIColor colorFromHex:0xf0f0f0]];
    [mainTableCell addSubview:FooterView];
    
    UIButton *ReadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 35)];
    [ReadMoreButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [ReadMoreButton setTitle:@"Read More" forState:UIControlStateNormal];
    [ReadMoreButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [ReadMoreButton.layer setCornerRadius:2.0f];
    [ReadMoreButton addTarget:self action:@selector(Readmorebookings:) forControlEvents:UIControlEventTouchUpInside];
    [ReadMoreButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [ReadMoreButton setTag:(indexPath.row+220)];
    [FooterView addSubview:ReadMoreButton];
    
    UIButton *ApplyButton = [[UIButton alloc] initWithFrame:CGRectMake(115, 5, 100, 35)];
    [ApplyButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [ApplyButton setTitle:@"Apply" forState:UIControlStateNormal];
    [ApplyButton addTarget:self action:@selector(Applybookings:) forControlEvents:UIControlEventTouchUpInside];
    [ApplyButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [ApplyButton.layer setCornerRadius:2.0f];
    [ApplyButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [ApplyButton setTag:(indexPath.row+440)];
    [FooterView addSubview:ApplyButton];
    
    return mainTableCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.BookingDataArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma tableview delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *DataContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [DataContainerView setBackgroundColor:[UIColor colorFromHex:0xc5c5c5]];
    
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, DataContainerView.layer.frame.size.width, DataContainerView.layer.frame.size.height)];
    [Titlelabel setBackgroundColor:[UIColor clearColor]];
    [Titlelabel setTextColor:[UIColor whiteColor]];
    [Titlelabel setFont:[UIFont fontWithName:@"Arial-Bold" size:14.0]];
    [Titlelabel setTextAlignment:NSTextAlignmentLeft];
    
    if (_BookingType == SelectedBookingTypeNone) {
        [Titlelabel setText:@"NA"];
    } else if (_BookingType == SelectedBookingTypeConference) {
        [Titlelabel setText:@"Conference Booking"];
    } else if(_BookingType == SelectedBookingTypeEvent) {
        [Titlelabel setText:@"Event Booking"];
    } else if (_BookingType == SelectedBookingTypeDestination) {
        [Titlelabel setText:@"Destination Planning"];
    }
    [DataContainerView addSubview:Titlelabel];
    return DataContainerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BookingListObjects *LocalObject = [self.BookingDataArray objectAtIndex:indexPath.row];
    BookingDetailsViewController *BookingDetails = [[BookingDetailsViewController alloc] initWithBookingId:[LocalObject BookingListId] WithBookingOption:NO];
    [self GotoDifferentViewWithAnimation:BookingDetails];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)Readmorebookings:(UIButton *)sender
{
    BookingListObjects *LocalObject = [self.BookingDataArray objectAtIndex:(sender.tag - 220)];
    BookingDetailsViewController *BookingDetails = [[BookingDetailsViewController alloc] initWithBookingId:[LocalObject BookingListId] WithBookingOption:NO];
    [self GotoDifferentViewWithAnimation:BookingDetails];
}
-(IBAction)Applybookings:(UIButton *)sender
{
    BookingListObjects *LocalObject = [self.BookingDataArray objectAtIndex:(sender.tag - 440)];
    BookingDetailsViewController *BookingDetails = [[BookingDetailsViewController alloc] initWithBookingId:[LocalObject BookingListId] WithBookingOption:YES];
    [self GotoDifferentViewWithAnimation:BookingDetails];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated
{
   // self.BookingTable = nil;
   // self.BookingDataArray = nil;
   // self.BookingType = SelectedBookingTypeNone;
}

#pragma Overwrite the Goback method

-(IBAction)Goback:(id)sender
{
    HomeViewController *HomeView = [[HomeViewController alloc] init];
    [self GotoDifferentViewWithAnimation:HomeView];
}
@end
