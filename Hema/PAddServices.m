//
//  PAddServices.m
//  Hema
//
//  Created by Mac on 13/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PAddServices.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"
#import "RMDateSelectionViewController.h"

typedef enum
{
    DatePickTypeNone,
    DatePickTypeFromDate,
    DatePickTypeToDate,
    DatePickTypeClosingDate,
    DatePickTypeContactDate
} DatePickType;

@interface PAddServices () <UIScrollViewDelegate,UITextFieldDelegate,RMDateSelectionViewControllerDelegate,UIAlertViewDelegate,UITextViewDelegate>
@property (nonatomic,retain) UIScrollView       *MainScrollView;
@property (nonatomic,retain) UIView             *HeaderNavigationViewBackgroundView;
@property (assign) DatePickType DateSelectionMode;


// All fields

@property (nonatomic,retain) UITextField * ANEventTitle;
@property (nonatomic,retain) SDAPlaceholderTextView  * ANEventLocation;
@property (nonatomic,retain) UITextField * ANCompanyname;
@property (nonatomic,retain) UITextField * ANContactname;
@property (nonatomic,retain) UITextField * ANPhoneNumber;
@property (nonatomic,retain) UITextField * ANEmailAddress;
@property (nonatomic,retain) UITextField * ANGuestNumber;
@property (nonatomic,retain) UITextField * ANFromdate;
@property (nonatomic,retain) UITextField * ANTodate;
@property (nonatomic,retain) UITextField * ANClosingDate;
@property (nonatomic,retain) UITextField * ANSignatory;
@property (nonatomic,retain) UITextField * ANBudget;
@property (nonatomic,retain) UITextField * ANContactDate;
@property (nonatomic,retain) UITextField * ANPreferedRoomRate;
@property (nonatomic,retain) UITextField * ANAuxiliaryService;
@property (nonatomic,retain) SDAPlaceholderTextView  * ANEventRequirements;
@property (nonatomic,retain) SDAPlaceholderTextView  * ANPreferedAlternetLocation;
@property (nonatomic,retain) UIButton    * SubmitButton;

@property (nonatomic,retain) NSArray *AddEventPlaceholderArray;

@end

@implementation PAddServices

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Dashboard"]];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height-150)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1200)];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    UILabel *WelcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,  self.view.frame.size.width-10, 20)];
    [WelcomeMessage setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage setTextColor:[UIColor darkGrayColor]];
    [WelcomeMessage setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage setTextAlignment:NSTextAlignmentLeft];
    [WelcomeMessage setText:@"Add Service"];
    [_MainScrollView addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [_MainScrollView addSubview:WelcomeUnderline];
    
    //float StatingYPosition          = 50.0f;
    float Difference                = 50.0f;
    float LastPosition              = 50.0f;
    int nextdatatag                 = 2001;
    float TextfieldWidth            = self.view.frame.size.width-40;
    float TextfieldHeight           = 40;
    float TextfieldXposition        = 20;
    float SubmitButtonWidth         = 140.0f;
    float SubmitButtonHeight        = 40.0f;
    float SubmitButtonxposition     = (self.view.frame.size.width-SubmitButtonWidth)/2;
    
    self.AddEventPlaceholderArray = [[NSArray alloc] initWithObjects:@"Event Title",@"Company Name",@"Contact Name",@"Email Address",@"Phone Number",@"No Of Guests",@"Signatory",@"Budget (USD)",@"Prefered Room Rate",@"Auxilary Service",@"From Date",@"To Date",@"Closing Date",@"Contact Date",@"Event Location",@"Event Requirements",@"Prefered Alternative Location", nil];
    
    // Name *
    
    self.ANEventTitle = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANEventTitle customizeWithPlaceholderText:@"Event Title" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANEventTitle setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANEventTitle];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    //  Company Name *
    
    self.ANEventTitle = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANEventTitle customizeWithPlaceholderText:@"Company Name" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANEventTitle setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANEventTitle];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    //  Company Name *
    
    self.ANContactname = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANContactname customizeWithPlaceholderText:@"Contact Name" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANContactname setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANContactname];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANEmailAddress = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANEmailAddress customizeWithPlaceholderText:@"Email Address" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANEmailAddress setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANEmailAddress];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANPhoneNumber customizeWithPlaceholderText:@"Phone Number" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANPhoneNumber setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANPhoneNumber];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANGuestNumber = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANGuestNumber customizeWithPlaceholderText:@"No of Guests" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANGuestNumber setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANGuestNumber];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANSignatory = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANSignatory customizeWithPlaceholderText:@"Signatory" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANSignatory setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANSignatory];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANBudget = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANBudget customizeWithPlaceholderText:@"Budget (USD)" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANBudget setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANBudget];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANPreferedRoomRate = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANPreferedRoomRate customizeWithPlaceholderText:@"Prefered Room Rate (USD)" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANPreferedRoomRate setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANPreferedRoomRate];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANAuxiliaryService = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANAuxiliaryService customizeWithPlaceholderText:@"Auxiliary Service" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.ANAuxiliaryService setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANAuxiliaryService];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANFromdate = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANFromdate customizeCalenderFieldWithPlaceholderText:@"From Date" andLeftBarText:@"*"];
    [self.ANFromdate setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANFromdate];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANTodate = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANTodate customizeCalenderFieldWithPlaceholderText:@"To Date" andLeftBarText:@"*"];
    [self.ANTodate setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANTodate];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANClosingDate = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANClosingDate customizeCalenderFieldWithPlaceholderText:@"Closing Date" andLeftBarText:@"*"];
    [self.ANClosingDate setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANClosingDate];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    self.ANContactDate = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.ANContactDate customizeCalenderFieldWithPlaceholderText:@"Contact Date" andLeftBarText:@""];
    [self.ANContactDate setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANContactDate];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Event Location
    
    self.ANEventLocation = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, 100)];
    [self.ANEventLocation setPlaceholder:@"Event Location"];
    [self.ANEventLocation setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.ANEventLocation setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANEventLocation];
    
    LastPosition = LastPosition + 60 + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Event Location
    
    self.ANEventRequirements = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, 100)];
    [self.ANEventRequirements setPlaceholder:@"Event Requirements"];
    [self.ANEventRequirements setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.ANEventRequirements setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANEventRequirements];
    
    LastPosition = LastPosition + 60 + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Event Location
    
    self.ANPreferedAlternetLocation = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, 100)];
    [self.ANPreferedAlternetLocation setPlaceholder:@"Prefered Alternate Location"];
    [self.ANPreferedAlternetLocation setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.ANPreferedAlternetLocation setTag:nextdatatag];
    [_MainScrollView addSubview:self.ANPreferedAlternetLocation];
    
    LastPosition = LastPosition + 20 + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Submit Button
    
    _SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(SubmitButtonxposition ,LastPosition+50, SubmitButtonWidth, SubmitButtonHeight)];
    [_SubmitButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [_SubmitButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_SubmitButton.layer setCornerRadius:3.0f];
    [_SubmitButton addTarget:self action:@selector(RegistrationProcess:) forControlEvents:UIControlEventTouchUpInside];
    [_SubmitButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_SubmitButton setTag:104];
    [_MainScrollView addSubview:_SubmitButton];
    
    // Submit
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField setDelegate:self];
            NSLog(@"UITextField ---- %ld",(long)textField.tag);
        }
    }
    
    for(id ASubview in [_MainScrollView subviews])
    {
        if([ASubview isKindOfClass:[UITextView class]])
        {
            UITextView *textView = (UITextView *)ASubview;
            [textView setDelegate:self];
            [textView.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
            [textView.layer setBorderWidth:1.0f];
            NSLog(@"textView ---- %ld",(long)textView.tag);
        }
    }
}

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2001) {
        
        for(id aSubView in [_MainScrollView subviews])
        {
            if([aSubView isKindOfClass:[UITextField class]])
            {
                UITextField *textField=(UITextField*)aSubView;
                [textField resignFirstResponder];
            }
        }
        
        return NO;
    } else if (textField.tag == 2010) {
        
        for(id aSubView in [_MainScrollView subviews])
        {
            if([aSubView isKindOfClass:[UITextField class]])
            {
                UITextField *textField=(UITextField*)aSubView;
                [textField resignFirstResponder];
            }
        }
        return NO;
    } else if (textField.tag == 2002) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 80) animated:YES];
        }];
    } else if (textField.tag == 2003) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 120) animated:YES];
        }];
    } else if (textField.tag == 2004) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 160) animated:YES];
        }];
    } else if (textField.tag == 2005) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 200) animated:YES];
        }];
    } else if (textField.tag == 2006) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 240) animated:YES];
        }];
    } else if (textField.tag == 2007) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 280) animated:YES];
        }];
    } else if (textField.tag == 2008) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 320) animated:YES];
        }];
    } else if (textField.tag == 2009) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 360) animated:YES];
        }];
    } else if (textField.tag == 2011) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 440) animated:YES];
        }];
    } else if (textField.tag == 2012) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 480) animated:YES];
        }];
    } else if (textField.tag == 2013) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 520) animated:YES];
        }];
    } else if (textField.tag == 2014) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 560) animated:YES];
        }];
    } else if (textField.tag == 2017) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 800) animated:YES];
        }];
    }
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for(id aSubView in [_MainScrollView subviews])
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

#pragma mark textview begin editing

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 2015) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    } else if (textView.tag == 2016) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
    
    if (textView.tag == 2015) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    } else if (textView.tag == 2016) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    }
    return YES;
}

@end
