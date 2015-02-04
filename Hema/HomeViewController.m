//
//  HomeViewController.m
//  Hema
//
//  Created by Mac on 15/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "HomeViewController.h"
#import "UITextField+Attribute.h"
#import "UIColor+HexColor.h"
#import "AppDelegate.h"
#import "RMDateSelectionViewController.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "RegisterViewController.h"
#import "BookingListViewController.h"
#import "NSString+PJR.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "GlobalStrings.h"

typedef enum {
    DateSelectedNone,
    DateSelectedStartDate,
    DateSelectedenddate
} DateSelected;

typedef enum {
    CategorySelectedNone,
    CategorySelectedConference,
    CategorySelectedEvent,
    CategorySelectedDestination
} CategorySelected;

@interface HomeViewController ()<UIScrollViewDelegate,UITextFieldDelegate,RMDateSelectionViewControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) UITextField *BookEvent;
@property (nonatomic,retain) UITextField *BookEventStartDate;
@property (nonatomic,retain) UITextField *BookEventEnddate;
@property (assign) DateSelected DateSelectedMode;
@property (assign) CategorySelected CategorySelectedMode;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect mainFrame = [[UIScreen mainScreen] bounds];
        self.view.layer.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderView]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Home"]];
    
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, mainFrame.size.width, mainFrame.size.height-150)];
    [_MainScrollView setContentSize:CGSizeMake(mainFrame.size.width, mainFrame.size.height)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 9, mainFrame.size.width-21, 21)];
    [TitleLabel setFont:[UIFont fontWithName:@"Arial-Bold" size:14.0]];
    [TitleLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [TitleLabel setText:@"Book Your Event"];
    [_MainScrollView addSubview:TitleLabel];
    
    UILabel *SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 19, mainFrame.size.width-170, 1)];
    [SeperaterLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_MainScrollView addSubview:SeperaterLabel];
    
    UILabel *category = [[UILabel alloc]initWithFrame:CGRectMake(21, 54, 284, 21)];
    [category setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    [category setTextColor:[UIColor colorFromHex:0x705044]];
    [category setText:@"Select Your Category"];
    [_MainScrollView addSubview:category];
    
    UIButton *ConfarenceBut = [[UIButton alloc] initWithFrame:CGRectMake(159, 54, 24, 24)];
    [ConfarenceBut setBackgroundColor:[UIColor clearColor]];
    [ConfarenceBut setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [ConfarenceBut setTag:101];
    [_MainScrollView addSubview:ConfarenceBut];
    
    UILabel *Confarence = [[UILabel alloc]initWithFrame:CGRectMake(191, 55, 124, 21)];
    [Confarence setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    [Confarence setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [Confarence setText:@"Conference Booking"];
    [_MainScrollView addSubview:Confarence];
    
    UIButton *EventBut = [[UIButton alloc] initWithFrame:CGRectMake(159, 86, 24, 24)];
    [EventBut setBackgroundColor:[UIColor clearColor]];
    [EventBut setBackgroundImage:[UIImage imageNamed:@"no-select.png"] forState:UIControlStateNormal];
    [EventBut setTag:102];
    [_MainScrollView addSubview:EventBut];
    
    UILabel *Event = [[UILabel alloc]initWithFrame:CGRectMake(191, 87, 124, 21)];
    [Event setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    [Event setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [Event setText:@"Event Booking"];
    [_MainScrollView addSubview:Event];
    
    UIButton *DestinationBut = [[UIButton alloc] initWithFrame:CGRectMake(159, 118, 24, 24)];
    [DestinationBut setBackgroundColor:[UIColor clearColor]];
    [DestinationBut setBackgroundImage:[UIImage imageNamed:@"no-select.png"] forState:UIControlStateNormal];
    [DestinationBut setTag:103];
    [_MainScrollView addSubview:DestinationBut];
    
    UILabel *Destination = [[UILabel alloc]initWithFrame:CGRectMake(191, 119, 124, 21)];
    [Destination setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    [Destination setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [Destination setText:@"Destination Planning"];
    [_MainScrollView addSubview:Destination];
    
    _BookEvent = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, mainFrame.size.width-40, 40)];
    [_BookEvent customizeWithplaceholderText:@"- City/Hotel Name" andImage:@" "];
    [_BookEvent setTag:443];
    [_MainScrollView addSubview:_BookEvent];
    
    _BookEventStartDate = [[UITextField alloc] initWithFrame:CGRectMake(20, 210, mainFrame.size.width-40, 40)];
    [_BookEventStartDate customizeWithPlaceholderText:@"- Start Date" andImageOnRightView:@"calender.png" andLeftBarText:@""];
    [_BookEventStartDate setTag:444];
    [_MainScrollView addSubview:_BookEventStartDate];
    
    UIButton *BookEventStartSelectBut = [[UIButton alloc] initWithFrame:CGRectMake(_BookEventStartDate.layer.frame.size.width-40, 0, 40, 40)];
   // [BookEventStartSelectBut setBackgroundColor:[UIColor redColor]];
    [BookEventStartSelectBut addTarget:self action:@selector(BookEventStartSelectButSelect) forControlEvents:UIControlEventTouchUpInside];
    [_BookEventStartDate addSubview:BookEventStartSelectBut];
    
    _BookEventEnddate = [[UITextField alloc] initWithFrame:CGRectMake(20, 260, mainFrame.size.width-40, 40)];
    [_BookEventEnddate customizeWithPlaceholderText:@"- End Date" andImageOnRightView:@"calender.png" andLeftBarText:@""];
    [_BookEventEnddate setTag:445];
    [_MainScrollView addSubview:_BookEventEnddate];
    
    UIButton *BookEventEndSelectBut = [[UIButton alloc] initWithFrame:CGRectMake(_BookEventStartDate.layer.frame.size.width-40, 0, 40, 40)];
    [BookEventStartSelectBut addTarget:self action:@selector(BookEventEndSelectButSelect) forControlEvents:UIControlEventTouchUpInside];
   // [BookEventEndSelectBut setBackgroundColor:[UIColor redColor]];
    [_BookEventEnddate bringSubviewToFront:BookEventEndSelectBut];
    [_BookEventEnddate addSubview:BookEventEndSelectBut];
    
    // Find Now Button
    
    UIButton *FindNowButton = [[UIButton alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-70 ,315, 140, 40)];
    [FindNowButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [FindNowButton setTitle:@"Find Now" forState:UIControlStateNormal];
    [FindNowButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [FindNowButton.layer setCornerRadius:3.0f];
    [FindNowButton addTarget:self action:@selector(FindNow) forControlEvents:UIControlEventTouchUpInside];
    [FindNowButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [FindNowButton setTag:104];
    [_MainScrollView addSubview:FindNowButton];
    
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField setDelegate:self];
        }
    }
    
    for (id AllButton in _MainScrollView.subviews) {
        if ([AllButton isKindOfClass:[UIButton class]]) {
            UIButton *DataUIButton = (UIButton *)AllButton;
            [DataUIButton addTarget:self action:@selector(ButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.DateSelectedMode = DateSelectedNone;
    self.CategorySelectedMode = CategorySelectedConference;
    
}

-(void)BookEventStartSelectButSelect
{
    self.DateSelectedMode = DateSelectedStartDate;
    [self openDateSelectionController:_BookEventStartDate];
}

-(void)BookEventEndSelectButSelect
{
    self.DateSelectedMode = DateSelectedenddate;
    [self openDateSelectionController:_BookEventEnddate];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 444 || textField.tag == 445) {
        [textField resignFirstResponder];
        self.DateSelectedMode = (textField.tag == 444)?DateSelectedStartDate:DateSelectedenddate;
        [self openDateSelectionController:textField];
    } else {
        [UIView animateWithDuration:1.0 animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 100)];
        } completion:nil];
    }
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
        self.DateSelectedMode = DateSelectedNone;
        [_MainScrollView setContentOffset:CGPointMake(0, 0)];
    } completion:nil];
    return YES;
}

-(IBAction)ButtonSelected:(UIButton *)sender
{
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField resignFirstResponder];
        }
    }
    
    if (sender.tag == 104) {
        [sender addTarget:sender action:@selector(FindNow) forControlEvents:UIControlEventTouchUpInside];
    } else {
        for (id AllButton in _MainScrollView.subviews) {
            if ([AllButton isKindOfClass:[UIButton class]]) {
                UIButton *DataUIButton = (UIButton *)AllButton;
                if (DataUIButton.tag == 101 || DataUIButton.tag == 102 || DataUIButton.tag == 103) {
                    [DataUIButton setImage:[UIImage imageNamed:@"no-select.png"] forState:UIControlStateNormal];
                }
            }
        }
        
        UIButton *CategoryButton = (UIButton *)[_MainScrollView viewWithTag:sender.tag];
        [CategoryButton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
        
        switch (sender.tag) {
            case 101:
            {
                self.CategorySelectedMode = CategorySelectedConference;
            }
                break;
            case 102:
            {
                self.CategorySelectedMode = CategorySelectedEvent;
            }
                break;
            case 103:
            {
                self.CategorySelectedMode = CategorySelectedDestination;
            }
                break;
            default:
            {
                self.CategorySelectedMode = CategorySelectedConference;
            }
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)FindNow
{
    BookingListViewController *BookingList = nil;
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField resignFirstResponder];
        }
    }
    
    if (_CategorySelectedMode == CategorySelectedNone) {
        
        NSLog(@"Need to select category first");
        
    } else if (_CategorySelectedMode == CategorySelectedConference) {
        BookingList = [[BookingListViewController alloc] initWithBookingCategory:SelectedBookingTypeConference CityorHotelname:[_BookEvent.text CleanTextField] StartDate:[_BookEventStartDate.text CleanTextField] EndDate:[_BookEventEnddate.text CleanTextField]];
    } else if (_CategorySelectedMode == CategorySelectedEvent) {
        BookingList = [[BookingListViewController alloc] initWithBookingCategory:SelectedBookingTypeEvent CityorHotelname:[_BookEvent.text CleanTextField] StartDate:[_BookEventStartDate.text CleanTextField] EndDate:[_BookEventEnddate.text CleanTextField]];
    } else if (_CategorySelectedMode == CategorySelectedDestination) {
        BookingList = [[BookingListViewController alloc] initWithBookingCategory:SelectedBookingTypeDestination CityorHotelname:[_BookEvent.text CleanTextField] StartDate:[_BookEventStartDate.text CleanTextField] EndDate:[_BookEventEnddate.text CleanTextField]];
    }
    [self GotoDifferentViewWithAnimation:BookingList];
}

- (IBAction)openDateSelectionController:(UITextField *)sender {
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
    
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    dateSelectionVC.titleLabel.text = @"Please choose a date and press 'Select' or 'Cancel'.";
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    //dateSelectionVC.datePicker.minimumDate = [NSDate date];
    dateSelectionVC.datePicker.minuteInterval = 5;
    [dateSelectionVC show];
}

#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    
    NSArray *SelectedDate = [[NSString stringWithFormat:@"%@",aDate] componentsSeparatedByString:@" "];
    if (self.DateSelectedMode == DateSelectedStartDate) {
        [_BookEventStartDate setText:[SelectedDate objectAtIndex:0]];
    } else if (self.DateSelectedMode == DateSelectedenddate) {
        [_BookEventEnddate setText:[SelectedDate objectAtIndex:0]];
    }
    self.DateSelectedMode = DateSelectedNone;
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    self.DateSelectedMode = DateSelectedNone;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.DateSelectedMode = DateSelectedNone;
    self.CategorySelectedMode = CategorySelectedNone;
    
    for (id AlltextField in _MainScrollView.subviews) {
        if ([AlltextField isKindOfClass:[UITextField class]]) {
            UITextField *DatatextField = (UITextField *)AlltextField;
            [DatatextField resignFirstResponder];
            [DatatextField setText:nil];
        }
    }
}


@end
