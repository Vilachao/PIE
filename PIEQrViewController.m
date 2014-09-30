//
//  PIEQrViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEQrViewController.h"
#import "PIESculptureViewController.h"
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
        // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.marcadorQR = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"markerQR"]];
    float x = [[UIScreen mainScreen] bounds].size.width/2 - self.marcadorQR.frame.size.width/2;
    float y = [[UIScreen mainScreen] bounds].size.height/2 - self.marcadorQR.frame.size.height/2;
    self.marcadorQR.frame = CGRectMake(x, y, self.marcadorQR.frame.size.width, self.marcadorQR.frame.size.height);
    [self.navigationController.view addSubview:self.marcadorQR];

    
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(125, 420, 100, 50)];
    if(IS_IPHONE_4){label.frame=CGRectMake(125, 330, 100, 50);
            self.marcadorQR.frame = CGRectMake(x, y-50, self.marcadorQR.frame.size.width, self.marcadorQR.frame.size.height);
    
    }
    label.text=@"Scanning...";
    label.textColor=[UIColor whiteColor];
     [self.navigationController.view addSubview:label];
}

-(void)viewDidAppear:(BOOL)animated{
    [zbarReaderView start];
}

-(void)viewWillDisappear:(BOOL)animated{
    [zbarReaderView stop];
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    for(ZBarSymbol *sym in symbols){
        self.codeQR = sym.data;
        [self performSegueWithIdentifier:@"sculpture" sender:nil];
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
/**
-(void)viewDidAppear:(BOOL)animated{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [self presentViewController:reader animated:NO completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DELEGATE QR
/*
- (void)didScanCode:(NSString *)scannedCode onCodeType:(NSString *)codeType {
    
    self.codeQR = scannedCode;
    [self performSegueWithIdentifier:@"sculpture" sender:nil];
}

- (void)errorGeneratingCaptureSession:(NSError *)error {
    [scannerView stopCaptureSession];
#warning poner texto en el properti
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsupported Device" message:@"This device does not have a camera. Run this app on an iOS device that has a camera." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
}

- (void)errorAcquiringDeviceHardwareLock:(NSError *)error {
#warning poner texto en el properti
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Focus Unavailable" message:@"Tap to focus is currently unavailable. Try again in a little while." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)shouldEndSessionAfterFirstSuccessfulScan {
    // Return YES to only scan one barcode, and then finish - return NO to continually scan.
    // If you plan to test the return NO functionality, it is recommended that you remove the alert view from the "didScanCode:" delegate method implementation
    // The Display Code Outline only works if this method returns NO
    return YES;
}



- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    [reader dismissViewControllerAnimated:NO completion:nil];
    
    self.codeQR = symbol.data;
    //[self performSegueWithIdentifier:@"sculpture" sender:nil];
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

- (IBAction)homeAction:(id)sender {
    self.tabBarController.selectedIndex = 0;
}
**/
@end



