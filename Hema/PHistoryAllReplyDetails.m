//
//  PHistoryAllReplyDetails.m
//  Hema
//
//  Created by Mac on 05/02/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PHistoryAllReplyDetails.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalStrings.h"
#import "MPApplicationGlobalConstants.h"

@interface PHistoryAllReplyDetails()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,WebserviceProtocolDelegate>
{
    CGRect mainFrame;
}
@property (nonatomic,retain) UIScrollView * MainScrollView;
@property (nonatomic,retain) UIScrollView * DetailsScrollView;
@property (nonatomic,retain) UITableView  * DataContainerView;
@property (nonatomic,retain) UIActivityIndicatorView *DataContainActivity;
@property (nonatomic,retain) NSArray *HeaderContainerArray;
@property (nonatomic,retain) NSArray *DataStringArray;
@property (nonatomic,retain) NSMutableArray *TableDataArray;
@property (nonatomic,retain) NSMutableArray *CategoryArray;

@property (weak) ProverHistoryOfConversion *DataConversionDetails;
@property (nonatomic,retain) NSString *ProviderName;

@property (nonatomic,retain) UILabel *ConversionTitlelabel;
@property (nonatomic,retain) UITextField *ConversionTitleTextField;

@property (nonatomic,retain) UILabel *ConversionDetailsLabel;
@property (nonatomic,retain) UITextView *ConversionDetailsTextField;

@property (nonatomic,retain) UILabel *ProviderNamelabel;
@property (nonatomic,retain) UITextField *ProviderNameTextField;

@property (nonatomic,retain) UILabel *ConvirsionDatelabel;
@property (nonatomic,retain) UITextField *ConvirsionDateTextField;
@end

@implementation PHistoryAllReplyDetails

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ConversionDetails:(ProverHistoryOfConversion *)ParamConversionDetails Providername:(NSString *)ParamProviderName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mainFrame = [[UIScreen mainScreen] bounds];
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.DataConversionDetails = ParamConversionDetails;
        self.ProviderName          = ParamProviderName;
        
        _DataStringArray =[[NSArray alloc] initWithObjects:@"3", nil];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
           // [self GetProviderServiceListDetails];
        });
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Dashboard"]];
    
    UILabel *WelcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, mainFrame.size.width-10, 20)];
    [WelcomeMessage setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage setTextColor:[UIColor darkGrayColor]];
    [WelcomeMessage setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage setTextAlignment:NSTextAlignmentLeft];
    [WelcomeMessage setText:@"History Of Conversion"];
    [self.view addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, mainFrame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline];
    
    mainFrame = [[UIScreen mainScreen] bounds];
    
    UILabel *WelcomeMessage1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, mainFrame.size.width-10, 20)];
    [WelcomeMessage1 setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage1 setTextColor:[UIColor darkGrayColor]];
    [WelcomeMessage1 setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage1 setTextAlignment:NSTextAlignmentLeft];
    [WelcomeMessage1 setText:@"All Reply"];
    [self.view addSubview:WelcomeMessage1];
    
    UILabel *WelcomeUnderline1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 293, mainFrame.size.width-20, 1)];
    [WelcomeUnderline1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline1];
    
    _DetailsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, mainFrame.size.width, 150)];
    [_DetailsScrollView setUserInteractionEnabled:YES];
    [_DetailsScrollView setContentSize:CGSizeMake(mainFrame.size.width, 2000)];
    [_DetailsScrollView setDelegate:self];
    [_DetailsScrollView setBounces:YES];
    [_DetailsScrollView setBackgroundColor:[UIColor colorFromHex:0xededf2]];
    [self.view addSubview:_DetailsScrollView];
    
    //_DataStringArray =[[NSArray alloc] initWithObjects:[self Getlogedinuserid], nil];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, mainFrame.size.width, mainFrame.size.height-(215+150))];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setContentSize:CGSizeMake(mainFrame.size.width, 2000)];
    [_MainScrollView setDelegate:self];
    [_MainScrollView setBounces:YES];
    [_MainScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_MainScrollView];
   
    CGRect frame = _DataContainActivity.frame;
    frame.origin.x = _MainScrollView.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = 100;
    _DataContainActivity.frame = frame;
    [_DataContainActivity startAnimating];
    [_DataContainActivity setHidesWhenStopped:YES];
    [_DataContainActivity setColor:[UIColor colorFromHex:0xededf2]];
    [_MainScrollView addSubview:_DataContainActivity];
    
    /**
     *  =======================================================
     *  =======================================================
     */
    
    self.ConversionTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, mainFrame.size.width, 20)];
    [self.ConversionTitlelabel setText:@"Title"];
    [_DetailsScrollView addSubview:self.ConversionTitlelabel];
    
    self.ConversionTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, 40, mainFrame.size.width+2, 40)];
    [self.ConversionTitleTextField setText:[self.DataConversionDetails ConversionMessageTitle]];
    [_DetailsScrollView addSubview:self.ConversionTitleTextField];
    
    /**
     *  =======================================================
     *  =======================================================
     */
    
    self.ConversionDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 110, mainFrame.size.width, 20)];
    [self.ConversionDetailsLabel setText:@"Details"];
    [_DetailsScrollView addSubview:self.ConversionDetailsLabel];
    
    self.ConversionDetailsTextField = [[UITextView alloc] initWithFrame:CGRectMake(-1, 140, mainFrame.size.width+2, 40)];
    [self.ConversionDetailsTextField setText:[self.DataConversionDetails ConversionMessageDetails]];
    [_DetailsScrollView addSubview:self.ConversionDetailsTextField];
    
    /**
     *  =======================================================
     *  =======================================================
     */
    
    self.ProviderNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 210, mainFrame.size.width, 20)];
    [self.ProviderNamelabel setText:@"Name"];
    [_DetailsScrollView addSubview:self.ProviderNamelabel];
    
    self.ProviderNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, 240, mainFrame.size.width+2, 40)];
    [self.ProviderNameTextField setText:[self Getlogedinusername]];
    [_DetailsScrollView addSubview:self.ProviderNameTextField];
    
    /**
     *  =======================================================
     *  =======================================================
     */
    
    self.ConvirsionDatelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 310, mainFrame.size.width, 20)];
    [self.ConvirsionDatelabel setText:@"Date"];
    [_DetailsScrollView addSubview:self.ConvirsionDatelabel];
    
    self.ConvirsionDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(-1, 340, mainFrame.size.width+2, 40)];
    [self.ConvirsionDateTextField setText:[self.DataConversionDetails ConversionMessageTime]];
    [_DetailsScrollView addSubview:self.ConvirsionDateTextField];
}

#pragma webservice data delegate

-(void)GetProviderServiceListDetails
{
    if (!IS_NETWORK_AVAILABLE())
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            SHOW_NETWORK_ERROR_ALERT();
        });
    } else {
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:UrlParameterString.WebParamProviderMyIssues ValueObject:self.DataStringArray UrlParameter:UrlParameterString.URLParamProviderMyIssues];
        [Datadelegate setDelegate:self];
    }
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        if ([[ParamObjectCarrier objectForKey:@"errorcode"] intValue] == 1) {
            
            self.TableDataArray = [[NSMutableArray alloc] init];
            for (id WEbdetailsData in [ParamObjectCarrier objectForKey:@"my-awarded-quotations"]) {
                
                ProviderIssueList *LocalObject = [[ProviderIssueList alloc] initWithIssueListId:[WEbdetailsData objectForKey:@"id"] IssueListModuleId:[WEbdetailsData objectForKey:@"module_id"] IssueListModuleName:[WEbdetailsData objectForKey:@"module_name"] IssueListBidAmount:[WEbdetailsData objectForKey:@"bid_amount"] IssueListStartDate:[WEbdetailsData objectForKey:@"start_date"] IssueListEndDate:[WEbdetailsData objectForKey:@"end_date"] IssueListDuration:[WEbdetailsData objectForKey:@"duration"] IssueListNote:[WEbdetailsData objectForKey:@"note"] IssueListIsBlocked:[WEbdetailsData objectForKey:@"is_blocked"] IssueListIsAwarded:[WEbdetailsData objectForKey:@"is_awarded"] IssueListIsDeclined:[WEbdetailsData objectForKey:@"is_declined"] IssueListIsRevision:[WEbdetailsData objectForKey:@"is_revision"] IssueListQuotationTime:[WEbdetailsData objectForKey:@"quotation_time"] IssueListBookingNumber:[WEbdetailsData objectForKey:@"booking_no"] IssueListIsPaid:[WEbdetailsData objectForKey:@"is_paid"]];
                
                [self.TableDataArray addObject:LocalObject];
            }
            [_DataContainActivity stopAnimating];
            [_DataContainerView setHidden:NO];
            [_DataContainerView reloadData];
            
        } else if ([[ParamObjectCarrier objectForKey:@"errorcode"] intValue] == 2) {
            
            UIAlertView *DataAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[ParamObjectCarrier objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [DataAlert setTag:120];
            [DataAlert show];
            
        } else {
            NSLog(@"------------param code arror %@",ParamObjectCarrier);
        }
    });
}
-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier
{
    NSLog(@"Error data --- %@",ParamObjectCarrier);
}

-(IBAction)ViewDetails:(id)sender
{
    
}
@end
