//
//  PIESculptureViewController.h
//  PIE
//
//  Created by Agustín on 31/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIESculptureViewController : UIViewController <UIGestureRecognizerDelegate>

@property NSString * idCode;
@property (weak, nonatomic) IBOutlet UIView *viewButtons;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewArtist;
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
@property (weak, nonatomic) IBOutlet UIButton *galleryButton;
@property (weak, nonatomic) IBOutlet UIButton *btnCerrar;
@property (weak, nonatomic) IBOutlet UITextView *textViewTituloEscultura;
@property (weak, nonatomic) IBOutlet UITextView *textViewEscultura;
@property (weak, nonatomic) IBOutlet UIImageView *imageObra;
- (IBAction)closeButton:(id)sender;
- (IBAction)audioPlay:(id)sender;
- (IBAction)galleryPlay:(id)sender;
- (IBAction)swipeLeft:(id)sender;
- (IBAction)swipeRight:(id)sender;
- (IBAction)tap:(id)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *botonCerrar;
@property (weak, nonatomic) IBOutlet UIView *viewEscultura;
@property (weak, nonatomic) IBOutlet UIView *viewSideBar;

@end
