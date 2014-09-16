//
//  PIERootAccesibilityViewController.h
//  PIE
//
//  Created by Agustín on 07/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>


@interface PIERootAccesibilityViewController : REFrostedViewController <REFrostedViewControllerDelegate>
- (IBAction)actionHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)actionMenu:(id)sender;
@end
