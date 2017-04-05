//
//  PMCameraViewController.h
//  Phomory
//
//  Created by yonglim on 4/5/17.
//  Copyright © 2017 ynk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMCameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIImageView *uploadingImageView;

@end
