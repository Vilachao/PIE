//
//  PIENavigationMenuHomeController.m
//  AccionaPie
//
//  Created by Jose Maria on 13/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIENavigationMenuHomeController.h"
#import "PIEHomeViewController.h"
#import "PIEArtistsViewController.h"
#import "PIERootMenuHomeViewController.h"
@interface PIENavigationMenuHomeController ()

@end

@implementation PIENavigationMenuHomeController

- (void)viewDidLoad
{

    // Make it a root controller
    //

    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
 }

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}



@end
