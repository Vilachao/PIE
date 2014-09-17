//
//  PIEMainHomeViewController.m
//  PIE
//
//  Created by Jose Maria on 12/09/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEMainHomeViewController.h"
#import "PIETabViewController.h"
#import "Constants.h"
#import "PIEutil.h"

@interface PIEMainHomeViewController ()
@property int primeraVez;
@end

@implementation PIEMainHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pie_navigationBarBackground"] forBarMetrics:UIBarMetricsDefault];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tabBarAction1:(id)sender {

        self.primeraVez =0;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
        rootViewController.selectedIndex = 0;
}

- (IBAction)tabBarAction2:(id)sender {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
        rootViewController.selectedIndex = 1;
}

- (IBAction)tabBarAction3:(id)sender {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
        rootViewController.selectedIndex = 2;
}

- (IBAction)tabBarAction4:(id)sender {

        self.primeraVez =0;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
                rootViewController.selectedIndex = 3;
   }

- (IBAction)tabBarAction5:(id)sender {

        self.primeraVez =0;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
                rootViewController.selectedIndex = 4;
  
}


- (IBAction)socialNetworks:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *stringLink = nil;
    NSString *stringSpecialLink = nil;
    if(button.tag == 11){
        stringLink = kRed_Facebook;
        NSArray *split = [stringLink componentsSeparatedByString:@"="];
        stringSpecialLink =[NSString stringWithFormat:@"fb://profile/%@",split[1]];
    }
    if(button.tag == 12){
        stringLink = kRed_Twitter;
        NSArray *split = [stringLink componentsSeparatedByString:@"@"];
        stringSpecialLink =[NSString stringWithFormat:@"twitter://user?screen_name=%@",split[1]];
    }
    if(button.tag == 13){

            [self abrirMail:nil];

      
    }
    if(button.tag == 14){
        stringSpecialLink=nil;
        stringLink = kRed_Web;
    }
    NSURL *url = [NSURL URLWithString:stringLink];
    if(stringSpecialLink!=nil){
        NSURL *urlSpecial = [NSURL URLWithString:stringSpecialLink];
        if ([[UIApplication sharedApplication] canOpenURL:urlSpecial]){
            [[UIApplication sharedApplication] openURL:urlSpecial];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    else {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

-(void)abrirMail:(NSNotification *)notification{
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.delegate=self;
    mailController.mailComposeDelegate = self;
    [mailController setToRecipients:@[kRed_Mail]];
    if ( mailController != nil ) {
        if ([MFMailComposeViewController canSendMail]){
            [self.navigationController presentViewController:mailController animated:YES completion:^{}];
        }
    }
    
}

@end
