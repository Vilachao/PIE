//
//  PIEQrViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ZBarImageScanner.h"
@interface PIEQrViewController : UIViewController < ZBarReaderDelegate,UIAlertViewDelegate >


@property (weak, nonatomic) IBOutlet UILabel *statusText;
- (IBAction)homeAction:(id)sender;

- (IBAction)home_showMenuRefrosted:(id)sender;
@end
