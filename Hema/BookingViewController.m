//
//  BookingViewController.m
//  Hema
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "BookingViewController.h"
#import "HelpViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "UIColor+HexColor.h"
#import "MPApplicationGlobalConstants.h"

@interface BookingViewController ()
@property (nonatomic,retain) NSArray     * DataValueArray;
@property (nonatomic,retain) UIActivityIndicatorView *MainActivity;
@end

@implementation BookingViewController

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
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Help"]];
    
    self.DataValueArray = [[NSArray alloc] initWithObjects:@"6", nil];
    
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    _MainActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect frame = _MainActivity.frame;
    frame.origin.x = mainFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = mainFrame.size.height / 2 - frame.size.height / 2;
    _MainActivity.frame = frame;
    [_MainActivity setColor:[UIColor colorFromHex:0xe66a4c]];
    [_MainActivity startAnimating];
    [_MainActivity hidesWhenStopped];
    [self.view addSubview:_MainActivity];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self CallWebserviceForData];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma webservice delegate return methods

-(void)CallWebserviceForData
{
    if (!IS_NETWORK_AVAILABLE())
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            SHOW_NETWORK_ERROR_ALERT();
        });
        
    } else {
        
        CGRect mainFrame = [[UIScreen mainScreen] bounds];
        
        NSURL *ParamObjectURL = [[NSURL alloc] initWithString:@"http://myphpdevelopers.com/dev/hema/app/webroot/hema/pages.php?page_id=6"];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            NSData * data = [[NSData alloc] initWithContentsOfURL: ParamObjectURL];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_MainActivity stopAnimating];
                
                NSString *ReturnedObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"ReturnedObject=====%@",ReturnedObject);
                
                NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body style=\"background:transparent;\">"];
                
                //continue building the string
                [html appendString:ReturnedObject];
                [html appendString:@"</body></html>"];
                
                //instantiate the web view
                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, mainFrame.size.width, mainFrame.size.height-165)];
                
                //make the background transparent
                [webView setBackgroundColor:[UIColor clearColor]];
                
                //pass the string to the webview
                [webView loadHTMLString:[html description] baseURL:nil];
                
                //add it to the subview
                [self.view addSubview:webView];
                
            });
        });
    }
}

@end
