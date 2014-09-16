//
//  PIERootAccesibilityViewController.m
//  PIE
//
//  Created by Agustín on 07/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIERootAccesibilityViewController.h"
#import "PIEAccessibilityViewController.h"
#import "Constants.h"
#import "PIEutil.h"
#import "PIEMainHomeViewController.h"
@interface PIERootAccesibilityViewController ()

@end

@implementation PIERootAccesibilityViewController
- (void)awakeFromNib
{
    
    self.liveBlur=false;
    self.backgroundFadeAmount=0.2;
    self.blurRadius=4.0;
    self.blurTintColor=[UIColor colorWithWhite:0.204 alpha:0.750];
    self.menuViewSize=CGSizeMake(150, 1034);
    
    //Navigation Controller
    //MenuController
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"accesible"];
    
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
    PIEAccessibilityViewController* pieAcceso = (PIEAccessibilityViewController *)self.contentViewController;
    [pieAcceso.frostedViewController presentMenuViewController];

}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer{
    //    if([recognizer locationInView:self.view].y > [[UIScreen mainScreen] bounds].size.height*1/2 )
    //    {
    //        self.frostedViewController.panGestureEnabled = false;
    //    }
    //    else{
    //        self.frostedViewController.panGestureEnabled = true;
    //    }
    NSLog(@"SDFSDFSADFSAFD");
}


@end
