//
//  PMSettingsViewController.h
//  Phomory
//
//  Created by yonglim on 4/5/17.
//  Copyright © 2017 ynk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMSettingsViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *photostreamButton;
@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UILabel *authLabel;
@property (weak, nonatomic) IBOutlet UILabel *todaysInterestingLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;

- (IBAction)authButtonPressed:(id)sender;
- (IBAction)loadTodaysInterestingPressed:(id)sender;
- (IBAction)photostreamButtonPressed:(id)sender;
- (IBAction)choosePhotoPressed:(id)sender;
- (IBAction)searchErrorPressed:(id)sender;
- (IBAction)searchPressed:(id)sender;

@end
