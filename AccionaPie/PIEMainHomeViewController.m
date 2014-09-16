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

@end

@implementation PIEMainHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.hidden = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tabBarAction1:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"action1" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tabBarAction2:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"action2" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tabBarAction3:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"action3" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tabBarAction4:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"action4" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tabBarAction5:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"action5" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"abrirEmail" object:nil];
        [self tabBarAction1:nil];
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
        }
    }
    else {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
@end
