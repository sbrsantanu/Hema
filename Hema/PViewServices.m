//
//  PViewServices.m
//  Hema
//
//  Created by Mac on 13/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PViewServices.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"
#import "GlobalStrings.h"
#import "MPApplicationGlobalConstants.h"
#import "PViewServicesDetails.h"

@interface PViewServices ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,WebserviceProtocolDelegate>
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

@implementation PViewServices

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
    [WelcomeMessage setText:@"View Services"];
    [self.view addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, mainFrame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline];
    
    _HeaderContainerArray = [[NSArray alloc] initWithObjects:@"Service Name",@"Short Description",@"Rate",@"Rate Valied Till",@"Tax (%)",@"Discount (%)",@"Shipping Cost",@"Action", nil];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-181)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setContentSize:CGSizeMake(150*[_HeaderContainerArray count]+80, self.view.frame.size.height-181)];
    [_MainScrollView setDelegate:self];
    [_MainScrollView setBounces:NO];
    [self.view addSubview:_MainScrollView];
    
    _DataContainerView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [_HeaderContainerArray count]*150+80, _MainScrollView.layer.frame.size.height) style:UITableViewStylePlain];
    [_DataContainerView setDelegate:self];
    [_DataContainerView setDataSource:self];
    [_DataContainerView setBounces:NO];
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
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:UrlParameterString.WebParamProviderViewServicelist ValueObject:_DataStringArray UrlParameter:UrlParameterString.URLParamProviderViewServicelist];
        [Datadelegate setDelegate:self];
    }
}

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    
    NSLog(@"ParamObjectCarrier ---- %@",ParamObjectCarrier);
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        if ([[ParamObjectCarrier objectForKey:@"errorcode"] intValue] == 1) {
            
            int i =0;
            self.TableDataArray = [[NSMutableArray alloc] init];
            for (id WEbdetailsData in [ParamObjectCarrier objectForKey:@"service"]) {
                
                if (i!=0) {
                    
                    ProviderViewServicesList *ProviderServices = [[ProviderViewServicesList alloc] initWithServiceId:[WEbdetailsData objectForKey:@"service_id"] ServiceName:[WEbdetailsData objectForKey:@"name"] ServiceShortDescription:[WEbdetailsData objectForKey:@"short_description"] ServiceRate:[WEbdetailsData objectForKey:@"rate"] ServiceCurrencyCode:[WEbdetailsData objectForKey:@"currency_code"] ServiceRateValidTill:[WEbdetailsData objectForKey:@"rate_valid_till"] ServiceTax:[WEbdetailsData objectForKey:@"tax"] ServiceDiscount:[WEbdetailsData objectForKey:@"discount"] ServiceShippingCost:[WEbdetailsData objectForKey:@"shipping_cost"]];
                    [self.TableDataArray addObject:ProviderServices];
                } else {
                    self.CategoryArray = [[NSMutableArray alloc] init];
                    for (id WEbdetailsDataOne in WEbdetailsData) {
                        
                        ServiceCategory *DataCategory = [[ServiceCategory alloc] initWithCategoryId:[WEbdetailsDataOne objectForKey:@"category_id"] CategoryName:[WEbdetailsDataOne objectForKey:@"category_name"]];
                        [self.CategoryArray addObject:DataCategory];
                    }
                }
                i++;
            }
            [_DataContainActivity stopAnimating];
            [_DataContainerView setHidden:NO];
            [_DataContainerView reloadData];
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
    
    ProviderViewServicesList *LocalObject = [self.TableDataArray objectAtIndex:indexPath.row];
    
    for (int i = 0; i< [_HeaderContainerArray count]; i++) {
        
        if (i==7) {
            
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
            
        } else {
            UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 16.5, SeperaterLabelDiff, 15)];
            [TitleLabel setBackgroundColor:[UIColor clearColor]];
            [TitleLabel setTextColor:[UIColor darkTextColor]];
            switch (i) {
                case 0:
                    [TitleLabel setText:LocalObject.ServiceName];
                    break;
                case 1:
                    [TitleLabel setText:LocalObject.ServiceShortDescription];
                    break;
                case 2:
                    [TitleLabel setText:LocalObject.ServiceRate];
                    break;
                case 3:
                    [TitleLabel setText:LocalObject.ServiceRateValidTill];
                    break;
                case 4:
                    [TitleLabel setText:LocalObject.ServiceTax];
                    break;
                case 5:
                    [TitleLabel setText:LocalObject.ServiceDiscount];
                    break;
                case 6:
                    [TitleLabel setText:LocalObject.ServiceShippingCost];
                    break;
            }
            [TitleLabel setTextAlignment:NSTextAlignmentCenter];
            [TitleLabel setNumberOfLines:0];
            [TitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
            [DataCell.contentView addSubview:TitleLabel];
            
            UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 0, 1, DataCell.contentView.layer.frame.size.height+5)];
            [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
            [DataCell.contentView addSubview:SeperaterLabel];
        }
        NextSeperaterPosition = NextSeperaterPosition+SeperaterLabelDiff;
    }
    
    [DataCell.textLabel setTextColor:[UIColor darkGrayColor]];
    [DataCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    return DataCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.TableDataArray.count;
}

#pragma Perform Operation

-(IBAction)ViewDetails:(UIButton *)sender
{
    NSLog(@"ViewDetails Tag --- %ld",(long)sender.tag);
    
    ProviderViewServicesList *LocalObject = [self.TableDataArray objectAtIndex:(sender.tag - 7777)];
    PViewServicesDetails *ProviderServiceDetails = [[PViewServicesDetails alloc] initWithNibName:nil bundle:nil ServiceId:LocalObject.ServiceId];
    [self GotoDifferentViewWithAnimation:ProviderServiceDetails];
    
}
-(IBAction)EditDetails:(UIButton *)sender
{
    NSLog(@"EditDetails Tag --- %ld",(long)sender.tag);
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
       // NSLog(@"------- %d",i);
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(NextSeperaterPosition, 20.5, (i==7)?SeperaterLabelDiff+80:SeperaterLabelDiff, 15)];
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
