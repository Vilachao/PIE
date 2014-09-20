//
//  PIEModalViewController.m
//  PIE
//
//  Created by Agustín on 07/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//
#import "Constants.h"
#import "PIEModalViewController.h"

@interface PIEModalViewController ()

@end

@implementation PIEModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 10, 240,1100) scrollViewSize:CGRectMake(0, 50, 320, 425) viewForCore:self.modalView text:self.texto];

//.text setTextColor: [UIColor whiteColor]];
//    self.textViewInfo.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    self.textViewInfo.selectable = NO;
//    self.textViewInfo.text = self.texto;
    [self.close setTitle:kbotonCerrar forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NewText" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(texto:) name:@"NewText" object:nil];

    // Do any additional setup after loading the view.
}

-(void)texto:(NSNotification *)notification{
    self.text.text = self.texto;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)close:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HideAFPopup" object:nil];
}
@end
