//
//  PMAuthViewController.m
//  Phomory
//
//  Created by yonglim on 4/5/17.
//  Copyright © 2017 ynk. All rights reserved.
//

#import "FlickrKit.h"

#import "PMAuthViewController.h"

@interface PMAuthViewController ()
@property (nonatomic, retain) FKDUNetworkOperation *authOp;
@end

// This must be defined in your Info.plist
// Flickr will call this back.  Ensure you configure your flickr app as a web app
NSString *callbackURLString = @"phomory://auth";

@implementation PMAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // This must be defined in your Info.plist
    // Flickr will call this back.  Ensure you configure your flickr app as a web app
    //    NSString *callbackURLString = @"phomory://auth";
    
    // Begin the authentication process
    self.authOp = [[FlickrKit sharedFlickrKit] beginAuthWithCallbackURL:[NSURL URLWithString:callbackURLString] permission:FKPermissionDelete completion:^(NSURL * _Nullable flickrLoginPageURL, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:flickrLoginPageURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
                
                [self.webView loadRequest:urlRequest];
                
            } else {
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //                [alert show];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        });
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.authOp cancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Web View

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // If they click NO DONT AUTHORIZE, this is where it takes you by default... maybe take them to my own site, or show something else
    NSURL *url = [request URL];
    
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            return NO;
        }
    }
    
    return YES;
}

@end
