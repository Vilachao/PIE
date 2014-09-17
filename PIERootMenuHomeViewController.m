//
//  PIERootMenuHomeViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 13/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIERootMenuHomeViewController.h"
#import "PIEHomeViewController.h"
#import "Constants.h"
#import "PIEutil.h"
#import "PIEMainHomeViewController.h"

@interface PIERootMenuHomeViewController ()

@end

@implementation PIERootMenuHomeViewController


/**
 *  Cargamos los outlets con las vistas de nuestro StoryBoard que necesita el RefrostedMenu, es decir, el navigation (content) y la tabla (menu)
 
    Aquí definimos las propiedades generales del menú Refrosted tales como el color del fondo, transparencia y otras propiedades
 
 */

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
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];

}

-(void)viewDidLoad{
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pie_navigationBarBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.menuButton setTitle:kmenuInicial forState:UIControlStateNormal];
    
}


- (IBAction)actionHome:(id)sender{
//    UIStoryboard *storyboard = self.navigationController.storyboard;
//    
//    //the detail controller
//    PIEMainHomeViewController *myNewVC = [storyboard
//                                          instantiateViewControllerWithIdentifier:@"PIEMainHomeViewController"];
//    
//    myNewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self.navigationController presentViewController:myNewVC animated:YES completion:nil];
//
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"navigationHome"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];

}

- (IBAction)actionMenu:(id)sender{
        PIEHomeViewController* pieAcceso = (PIEHomeViewController *)self.contentViewController;
        [pieAcceso.frostedViewController presentMenuViewController];
    }




@end
