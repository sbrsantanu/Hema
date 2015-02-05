//
//  PAddQuotation.m
//  Hema
//
//  Created by Mac on 05/02/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PAddQuotation.h"
#import "UIColor+HexColor.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"
#import "GlobalStrings.h"
#import "MPApplicationGlobalConstants.h"
#import "PViewQuotationRequest.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"
#import "NSString+PJR.h"

@interface PAddQuotation ()<UITableViewDataSource,UITableViewDelegate,WebserviceProtocolDelegate>
{
    CGRect mainFrame;
    NSRecursiveLock *Lock;
}

@property (nonatomic,retain) UITableView *DataContainTable;
@property (nonatomic,retain) NSMutableArray *DataContainArray;
@property (nonatomic,retain) UIActivityIndicatorView *DataContainActivity;
@property (nonatomic,retain) NSArray *TableSectionHeaderTextArray;
@property (nonatomic,retain) NSArray *DataStringArray;
@property (nonatomic,retain) NSMutableArray *TableviewDataArray;
@property (nonatomic,retain) UIActivityIndicatorView *MainActivity;

@property (nonatomic,retain) NSString *QuotationId;
@property (nonatomic,retain) NSString *ProviderId;

@property (nonatomic,retain) UITextField *BidAmount, *BidDuration, *QuotationNote;
//@property (nonatomic,retain) UITextView  *QuotationNote;

@property (nonatomic,retain) UIButton * SubmitButton;

@end

@implementation PAddQuotation

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mainFrame = [[UIScreen mainScreen] bounds];
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil QuotationId:(NSString *)ParamQuotationId ProviderId:(NSString *)ParamProviderId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mainFrame = [[UIScreen mainScreen] bounds];
        self.QuotationId = ParamQuotationId;
        self.ProviderId  = ParamProviderId;
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        _DataStringArray =[[NSArray alloc] initWithObjects:self.QuotationId, nil];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [self GetProviderAccountDetails];
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
    [WelcomeMessage setText:@"Add Quotation"];
    [self.view addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, mainFrame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline];
    
    UILabel *WelcomeMessage1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 330, mainFrame.size.width-10, 20)];
    [WelcomeMessage1 setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage1 setTextColor:[UIColor darkGrayColor]];
    [WelcomeMessage1 setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage1 setTextAlignment:NSTextAlignmentLeft];
    [WelcomeMessage1 setText:@"View Quotation Information"];
    [self.view addSubview:WelcomeMessage1];
    
    UILabel *WelcomeUnderline1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 355, mainFrame.size.width-20, 1)];
    [WelcomeUnderline1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline1];
    
    self.DataContainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 370, mainFrame.size.width, mainFrame.size.height-440) style:UITableViewStylePlain];
    [self.DataContainTable setDelegate:self];
    [self.DataContainTable setDataSource:self];
    [self.DataContainTable setHidden:YES];
    [self.DataContainTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.DataContainTable];
    
    _DataContainActivity = [[UIActivityIndicatorView alloc] init];
    [_DataContainActivity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_DataContainActivity setColor:[UIColor colorFromHex:0xe66a4c]];
    [_DataContainActivity startAnimating];
    [_DataContainActivity setHidesWhenStopped:YES];
    
    _TableSectionHeaderTextArray = [[NSArray alloc] initWithObjects:@"Module Name",@"Module Requirement",@"Start Date",@"End Date",@"Maximum Bid Amount",@"Allowed Duration",@"Location", nil];
    
    CGRect frame = _DataContainActivity.frame;
    frame.origin.x = mainFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = mainFrame.size.height / 2 - frame.size.height / 2;
    _DataContainActivity.frame = frame;
    [self.view addSubview:_DataContainActivity];
    
    float StatingYPosition          = 50.0f;
    float Difference                = 50.0f;
    float LastPosition              = 130.0f;
    int nextdatatag                 = 2001;
    float TextfieldWidth            = self.view.frame.size.width-40;
    float TextfieldHeight           = 40;
    float TextfieldXposition        = 20;
    float SubmitButtonWidth         = 140.0f;
    float SubmitButtonHeight        = 40.0f;
    float SubmitButtonxposition     = (mainFrame.size.width-SubmitButtonWidth)/2;
    
    self.BidAmount = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.BidAmount customizeWithPlaceholderText:@"Bid Amount (USD)" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.BidAmount setTag:nextdatatag];
    [self.view addSubview:self.BidAmount];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Mobile *
    
    self.BidDuration = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.BidDuration customizeWithPlaceholderText:@"Duration (Days)" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.BidDuration setTag:nextdatatag];
    [self.view addSubview:self.BidDuration];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Mobile *
    
    self.QuotationNote = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.QuotationNote customizeWithPlaceholderText:@"Note" andImageOnRightView:nil andLeftBarText:@" "];
    [self.QuotationNote setTag:nextdatatag];
    [self.view addSubview:self.QuotationNote];
    
    // Find Now Button
    
    _SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(SubmitButtonxposition ,LastPosition+50, SubmitButtonWidth, SubmitButtonHeight)];
    [_SubmitButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [_SubmitButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_SubmitButton.layer setCornerRadius:3.0f];
    [_SubmitButton addTarget:self action:@selector(ProcessAddQuotation:) forControlEvents:UIControlEventTouchUpInside];
    [_SubmitButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_SubmitButton setTag:104];
    [self.view addSubview:_SubmitButton];
}

#pragma Webservice Process

-(IBAction)ProcessAddQuotation:(id)sender
{
    NSLog(@"ProcessAddQuotation");
    
    BOOL IsValidate = YES;
    
    if ([self.BidAmount.text CleanTextField].length == 0) {
        [self ShowAletviewWIthTitle:@"Sorry" Tag:1234 Message:@"Bid Amount can't be empty"];
        IsValidate = NO;
    } else if ([self.BidDuration.text CleanTextField].length == 0) {
        [self ShowAletviewWIthTitle:@"Sorry" Tag:1235 Message:@"Bid Duration can't be empty"];
        IsValidate = NO;
    } else if (![[self.BidAmount.text CleanTextField] isNumeric]) {
        [self ShowAletviewWIthTitle:@"Sorry" Tag:1235 Message:@"Bid Duration in integer value"];
        IsValidate = NO;
    } else if (![[self.BidDuration.text CleanTextField] isNumeric]) {
        [self ShowAletviewWIthTitle:@"Sorry" Tag:1235 Message:@"Bid Duration in integer value"];
        IsValidate = NO;
    }
    
    if (IsValidate) {
        _DataStringArray =[[NSArray alloc] initWithObjects:self.QuotationId, nil];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [self GetProviderAccountDetails];
        });
    }
}

-(void)GetProviderAccountDetails
{
    if (!IS_NETWORK_AVAILABLE())
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            SHOW_NETWORK_ERROR_ALERT();
        });
    } else {
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:UrlParameterString.WebParamProviderQuotationDetail ValueObject:_DataStringArray UrlParameter:UrlParameterString.URLParamProviderQuotationDetail];
        [Datadelegate setDelegate:self];
    }
}

/**
 *  Success
 */

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    if ([[ParamObjectCarrier objectForKey:@"errorcode"]intValue] == 1) {
        
        self.TableviewDataArray = [[NSMutableArray alloc] init];
        
        NSLock* arrayLock = [[NSLock alloc] init];
        [arrayLock lock];
        
        for (id ObjectInstance in [ParamObjectCarrier objectForKey:@"quotation"]) {
            
            ProviderQuotationDetails *LocalObject = [[ProviderQuotationDetails alloc] initWithQDetailsId:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"id"] QDetailsModuleName:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"module_name"] QDetailsModuleDetails:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"module_detail"] QDetailsStartDate:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"start_date"] QDetailsEndDate:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"end_date"] QDetailsBudget:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"budget"] QDetailsCurrency:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"currency"] QDetailsDuration:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"duration"] QDetailsLocation:[[ParamObjectCarrier objectForKey:@"quotation"] objectForKey:@"location"]];
            
            [self.TableviewDataArray addObject:LocalObject];
            
            NSLog(@"ObjectInstance -- %@",ObjectInstance);
            
        }
        [arrayLock unlock];
        NSLog(@"self.TableviewDataArray ---- %@",self.TableviewDataArray);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [_DataContainActivity stopAnimating];
            [_DataContainTable setHidden:NO];
            [_DataContainTable reloadData];
        });
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            UIAlertView *dataAccessError = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[ParamObjectCarrier objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [dataAccessError setTag:120];
            [dataAccessError show];
        });
    }
}

/**
 *  Error
 */

-(void)RetunWebserviceDataWithError:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSError *)ParamObjectCarrier
{
    NSLog(@"Error ParamObjectCarrier ---- %@",ParamObjectCarrier);
}

#pragma Tableview Datasorce Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *DataCell = [[UITableViewCell alloc] init];
    ProviderQuotationDetails *LocalObject = [self.TableviewDataArray objectAtIndex:indexPath.section];
    [DataCell.textLabel setNumberOfLines:0];
    switch (indexPath.section) {
        case 0:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@",[LocalObject QDetailsModuleName]]];
            break;
        case 1:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@",[LocalObject QDetailsModuleDetails]]];
            break;
        case 2:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@",[LocalObject QDetailsStartDate]]];
            break;
        case 3:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@",[LocalObject QDetailsEndDate]]];
            break;
        case 4:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@ %@",[LocalObject QDetailsBudget],[LocalObject QDetailsCurrency]]];
            break;
        case 5:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@ Day(s)",[LocalObject QDetailsDuration]]];
            break;
        case 6:
            [DataCell.textLabel setText:[NSString stringWithFormat:@"%@ Day(s)",[LocalObject QDetailsLocation]]];
            break;
    }
    
    [DataCell.textLabel setTextColor:[UIColor darkGrayColor]];
    [DataCell.textLabel sizeToFit];
    [DataCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    return DataCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_TableSectionHeaderTextArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma Tableview Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 1)?150.0f:50.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *Headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, 30)];
    [Headerview setBackgroundColor:[UIColor colorFromHex:0xefefef]];
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7.5, Headerview.frame.size.width, 15)];
    [TitleLabel setBackgroundColor:[UIColor clearColor]];
    [TitleLabel setTextColor:[UIColor darkGrayColor]];
    [TitleLabel setText:[_TableSectionHeaderTextArray objectAtIndex:section]];
    [TitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [Headerview addSubview:TitleLabel];
    return Headerview;
}

/**
 *  Tableview select row
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)ShowAletviewWIthTitle:(NSString *)ParamTitle Tag:(int)ParamTag Message:(NSString *)ParamMessage
{
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:ParamTitle message:ParamMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [AlertView setTag:ParamTag];
    [AlertView show];
    
}

@end
