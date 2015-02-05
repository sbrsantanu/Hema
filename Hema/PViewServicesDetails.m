//
//  PViewServicesDetails.m
//  Hema
//
//  Created by Mac on 05/02/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PViewServicesDetails.h"
#import "UIColor+HexColor.h"
#import "WebserviceProtocol.h"
#import "UrlParameterString.h"
#import "GlobalModelObjects.h"
#import "GlobalStrings.h"
#import "MPApplicationGlobalConstants.h"
#import "MDIncrementalImageView.h"

@interface PViewServicesDetails ()<UITableViewDataSource,UITableViewDelegate,WebserviceProtocolDelegate,UIAlertViewDelegate>
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
@property (nonatomic,retain) NSMutableArray *TableviewDataArrayUnused;
@property (nonatomic,retain) UIActivityIndicatorView *MainActivity;

@property (nonatomic,retain) NSString *ServiceId;
@end

@implementation PViewServicesDetails

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ServiceId:(NSString *)ParamServiceId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        mainFrame = [[UIScreen mainScreen] bounds];
        self.ServiceId = ParamServiceId;
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        // Call Webservice Data
        
        _DataStringArray =[[NSArray alloc] initWithObjects:self.ServiceId, nil];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [self GetProviderAccountDetails];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [_DataContainActivity stopAnimating];
                [_DataContainTable setHidden:NO];
            });
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
    [WelcomeMessage setText:@"View Service Information"];
    [self.view addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, mainFrame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:WelcomeUnderline];
    
    self.DataContainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, mainFrame.size.width, mainFrame.size.height-180) style:UITableViewStylePlain];
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
    
    _TableSectionHeaderTextArray = [[NSArray alloc] initWithObjects:@"Service Title",@"Short Description",@"Full Description",@"Rate",@"Rate Valid Till",@"Tax",@"Allow Discount",@"Discount (%)",@"Shipping",@"Shipping Cost",@"Image", nil];
    
    CGRect frame = _DataContainActivity.frame;
    frame.origin.x = mainFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = mainFrame.size.height / 2 - frame.size.height / 2;
    _DataContainActivity.frame = frame;
    [self.view addSubview:_DataContainActivity];
}

#pragma Webservice Process

-(void)GetProviderAccountDetails
{
    if (!IS_NETWORK_AVAILABLE())
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            SHOW_NETWORK_ERROR_ALERT();
        });
    } else {
        WebserviceProtocol *Datadelegate = [[WebserviceProtocol alloc] initWithParamObject:UrlParameterString.WebParamProviderViewServiceDetail ValueObject:_DataStringArray UrlParameter:UrlParameterString.URLParamProviderViewServiceDetail];
        [Datadelegate setDelegate:self];
    }
}

/**
 *  Success
 */

-(void)RetunWebserviceDataWithSuccess:(WebserviceProtocol *)DataDelegate ObjectCarrier:(NSDictionary *)ParamObjectCarrier
{
    if ([[ParamObjectCarrier objectForKey:@"errorcode"]intValue] == 1) {
        
        NSLock* arrayLock = [[NSLock alloc] init];
        [arrayLock lock];
        
        for (id LocalObjectdata in [ParamObjectCarrier objectForKey:@"service"]) {
            
            ProviderServiceDetails *LocalObject = [[ProviderServiceDetails alloc] initWithSDetailsId:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"id"] SDetailsProviderId:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"provider_id"] SDetailsName:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"name"] SDetailsShortDescription:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"short_description"] SDetailsFullDescription:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"full_description"] SDetailsRate:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"rate"] SDetailsServiceCategory:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"service_category"] SDetailsCategoryName:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"category_name"] SDetailsCurrencyCode:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"currency_code"] SDetailsLogo:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"logo"] SDetailsRateValidTill:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"rate_valid_till"] SDetailsTax:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"tax"] SDetailsAllowDiscount:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"allow_discount"] SDetailsDiscount:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"discount"] SDetailsShipping:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"shipping"] SDetailsShippingCost:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"shipping_cost"]];
            
            self.TableviewDataArrayUnused = [[NSMutableArray alloc] initWithObjects:LocalObject, nil];
            
            self.TableviewDataArray = [[NSMutableArray alloc] initWithObjects:[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"name"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"short_description"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"full_description"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"rate"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"rate_valid_till"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"tax"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"allow_discount"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"discount"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"shipping"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"shipping_cost"],[[ParamObjectCarrier objectForKey:@"service"] objectForKey:@"logo"], nil];
            
            NSLog(@"LocalObjectdata --- %@",LocalObjectdata);
        }
        [arrayLock unlock];
        
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
    
    if (indexPath.section == 10) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 150, 150)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 111;
        [DataCell addSubview:imageView];
        
        //CGRect mainFrame = [[UIScreen mainScreen] bounds];
        _MainActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect frame = _MainActivity.frame;
        frame.origin.x = imageView.layer.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = imageView.layer.frame.size.height / 2 - frame.size.height / 2;
        _MainActivity.frame = frame;
        [_MainActivity setColor:[UIColor colorFromHex:0xe66a4c]];
        [_MainActivity startAnimating];
        [_MainActivity hidesWhenStopped];
        [imageView addSubview:_MainActivity];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"setviewservicesimage"] isEqualToString:@"Y"]) {
            
            [_MainActivity stopAnimating];
            [imageView setImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"setviewservicesimagedata"]]];
            
        } else {
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[self.TableviewDataArray objectAtIndex:indexPath.section]]];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [imageView setImage:[UIImage imageWithData:data]];
                    [_MainActivity stopAnimating];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"setviewservicesimage"];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"setviewservicesimagedata"];
                });
            });
        }
    } else {
        [DataCell.textLabel setNumberOfLines:0];
        [DataCell.textLabel setText:[self.TableviewDataArray objectAtIndex:indexPath.section]];
        [DataCell.textLabel setTextColor:[UIColor darkGrayColor]];
        [DataCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
        
    }
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
    return (indexPath.section == 10 || indexPath.section == 2)?200.0f:50.0f;
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

-(void)viewDidDisappear:(BOOL)animated  
{
    [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"setviewservicesimage"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"setviewservicesimagedata"];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
