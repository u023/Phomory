//
//  PMFirstRunViewController.m
//  Phomory
//
//  Created by yonglim on 4/5/17.
//  Copyright © 2017 ynk. All rights reserved.
//

#import "FlickrKit.h"

#import "PMFirstRunViewController.h"
#import "PMTodaysInterestViewController.h"
#import "PMSettingsViewController.h"

@interface PMFirstRunViewController ()

@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (nonatomic, retain) NSString *userID;

@end

@implementation PMFirstRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticationCallback:) name:@"UserAuthCallbackNotification" object:nil];
    
    // Check if there is a stored token
    // You should do this once on app launch
    self.checkAuthOp = [[FlickrKit sharedFlickrKit] checkAuthorizationOnCompletion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
                [self performSegueWithIdentifier:@"SegueToMain" sender:self];
            } else {
                [self userLoggedOut];
            }
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = NO;
    
    [self.checkAuthOp cancel];
    [self.completeAuthOp cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Auth

- (void)userAuthenticationCallback:(NSNotification *)notification
{
    //TODO: need to figure out why we want to call this...?
    NSURL *callbackURL = notification.object;
    
    self.completeAuthOp = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString * _Nullable userName, NSString * _Nullable userId, NSString * _Nullable fullName, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
                [self performSegueWithIdentifier:@"SegueToMain" sender:self];
            } else {
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

- (void)userLoggedIn:(NSString *)username userID:(NSString *)userID
{
    self.userID = userID;
    [self.signInButton setTitle:@"Logout" forState:UIControlStateNormal];
    self.signInLabel.text = [NSString stringWithFormat:@"You are logged in as %@", username];
}

- (void)userLoggedOut
{
    [self.signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    self.signInLabel.text = @"Save all your photos on cloud and never lose again.";
}

- (IBAction)signInButtonPressed:(id)sender
{
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
        [[FlickrKit sharedFlickrKit] logout];
        [self userLoggedOut];
    } else {
        [self performSegueWithIdentifier:@"SegueToAuth" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //    if ([segue.identifier isEqualToString:@"SegueToMainPage"]) {
    //        ViewController *mainView = [segue destinationViewController];
    ////    } else if ([segue.identifier isEqualToString:@"SegueToMyPhotos"]) {
    //////        MyPhotosViewController *myPhotosView = [segue destinationViewController];
    //////        myPhotosView.myPhotoURLs = _myPhotoURLs;
    ////    } else if ([segue.identifier isEqualToString:@"SegueToUploadView"]) {
    ////        //PBPhotoUploadViewController *uploadView = [segue destinationViewController];
    //    }
}

@end
