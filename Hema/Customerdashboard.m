//
//  Customerdashboard.m
//  Hema
//
//  Created by Mac on 02/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "Customerdashboard.h"
#import "UIButton+Dashboard.h"
#import "UIColor+HexColor.h"
#import "CViewProfile.h"
#import "CEditProfile.h"
#import "CChangePassword.h"
#import "CAddEvent.h"
#import "CViewEventInformation.h"
#import "CContactToHemaAdmin.h"
#import "CNotificationList.h"
#import "CViewHistory.h"
#import "CCompletedEvent.h"
#import "CFeedbackList.h"
#import "CHistoryofConversion.h"

@interface Customerdashboard ()<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *MainScrollView;

@end

@implementation Customerdashboard

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:NO]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Dashboard"]];
    
    /**
     *  Welcome Message
     */
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, mainFrame.size.width, mainFrame.size.height-150)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    [_MainScrollView setContentSize:CGSizeMake(mainFrame.size.width, mainFrame.size.height)];
    
    UILabel *WelcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, mainFrame.size.width-10, 20)];
    [WelcomeMessage setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [WelcomeMessage setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage setTextAlignment:NSTextAlignmentRight];
    [WelcomeMessage setText:[NSString stringWithFormat:@"Welcome, %@",[self Getlogedinusername]]];
    [_MainScrollView addSubview:WelcomeMessage];
    
    float DashboardButtonXPosition = 5.0f;
    float DashboardButtonYPosition = 35.0f;
    float DasboardXpositionGap     = 10.0f;
    float DasboardYpositionGap     = 8.0f;
    float DasboardButtonWidth      = 150.0f;
    float DasboardButtonHeight     = 70.0f;
    int ImageCount                 = 1;
    
    if (mainFrame.size.width == 320) {
        DashboardButtonXPosition = 5.0f;
    } else if (mainFrame.size.width == 375) {
        DashboardButtonXPosition = 30.0f;
    } else if (mainFrame.size.width == 414) {
        DashboardButtonXPosition = 45.0f;
    }

    /**
     *  First Line
     */
    
    // View Profile
    
    UIButton *ProfileButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DashboardButtonYPosition, DasboardButtonWidth, DasboardButtonHeight)];
    [ProfileButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"View Profile"];
    [ProfileButton setTag:777];
    [ProfileButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:ProfileButton];
    
    ImageCount ++;
    
    // Edit Profile
    
    UIButton *EditProfileButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DashboardButtonYPosition, DasboardButtonWidth, DasboardButtonHeight)];
    [EditProfileButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Edit Profile"];
    [EditProfileButton setTag:778];
    [EditProfileButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:EditProfileButton];
    
    ImageCount ++;
    
    /**
     *  Second Line
     */
    
    // Change Password
    
    UIButton *ChangePasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*1+DashboardButtonYPosition+DasboardYpositionGap*1, DasboardButtonWidth, DasboardButtonHeight)];
    [ChangePasswordButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Change Password"];
    [ChangePasswordButton setTag:779];
    [ChangePasswordButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:ChangePasswordButton];
    
    ImageCount ++;
    
    // Add Event / Requirement
    
    UIButton *EventRequestButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*1+DashboardButtonYPosition*1+DasboardYpositionGap, DasboardButtonWidth, DasboardButtonHeight)];
    [EventRequestButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Add Event / Requirement"];
    [EventRequestButton setTag:780];
    [EventRequestButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:EventRequestButton];
    
    ImageCount ++;
    
    /**
     *  Third Line
     */
   
    
    // View History
    
    UIButton *ViewHistoryButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*2+DashboardButtonYPosition+DasboardYpositionGap*2, DasboardButtonWidth, DasboardButtonHeight)];
    [ViewHistoryButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"View History"];
    [ViewHistoryButton setTag:781];
    [ViewHistoryButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:ViewHistoryButton];
    
    ImageCount ++;
    
    // Completed Event/Job
    
    UIButton *CompletedEventButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*2+DashboardButtonYPosition+DasboardYpositionGap*2, DasboardButtonWidth, DasboardButtonHeight)];
    [CompletedEventButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Completed Event/Job"];
    [CompletedEventButton setTag:782];
    [CompletedEventButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:CompletedEventButton];
    
    ImageCount ++;
    
    /**
     *  Fourth Line
     */
    
    // Feedback
  
    UIButton *FeedbackButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*3+DashboardButtonYPosition+DasboardYpositionGap*3, DasboardButtonWidth, DasboardButtonHeight)];
    [FeedbackButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Feedback"];
    [FeedbackButton setTag:783];
    [FeedbackButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:FeedbackButton];
    
    ImageCount ++;
    
    // Contact to HEMA Admin
    
    UIButton *ContactAdminButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*3+DashboardButtonYPosition+DasboardYpositionGap*3, DasboardButtonWidth, DasboardButtonHeight)];
    [ContactAdminButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Contact to HEMA Admin"];
    [ContactAdminButton setTag:784];
    [ContactAdminButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:ContactAdminButton];
    
    ImageCount ++;
    
    /**
     *  Fifth Line
     */
 
    // History Of Conversation
    
    UIButton *ConversationHistoryButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*4+DashboardButtonYPosition+DasboardYpositionGap*4, DasboardButtonWidth, DasboardButtonHeight)];
    [ConversationHistoryButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"History Of Conversation"];
    [ConversationHistoryButton setTag:785];
    [ConversationHistoryButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:ConversationHistoryButton];
    
    ImageCount ++;
    
    // Notification
    
    UIButton *NotificationButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*4+DashboardButtonYPosition+DasboardYpositionGap*4, DasboardButtonWidth, DasboardButtonHeight)];
    [NotificationButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Notification"];
    [NotificationButton setTag:786];
    [NotificationButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:NotificationButton];

    
}

/**
 *  Perform Dashboard Button Click Operation
 */

-(IBAction)DashBoardButtonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 777:
        {
            CViewProfile *CustomerProfile = [[CViewProfile alloc] init];
            [self.navigationController pushViewController:CustomerProfile animated:YES];
        }
            break;
        case 778:
        {
            CEditProfile *EditProfile = [[CEditProfile alloc] init];
            [self.navigationController pushViewController:EditProfile animated:YES];
        }
            break;
        case 779:
        {
            CChangePassword *ChangePassword = [[CChangePassword alloc] init];
            [self.navigationController pushViewController:ChangePassword animated:YES];
        }
            break;
        case 780:
        {
            CAddEvent *AddEvent = [[CAddEvent alloc] init];
            [self.navigationController pushViewController:AddEvent animated:YES];
        }
            break;
        case 781:
        {
            CViewHistory *ViewHistory = [[CViewHistory alloc] init];
            [self.navigationController pushViewController:ViewHistory animated:YES];
        }
            break;
        case 782:
        {
            CCompletedEvent *CompletedEvent = [[CCompletedEvent alloc] init];
            [self.navigationController pushViewController:CompletedEvent animated:YES];
        }
            break;
        case 783:
        {
            CFeedbackList *FeedbackList = [[CFeedbackList alloc] init];
            [self.navigationController pushViewController:FeedbackList animated:YES];
        }
            break;
        case 784:
        {
            CContactToHemaAdmin *ContactToHemaAdmin = [[CContactToHemaAdmin alloc] init];
            [self.navigationController pushViewController:ContactToHemaAdmin animated:YES];
        }
            break;
        case 785:
        {
            CHistoryofConversion *HistoryofConversion = [[CHistoryofConversion alloc] init];
            [self.navigationController pushViewController:HistoryofConversion animated:YES];
        }
            break;
        case 786:
        {
            CNotificationList *NotificationList = [[CNotificationList alloc] init];
            [self.navigationController pushViewController:NotificationList animated:YES];
        }
            break;
    }
}

/**
 *  memory Warning Received
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  Release memory
 */

-(void)viewWillDisappear:(BOOL)animated
{
    self.MainScrollView = nil;
}

@end
