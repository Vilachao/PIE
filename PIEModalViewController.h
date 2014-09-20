//
//  PIEModalViewController.h
//  PIE
//
//  Created by Agustín on 07/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FTCoreTextView.h>
#import <FTCoreTextStyle.h>
#import "PIEutil.h"

@interface PIEModalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textViewInfo;
@property FTCoreTextView *text;
@property NSString * texto;

-(IBAction)close:(id)sender ;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIView *modalView;


@end
