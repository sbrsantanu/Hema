//
//  PMyQuotations.m
//  Hema
//
//  Created by Mac on 13/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PMyQuotations.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"
#import "GlobalStrings.h"
#import "MPApplicationGlobalConstants.h"

@interface PMyQuotations ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,WebserviceProtocolDelegate>
{
    CGRect mainFrame;
}

@property (nonatomic,retain) UIScrollView * MainScrollView;
@property (nonatomic,retain) UITableView  * DataContainerView;
@property (nonatomic,retain) UIActivityIndicatorView *DataContainActivity;
@property (nonatomic,retain) NSArray *HeaderContainerArray;
@property (nonatomic,retain) NSArray *DataStringArray;
@property (nonatomic,retain) NSMutableArray *TableDataArray;
@property (nonatomic,retain) NSMutableArray *CategoryArray;
@end

@implementation PMyQuotations

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
    [WelcomeMessage setText:@"My Quotations"];
    [self.view addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, mainFrame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline];
    
    _HeaderContainerArray = [[NSArray alloc] initWithObjects:@"Module Name",@"Quotation Bid Amount",@"Duration",@"Quotation Status",@"Quotation State",@"Booking Number",@"Action", nil];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-181)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setContentSize:CGSizeMake(150*[_HeaderContainerArray count]+190, self.view.frame.size.height-181)];
    [_MainScrollView setDelegate:self];
    [_MainScrollView setBounces:NO];
    [self.view addSubview:_MainScrollView];
    
    _DataContainerView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [_HeaderContainerArray count]*150+190, _MainScrollView.layer.frame.size.height) style:UITableViewStylePlain];
    [_DataContainerView setDelegate:self];
    [_DataContainerView setDataSource:self];
    [_DataContainerView setBounces:NO];
    [_DataContainerView setHidden:YES];
    [_DataContainerView setBackgroundColor:[UIColor clearColor]];
    [_MainScrollView addSubview:_DataContainerView];
    
    CGRect frame = _DataContainActivity.frame;
    frame.origin.x = mainFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = mainFrame.size.height / 2 - frame.size.height / 2;
    _DataContainActivity.frame = frame;
    [self.view addSubview:_DataContainActivity];
    
    _DataStringArray =[[NSArray alloc] initWithObjects:[self Getlogedinuserid], nil];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self GetProviderServiceListDetails];
    });
    
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
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:UrlParameterString.WebParamProviderMyQuotationList ValueObject:self.DataStringArray UrlParameter:UrlParameterString.URLParamProviderMyQuotationList];
        [Datadelegate setDelegate:self];
    }
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        if ([[ParamObjectCarrier objectForKey:@"errorcode"] intValue] == 1) {
            
            self.TableDataArray = [[NSMutableArray alloc] init];
            for (id WEbdetailsData in [ParamObjectCarrier objectForKey:@"my-quotations"]) {
                
                ProviderMYQuotationList *LocalObject = [[ProviderMYQuotationList alloc] initWithQuotationId:[WEbdetailsData objectForKey:@"id"] QuotationModuleId:[WEbdetailsData objectForKey:@"module_id"] QuotationModuleName:[WEbdetailsData objectForKey:@"module_name"] QuotationBidAmount:[WEbdetailsData objectForKey:@"bid_amount"] QuotationStartDate:[WEbdetailsData objectForKey:@"start_date"] QuotationEndDate:[WEbdetailsData objectForKey:@"end_date"] QuotationDuration:[WEbdetailsData objectForKey:@"duration"] QuotationNote:[WEbdetailsData objectForKey:@"note"] QuotationIsBlocked:[WEbdetailsData objectForKey:@"is_blocked"] QuotationIsAwarded:[WEbdetailsData objectForKey:@"is_awarded"] QuotationIsDeclined:[WEbdetailsData objectForKey:@"is_declined"] QuotationIsRevision:[WEbdetailsData objectForKey:@"is_revision"] QuotationQuotationTime:[WEbdetailsData objectForKey:@"quotation_time"] QuotationBookingNumber:[WEbdetailsData objectForKey:@"booking_no"] QuotationBookingIsPaid:[WEbdetailsData objectForKey:@"is_paid"]];
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

#pragma Tableview Datasorce Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *DataCell = [[UITableViewCell alloc] init];
    
    float SeperaterLabelDiff = 150.0f;
    float NextSeperaterPosition = 0.0f;
    
    ProviderMYQuotationList *LocalObject = [self.TableDataArray objectAtIndex:indexPath.row];
    
    for (int i=0; i< [_HeaderContainerArray count]; i++) {
        
        if (i==[_HeaderContainerArray count]-1) {
            
            UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 0, 1, DataCell.contentView.layer.frame.size.height+5)];
            [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
            [DataCell.contentView addSubview:SeperaterLabel];
            
            UIButton *ViewDetailsButton = [[UIButton alloc] initWithFrame:CGRectMake(NextSeperaterPosition+12 ,5, 100, 40)];
            [ViewDetailsButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
            [ViewDetailsButton setTitle:@"View" forState:UIControlStateNormal];
            [ViewDetailsButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
            [ViewDetailsButton.layer setCornerRadius:2.0f];
            [ViewDetailsButton addTarget:self action:@selector(ViewDetails:) forControlEvents:UIControlEventTouchUpInside];
            [ViewDetailsButton.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
            [ViewDetailsButton.layer setBorderWidth:1.0f];
            [ViewDetailsButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [ViewDetailsButton setTag:7777+indexPath.row];
            [DataCell addSubview:ViewDetailsButton];
            
            UIButton *EditDetailsButton = [[UIButton alloc] initWithFrame:CGRectMake(NextSeperaterPosition+120 ,5, 100, 40)];
            [EditDetailsButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
            [EditDetailsButton setTitle:@"Edit" forState:UIControlStateNormal];
            [EditDetailsButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
            [EditDetailsButton.layer setCornerRadius:2.0f];
            [EditDetailsButton.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
            [EditDetailsButton.layer setBorderWidth:1.0f];
            [EditDetailsButton addTarget:self action:@selector(EditDetails:) forControlEvents:UIControlEventTouchUpInside];
            [EditDetailsButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [EditDetailsButton setTag:8888+indexPath.row];
            [DataCell addSubview:EditDetailsButton];
            
            UIButton *DeleteDetailsButton = [[UIButton alloc] initWithFrame:CGRectMake(NextSeperaterPosition+230 ,5, 100, 40)];
            [DeleteDetailsButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
            [DeleteDetailsButton setTitle:@"Delete" forState:UIControlStateNormal];
            [DeleteDetailsButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
            [DeleteDetailsButton.layer setCornerRadius:2.0f];
            [DeleteDetailsButton.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
            [DeleteDetailsButton.layer setBorderWidth:1.0f];
            [DeleteDetailsButton addTarget:self action:@selector(DeleteDetails:) forControlEvents:UIControlEventTouchUpInside];
            [DeleteDetailsButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
            [DeleteDetailsButton setTag:8888+indexPath.row];
            [DataCell addSubview:DeleteDetailsButton];
            
        } else {
            UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 5.5, SeperaterLabelDiff, 50)];
            [TitleLabel setBackgroundColor:[UIColor clearColor]];
            [TitleLabel setTextColor:[UIColor darkTextColor]];
            switch (i) {
                case 0:
                    [TitleLabel setText:LocalObject.QuotationModuleName];
                    break;
                case 1:
                    [TitleLabel setText:[NSString stringWithFormat:@"%@ USD",LocalObject.QuotationBidAmount]];
                    break;
                case 2:
                    [TitleLabel setText:[NSString stringWithFormat:@"%@ Day (s)",LocalObject.QuotationDuration]];
                    break;
                case 3:
                    [TitleLabel setText:[LocalObject.QuotationIsAwarded isEqualToString:@"1"]?@"Awarded":@"Not Awarded"];
                    break;
                case 4:
                    [TitleLabel setText:[LocalObject.QuotationIsBlocked isEqualToString:@"1"]?@"Close":@"Open"];
                    break;
                case 5:
                    [TitleLabel setText:LocalObject.QuotationBookingNumber];
                    break;
            }
            [TitleLabel setTextAlignment:NSTextAlignmentCenter];
            [TitleLabel setNumberOfLines:0];
            [TitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
            [DataCell.contentView addSubview:TitleLabel];
            
            UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 0, 1, DataCell.contentView.layer.frame.size.height+5)];
            [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
            [DataCell.contentView addSubview:SeperaterLabel];
            
            NextSeperaterPosition = NextSeperaterPosition+SeperaterLabelDiff;
        }
    }
    
    [DataCell.textLabel setTextColor:[UIColor darkGrayColor]];
    [DataCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    return DataCell;
}

-(IBAction)ViewDetails:(id)sender
{
    
}

-(IBAction)EditDetails:(id)sender
{
    
}

-(IBAction)DeleteDetails:(id)sender
{
    UIAlertView *ConfirmAlert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure to delete" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [ConfirmAlert setTag:1456];
    [ConfirmAlert show];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.TableDataArray count];
}

#pragma Tableview Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float SeperaterLabelDiff = 150.0f;
    float NextSeperaterPosition = 0.0f;
    
    UIView *Headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [_HeaderContainerArray count]*150, 60)];
    [Headerview setBackgroundColor:[UIColor colorFromHex:0xc5c5c5]];
    
    for (int i=0; i< [_HeaderContainerArray count]; i++) {
        
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 20.5, (i==[_HeaderContainerArray count]-1)?SeperaterLabelDiff+190:SeperaterLabelDiff, 15)];
        [TitleLabel setBackgroundColor:[UIColor clearColor]];
        [TitleLabel setTextColor:[UIColor darkTextColor]];
        [TitleLabel setText:[_HeaderContainerArray objectAtIndex:i]];
        [TitleLabel setTextAlignment:NSTextAlignmentCenter];
        [TitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        [Headerview addSubview:TitleLabel];
        
        UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 0, 1, Headerview.layer.frame.size.height)];
        [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
        [Headerview addSubview:SeperaterLabel];
        
        NextSeperaterPosition = NextSeperaterPosition+SeperaterLabelDiff;
        
    }
    
    return Headerview;
}

/**
 *  Tableview select row
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
