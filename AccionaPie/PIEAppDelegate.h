//
//  PIEAppDelegate.h
//  AccionaPie
//
//  Created by Jose Maria on 11/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property     UIStoryboard *storyBoard;
- (NSURL *)applicationDocumentsDirectory;

@end
