//
//  PIEQrViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface PIEQrViewController : UIViewController < ZBarReaderViewDelegate,UIAlertViewDelegate >


@property (weak, nonatomic) IBOutlet ZBarReaderView *zbarReaderView;


@end
