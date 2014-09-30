//
//  PIEQrViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEQrViewController.h"
#import "PIESculptureViewController.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

@interface PIEQrViewController ()

@property NSString *codeQR;

@property UIImageView *marcadorQR;
@end

@implementation PIEQrViewController

@synthesize zbarReaderView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    zbarReaderView.readerDelegate = self;
    zbarReaderView.tracksSymbols = NO;
    
        // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.marcadorQR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"markerQR"]];
    float x = [[UIScreen mainScreen] bounds].size.width/2 - self.marcadorQR.frame.size.width/2;
    float y = [[UIScreen mainScreen] bounds].size.height/2 - self.marcadorQR.frame.size.height/2;
    self.marcadorQR.frame = CGRectMake(x, y, self.marcadorQR.frame.size.width, self.marcadorQR.frame.size.height);
    [self.navigationController.view addSubview:self.marcadorQR];

    
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(110, 420, 100, 50)];
    if(IS_IPHONE_4){label.frame=CGRectMake(125, 330, 100, 50);
            self.marcadorQR.frame = CGRectMake(x, y-50, self.marcadorQR.frame.size.width, self.marcadorQR.frame.size.height);
    
    }
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    label.text=kQRScan;
    label.textColor=[UIColor whiteColor];
     [self.navigationController.view addSubview:label];
}

-(void)viewDidAppear:(BOOL)animated{

    [zbarReaderView.scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [zbarReaderView start];
}

-(void)viewWillDisappear:(BOOL)animated{
    [zbarReaderView stop];
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    for(ZBarSymbol *sym in symbols){
        self.codeQR = sym.data;
        [self performSegueWithIdentifier:@"sculpture" sender:nil];
        break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sculpture"]) {
        PIESculptureViewController *sculpture = segue.destinationViewController;
        sculpture.idCode = [self.codeQR copy];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end



