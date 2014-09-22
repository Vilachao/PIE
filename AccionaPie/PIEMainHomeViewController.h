//
//  PIEMainHomeViewController.h
//  PIE
//
//  Created by Jose Maria on 12/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface PIEMainHomeViewController : UIViewController <UINavigationControllerDelegate,MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *tabBar1;
@property (weak, nonatomic) IBOutlet UIButton *tabBar2;
@property (weak, nonatomic) IBOutlet UIButton *tabBar3;
@property (weak, nonatomic) IBOutlet UIButton *tabBar4;
@property (weak, nonatomic) IBOutlet UIButton *tabBar5;
- (IBAction)tabBarAction1:(id)sender;
- (IBAction)tabBarAction2:(id)sender;
- (IBAction)tabBarAction3:(id)sender;
- (IBAction)tabBarAction4:(id)sender;
- (IBAction)tabBarAction5:(id)sender;
- (IBAction)socialNetworks:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tabBarView;


@end
