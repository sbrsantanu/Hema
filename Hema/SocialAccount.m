//
//  SocialAccount.m
//  Hema
//
//  Created by Mac on 08/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "SocialAccount.h"
#import "AppDelegate.h"
#import "UIColor+HexColor.h"

@interface SocialAccount ()
{
    UIWebView *ContainerWebview;
    UIActivityIndicatorView *Loader;
}

@end

@implementation SocialAccount

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.view.frame = CGRectMake(0, 0, MainDelegate.window.layer.frame.size.width, MainDelegate.window.layer.frame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *CloseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 15, 50, 30)];
        [CloseButton setBackgroundColor:[UIColor colorFromHex:0xffffff]];
        [CloseButton setTitle:@"Close" forState:UIControlStateNormal];
        [CloseButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        [CloseButton.layer setCornerRadius:3.0f];
        [CloseButton.layer setBorderWidth:1.0f];
        [CloseButton.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
        [CloseButton addTarget:self action:@selector(CloseButton) forControlEvents:UIControlEventTouchUpInside];
        [CloseButton setTitleColor:[UIColor colorFromHex:0xe66a4c] forState:UIControlStateNormal];
        [self.view addSubview:CloseButton];
        
        
    }
    return self;
}
-(void)CloseButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)SetAndGateSocialAccountType
{
    
}

-(void)viewDidLoad
{
   [self.view addSubview:[self UIViewSetHeaderView]];
    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    ContainerWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, MainDelegate.window.layer.frame.size.width, MainDelegate.window.layer.frame.size.height-50)];
    [ContainerWebview setDelegate:self];
    
    NSString *url=nil;
   
    if ([mainDelegate SetAndGateSocialAccountType] == 0) {
        url = @"https://twitter.com/santanu1122";
    } else if ([mainDelegate SetAndGateSocialAccountType] == 1) {
        url = @"http://facebook.com/santanu.ece";
    } else if ([mainDelegate SetAndGateSocialAccountType] == 2) {
        url = @"https://www.youtube.com/user/StanfordUniversity";
    } else if ([mainDelegate SetAndGateSocialAccountType] == 3) {
        url = @"https://plus.google.com/u/0/105446359698472218658/about";
    }
    
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [ContainerWebview loadRequest:nsrequest];
    [self.view addSubview:ContainerWebview];
    
    CGRect  mainFrame = [[UIScreen mainScreen] bounds];
    
    Loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGRect frame = Loader.frame;
    frame.origin.x = mainFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = mainFrame.size.height / 2 - frame.size.height / 2;
    Loader.frame = frame;
    [Loader setColor:[UIColor colorFromHex:0xe66a4c]];
    [Loader startAnimating];
    [self.view addSubview:Loader];
}
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [Loader stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [Loader stopAnimating];
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [ContainerWebview loadHTMLString:errorString baseURL:nil];
}


@end
