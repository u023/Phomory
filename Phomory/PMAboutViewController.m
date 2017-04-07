//
//  PMAboutViewController.m
//  Phomory
//
//  Created by yonglim on 4/6/17.
//  Copyright © 2017 ynk. All rights reserved.
//

#import "PMAboutViewController.h"

@interface PMAboutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

@end

@implementation PMAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)aboutButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
