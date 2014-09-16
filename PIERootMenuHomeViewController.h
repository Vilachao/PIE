//
//  PIERootMenuHomeViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 13/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>

/**
 *  Importamos la interfaz del pod Refrosted Menu y su controlador
 */

@interface PIERootMenuHomeViewController : REFrostedViewController <UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionMenu;
- (IBAction)actionHome:(id)sender;

- (IBAction)actionMenu:(id)sender;
@end
