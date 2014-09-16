//
//  PIENavigationMenuHomeController.h
//  AccionaPie
//
//  Created by Jose Maria on 13/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>

@interface PIENavigationMenuHomeController : UINavigationController

/**
 *  Acción reconocedora gesto deslizar para abrir el menú Refrosted
 *
 *
 */
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender;

@end
