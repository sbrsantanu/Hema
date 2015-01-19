//
//  ApplyBookingViewController.m
//  Hema
//
//  Created by Mac on 31/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "ApplyBookingViewController.h"

@interface ApplyBookingViewController ()

@end

@implementation ApplyBookingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"ApplyBookingViewController" bundle:nil]:[super initWithNibName:@"ApplyBookingViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
