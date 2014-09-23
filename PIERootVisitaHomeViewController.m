//
//  PIERootVisitaHomeViewController.m
//  PIE
//
//  Created by Agustín on 07/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIERootVisitaHomeViewController.h"
#import "PIEVisitViewController.h"
#import "Constants.h"
#import "PIEutil.h"
#import "PIEMainHomeViewController.h"
#import "PIEAppDelegate.h"

@interface PIERootVisitaHomeViewController ()

@end

@implementation PIERootVisitaHomeViewController

- (void)awakeFromNib
{
    
    self.liveBlur=false;
    self.backgroundFadeAmount=0.2;
    self.blurRadius=4.0;
    self.blurTintColor=[UIColor colorWithWhite:0.204 alpha:0.750];
    self.menuViewSize=CGSizeMake(150, 1034);
    
    
    //Navigation Controller
    //MenuController
    PIEAppDelegate * appDel = (PIEAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.menuViewController = [appDel.storyBoard instantiateViewControllerWithIdentifier:@"menuController"];
    self.contentViewController = [appDel.storyBoard instantiateViewControllerWithIdentifier:@"contentControllerVisit"];
   
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
        [self.menuButton setTitle:kmenuInicial forState:UIControlStateNormal];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pie_navigationBarBackground"] forBarMetrics:UIBarMetricsDefault];
}



- (IBAction)actionHome:(id)sender{
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    //the detail controller
    PIEMainHomeViewController *myNewVC = [storyboard
                                          instantiateViewControllerWithIdentifier:@"PIEMainHomeViewController"];
    
    myNewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:myNewVC animated:YES completion:nil];

}

- (IBAction)actionMenu:(id)sender{
    PIEVisitViewController* pieAcceso = (PIEVisitViewController *)self.contentViewController;
    [pieAcceso.frostedViewController presentMenuViewController];

}

@end
