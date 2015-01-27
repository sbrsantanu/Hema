//
//  Providerdashboard.m
//  Hema
//
//  Created by Mac on 02/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "Providerdashboard.h"
#import "UIButton+Dashboard.h"
#import "UIColor+HexColor.h"

#import "PViewProfile.h"
#import "PEditProfile.h"
#import "PPChangePassword.h"
#import "PAddServices.h"
#import "PViewServices.h"
#import "PViewQuotationRequest.h"
#import "PMyQuotations.h"
#import "PContactWithHemaAdmin.h"
#import "PHistoryOfConversion.h"
#import "PIssues.h"
#import "KeychainItemWrapper.h"
#import <Security/Security.h>

@interface Providerdashboard ()<UIScrollViewDelegate>
@property (nonatomic,retain) UIScrollView *BGScrollView;
@property (nonatomic,retain) KeychainItemWrapper *keychainItemWrapper;
@end

@implementation Providerdashboard

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
    
    UILabel *WelcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, mainFrame.size.width-10, 20)];
    [WelcomeMessage setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [WelcomeMessage setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage setTextAlignment:NSTextAlignmentRight];
    [WelcomeMessage setText:[NSString stringWithFormat:@"Welcome, %@",[self Getlogedinusername]]];
    [self.view addSubview:WelcomeMessage];
    
    float DashboardButtonXPosition = 5.0f;
    float DashboardButtonYPosition = 120.0f;
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
    [self.view addSubview:ProfileButton];
    
    ImageCount ++;
    
    // Edit Profile
    
    UIButton *EditProfileButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DashboardButtonYPosition, DasboardButtonWidth, DasboardButtonHeight)];
    [EditProfileButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Edit Profile"];
    [EditProfileButton setTag:778];
    [EditProfileButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:EditProfileButton];
    
    ImageCount ++;
    
    /**
     *  Second Line
     */
    
    // Change Password
    
    UIButton *ChangePasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*1+DashboardButtonYPosition+DasboardYpositionGap*1, DasboardButtonWidth, DasboardButtonHeight)];
    [ChangePasswordButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Change Password"];
    [ChangePasswordButton setTag:779];
    [ChangePasswordButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ChangePasswordButton];
    
    ImageCount ++;
    
    // Add Event / Requirement
    
    UIButton *EventRequestButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*1+DashboardButtonYPosition*1+DasboardYpositionGap, DasboardButtonWidth, DasboardButtonHeight)];
    [EventRequestButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Add Service"];
    [EventRequestButton setTag:780];
    [EventRequestButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:EventRequestButton];
    
    ImageCount ++;
    
    /**
     *  Third Line
     */
    
    
    // View History
    
    UIButton *ViewHistoryButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*2+DashboardButtonYPosition+DasboardYpositionGap*2, DasboardButtonWidth, DasboardButtonHeight)];
    [ViewHistoryButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"View Service"];
    [ViewHistoryButton setTag:781];
    [ViewHistoryButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ViewHistoryButton];
    
    ImageCount ++;
    
    // Completed Event/Job
    
    UIButton *CompletedEventButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*2+DashboardButtonYPosition+DasboardYpositionGap*2, DasboardButtonWidth, DasboardButtonHeight)];
    [CompletedEventButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"View Quotation Requestet"];
    [CompletedEventButton setTag:782];
    [CompletedEventButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CompletedEventButton];
    
    ImageCount ++;
    
    /**
     *  Fourth Line
     */
    
    // Feedback
    
    UIButton *FeedbackButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*3+DashboardButtonYPosition+DasboardYpositionGap*3, DasboardButtonWidth, DasboardButtonHeight)];
    [FeedbackButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"My Quotations"];
    [FeedbackButton setTag:783];
    [FeedbackButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FeedbackButton];
    
    ImageCount ++;
    
    // Contact to HEMA Admin
    
    UIButton *ContactAdminButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*3+DashboardButtonYPosition+DasboardYpositionGap*3, DasboardButtonWidth, DasboardButtonHeight)];
    [ContactAdminButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Contact to HEMA Admin"];
    [ContactAdminButton setTag:784];
    [ContactAdminButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ContactAdminButton];
    
    ImageCount ++;
    
    /**
     *  Fifth Line
     */
    
    // History Of Conversation
    
    UIButton *ConversationHistoryButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition, DasboardButtonHeight*4+DashboardButtonYPosition+DasboardYpositionGap*4, DasboardButtonWidth, DasboardButtonHeight)];
    [ConversationHistoryButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"History Of Conversation"];
    [ConversationHistoryButton setTag:785];
    [ConversationHistoryButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ConversationHistoryButton];
    
    ImageCount ++;
    
    // Notification
    
    UIButton *NotificationButton = [[UIButton alloc] initWithFrame:CGRectMake(DashboardButtonXPosition+DasboardXpositionGap+DasboardButtonWidth, DasboardButtonHeight*4+DashboardButtonYPosition+DasboardYpositionGap*4, DasboardButtonWidth, DasboardButtonHeight)];
    [NotificationButton CustomizeDashboardButtonWithImagename:[NSString stringWithFormat:@"dbimg%d",ImageCount] WithTitle:@"Issues"];
    [NotificationButton setTag:786];
    [NotificationButton addTarget:self action:@selector(DashBoardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NotificationButton];
    
}

/**
 *  Perform Dashboard Button Click Operation
 */

-(IBAction)DashBoardButtonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 777:
        {
            PViewProfile *ViewProfile = [[PViewProfile alloc] init];
            [self.navigationController pushViewController:ViewProfile animated:YES];
        }
            break;
        case 778:
        {
            PEditProfile *EditProfile = [[PEditProfile alloc] init];
            [self.navigationController pushViewController:EditProfile animated:YES];
        }
            break;
        case 779:
        {
            PChangePassword *ChangePassword = [[PChangePassword alloc] init];
            [self.navigationController pushViewController:ChangePassword animated:YES];
        }
            break;
        case 780:
        {
            PAddServices *AddServices = [[PAddServices alloc] init];
            [self.navigationController pushViewController:AddServices animated:YES];
        }
            break;
        case 781:
        {
            PViewServices *ViewServices = [[PViewServices alloc] init];
            [self.navigationController pushViewController:ViewServices animated:YES];
        }
            break;
        case 782:
        {
            PViewQuotationRequest *ViewQuotationRequest = [[PViewQuotationRequest alloc] init];
            [self.navigationController pushViewController:ViewQuotationRequest animated:YES];
        }
            break;
        case 783:
        {
            PMyQuotations *MyQuotations = [[PMyQuotations alloc] init];
            [self.navigationController pushViewController:MyQuotations animated:YES];
        }
            break;
        case 784:
        {
            PContactWithHemaAdmin *ContactWithHemaAdmin = [[PContactWithHemaAdmin alloc] init];
            [self.navigationController pushViewController:ContactWithHemaAdmin animated:YES];
        }
            break;
        case 785:
        {
            PHistoryOfConversion *HistoryOfConversion = [[PHistoryOfConversion alloc] init];
            [self.navigationController pushViewController:HistoryOfConversion animated:YES];
        }
            break;
        case 786:
        {
            PIssues *Issues = [[PIssues alloc] init];
            [self.navigationController pushViewController:Issues animated:YES];
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
    self.BGScrollView = nil;
}

@end
