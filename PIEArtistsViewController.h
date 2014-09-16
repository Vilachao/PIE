//
//  PIEArtistsViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"
#import <REFrostedViewController/REFrostedViewController.h>



@interface PIEArtistsViewController : UIViewController <UINavigationControllerDelegate , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, REFrostedViewControllerDelegate>

@property int primeraVez;
/**
 *  Array de biografia
 */
@property NSArray * arrayOfItems;
@property (weak, nonatomic) IBOutlet UILabel *labelNombreArtista;
@property (weak, nonatomic) IBOutlet UILabel *detalleObra;

/**
 *  Dictionary de artistas y sus obras
 */
@property NSArray *arrayObras;
/**
 *  Dictionary de mini artistas y sus obras
 */
@property NSArray *arrayMiniObras;
/**
 *  Elemento de la barra lateral seleccionado. el id correspone con el orden de la lista
 */
@property (weak, nonatomic) IBOutlet UIView *viewImageLabel;
@property NSInteger idSelectMenu;

@property (weak, nonatomic) IBOutlet UIView *viewNombreLabel;
@property (weak, nonatomic) IBOutlet UITextView *textViewArtist;

@property (weak, nonatomic) IBOutlet UIImageView *obraImageView;

@property (weak, nonatomic) IBOutlet UICollectionView *colectionView;

@property (weak, nonatomic) IBOutlet UIImageView *biografiaImageView;

- (IBAction)home_showMenuRefrosted:(id)sender;

@end
