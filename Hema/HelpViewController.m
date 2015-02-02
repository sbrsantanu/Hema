//
//  HelpViewController.m
//  Hema
//
//  Created by Mac on 15/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "HelpViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "UIColor+HexColor.h"
#import "HowitWorksViewController.h"
#import "BookingViewController.h"
#import "PlanningViewController.h"
#import "ContactViewController.h"

@interface HelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView *HelpTableView;
@property (nonatomic,retain) NSMutableArray * TableViewDataArray;
@property (nonatomic,retain) NSMutableArray * TableViewDataImage;

@end

@implementation HelpViewController

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
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Help"]];
    
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    _HelpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, mainFrame.size.width, mainFrame.size.height-150) style:UITableViewStyleGrouped];
    [_HelpTableView setDelegate:self];
    [_HelpTableView setDataSource:self];
    [_HelpTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_HelpTableView];
    
    @try {
        _TableViewDataArray = [[NSMutableArray alloc] initWithObjects:@"How it work",@"Planning",@"Booking",@"Contact", nil];
        _TableViewDataImage = [[NSMutableArray alloc] initWithObjects:@"howworks.png",@"planning.png",@"booking.png",@"contact.png", nil];
    }
    @catch (NSException *exception) {
        //NSLog(@"exception ---- %@",exception);
    }
}

#pragma UITableview dataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *TableCell = [[UITableViewCell alloc] init];
    [TableCell.contentView setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [TableCell.imageView setImage:[UIImage imageNamed:[_TableViewDataImage objectAtIndex:indexPath.row]]];
    [TableCell.textLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [TableCell.textLabel setTextColor:[UIColor colorFromHex:0xffffff]];
    [TableCell.textLabel setText:[_TableViewDataArray objectAtIndex:indexPath.row]];
    return TableCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma UITableview Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            HowitWorksViewController *Howitworks = [[HowitWorksViewController alloc] init];
            [self GotoDifferentViewWithAnimation:Howitworks];
        }
        break;
        case 1:
        {
            PlanningViewController *Planning = [[PlanningViewController alloc] init];
            [self GotoDifferentViewWithAnimation:Planning];
        }
        break;
        case 2:
        {
            BookingViewController *Booking = [[BookingViewController alloc] init];
            [self GotoDifferentViewWithAnimation:Booking];
        }
        break;
        case 3:
        {
            ContactViewController *ContactView = [[ContactViewController alloc] init];
            [self GotoDifferentViewWithAnimation:ContactView];
        }
        break;
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
