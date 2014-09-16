//
//  PIETabViewController.m
//  PIE
//
//  Created by Agustín on 30/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIETabViewController.h"
#import "Constants.h"

@interface PIETabViewController ()

@end

@implementation PIETabViewController

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
    UIImage *tabBarBackground = [UIImage imageNamed:@"tabBar_backGround"];
    
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    

    UITabBar *tabBar = self.tabBar;
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self editTabBar:tabBar
                    :0
                    :kTabBar_inicio
                    :@"tabBar_homeButton"
                    :@"tabBar_homeButtonUnSelected" ];
    [self editTabBar:tabBar
                    :1
                    :kTabBar_artista
                    :@"tabBar_artistButton"
                    :@"tabBar_artistButtonUnSelected" ];
    [self editTabBar:tabBar
                    :2
                    :kTabBar_visita
                    :@"tabBar_visitButton"
                    :@"tabBar_visitButtonUnSelected" ];
    [self editTabBar:tabBar
                    :3
                    :kTabBar_accesibilidad
                    :@"tabBar_accessibilitySelected"
                    :@"tabBar_accessibilityUnSelected" ];
    [self editTabBar:tabBar
                    :4
                    :kTabBar_qr
                    :@"tabBar_QRbutton"
                    :@"tabBar_QRbuttonUnSelected" ];
    
         
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica Neue" size:8.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    

    // Do any additional setup after loading the view.
}

/**
 *  Edit tabbar
 *
 *  @param tabBar        tabbar
 *  @param index         element
 *  @param title         title tabbar
 *  @param imageSelected image when selected tab
 *  @param image         image unselected tab
 */
-(void)editTabBar:(UITabBar *)tabBar  :(int)index :(NSString *)title :(NSString *)imageSelected :(NSString *)image{
    UITabBarItem *result = [tabBar.items objectAtIndex:index];
    [result setTitle:title];
    [result setSelectedImage:[[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [result setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    result.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    result.titlePositionAdjustment= UIOffsetMake(0.0, -4.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
