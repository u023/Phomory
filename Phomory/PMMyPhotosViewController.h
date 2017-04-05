//
//  PMMyPhotosViewController.h
//  Phomory
//
//  Created by yonglim on 4/5/17.
//  Copyright © 2017 ynk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMMyPhotosViewController : UIViewController
- (id)initWithURLArray:(NSMutableArray *)urlArray;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
//@property (nonatomic, retain) NSArray *myPhotoURLs;
@end
