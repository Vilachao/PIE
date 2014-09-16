//
//  PIEQrViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMScannerView.h"

@interface PIEQrViewController : UIViewController <RMScannerViewDelegate>
@property (strong, nonatomic) IBOutlet RMScannerView *scannerView;

@property (weak, nonatomic) IBOutlet UILabel *statusText;
- (IBAction)homeAction:(id)sender;

- (IBAction)home_showMenuRefrosted:(id)sender;
@end
