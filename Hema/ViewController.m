//
//  ViewController.m
//  Hema
//
//  Created by Mac on 03/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UIColor+HexColor.h"

@interface ViewController ()
{
    CGRect mainFrame;
}
@property (nonatomic,retain) UIActivityIndicatorView *MainActivity;
@property (nonatomic,retain) NSTimer *DataTimer;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    GlobalObjects *MainObject = [[GlobalObjects alloc] init];
    
    [self.view addSubview:[MainObject UIViewSetHeaderView]];
    [self.view addSubview:[MainObject UIViewSetFooterView]];
    
    _MainActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect frame = _MainActivity.frame;
    frame.origin.x = mainFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = mainFrame.size.height / 2 - frame.size.height / 2;
    _MainActivity.frame = frame;
    [_MainActivity setColor:[UIColor colorFromHex:0xe66a4c]];
    [_MainActivity startAnimating];
    [self.view addSubview:_MainActivity];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(GoTodifferentPage)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)GoTodifferentPage
{
    HomeViewController *HomeView = [[HomeViewController alloc] init];
    [self GotoDifferentViewWithAnimation:HomeView];
}

@end
