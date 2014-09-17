//
//  PIEHomeViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import <FTCoreTextView.h>
#import <FTCoreTextStyle.h>
/**
 
 Se usa para identificar la vista que se ha de mostrar
 
 */

typedef enum ShowViewHome : NSUInteger {
    kAyuntamiento,
    kCreditos,
    kHome
} ShowViewHome;

@interface PIEHomeViewController : UIViewController <UINavigationControllerDelegate , MFMailComposeViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, REFrostedViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property int menuHome;
@property (weak, nonatomic) IBOutlet UIView *ayuntamientoView;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UIImageView *imageFullGalleryCollection;

@property (weak, nonatomic) IBOutlet UIView *queesView;
@property (weak, nonatomic) IBOutlet UIView *viewNSG;

@property (weak, nonatomic) IBOutlet UIView *creditosView;
@property (weak, nonatomic) IBOutlet UITextView *textViewQueEs;
@property (weak, nonatomic) IBOutlet UITextView *textViewAyuntamiento;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewImages;
@property (nonatomic)  UIScrollView *creditosScroll;
@property (nonatomic)  UIScrollView *queesScroll;
@property (nonatomic)  UIScrollView *ayuntamientoScroll;

@property (nonatomic, strong) FTCoreTextView *coreTextView;
@property (nonatomic, strong) FTCoreTextView *coreQueesTextView;
@property (nonatomic, strong) FTCoreTextView *coreAyuntamientoTextView;

@property (weak, nonatomic) IBOutlet UILabel *lblTextoMenu;

/**
 *  Text field para el texto de la pantalla home
 */
@property (weak, nonatomic) IBOutlet UITextView *home_textFieldIntro;
/**
 *  Botón para cargar el menu lateral Refrosted
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *home_barButtonItemIntro;

/**
 *  Elemento de la barra lateral seleccionado. el id correspone con el orden de la lista
 */
@property NSInteger idSelectMenu;

/**
 *  Elemento de la barra lateral seleccionado. el id correspone con el orden de la lista
 */
@property NSInteger idSelectAnt;
/**
 *  Acción para cargar el menú lateral Refrosted al pulsar el botón
 */

- (IBAction)home_showMenuRefrosted:(id)sender;

- (IBAction)socialNetworks:(id)sender;

@end
