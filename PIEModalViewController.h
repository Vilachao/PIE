//
//  PIEModalViewController.h
//  PIE
//
//  Created by Agustín on 07/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIEModalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textViewInfo;

@property NSString * texto;

-(IBAction)close:(id)sender ;
@property (weak, nonatomic) IBOutlet UIButton *close;


@end
