//
//  PIEAccessibilityViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>
typedef enum ShowViewAccess : NSUInteger {
    kNino,
    kDisabledInfo,
} ShowViewAccess;


@interface PIEAccessibilityViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, REFrostedViewControllerDelegate>
@property int primeraVez;
/**
 *  Elemento de la barra lateral seleccionado. el id correspone con el orden de la lista
 */
@property NSInteger idSelectMenu;

@property (weak, nonatomic) IBOutlet UIView *accesibilityView;

@property (weak, nonatomic) IBOutlet UITextView *textViewAccesibility;

@property (weak, nonatomic) IBOutlet UISegmentedControl *accessibility_segmentedButtonLevel;

@property (weak, nonatomic) IBOutlet UIButton *accessibility_buttonRestart;

@property (weak, nonatomic) IBOutlet UICollectionView *accessibility_collectionViewImages;

- (IBAction)accessibility_actionChangeLevel:(id)sender;

- (IBAction)accessibility_actionRestartGame:(id)sender;

- (IBAction)home_showMenuRefrosted:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonReiniciar;

@end
