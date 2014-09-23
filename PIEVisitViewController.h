//
//  PIEVisitViewController.h
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController/REFrostedViewController.h>

typedef enum ShowViewVisit : NSUInteger {
    kAntes,
    kDespues,
} ShowViewVisit;

@interface PIEVisitViewController : UIViewController <REFrostedViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblSituacion;
@property (weak, nonatomic) IBOutlet UILabel *lblRecorrido;
@property int primeraVez;
/**
 *  Elemento de la barra lateral seleccionado. el id correspone con el orden de la lista
 */
@property NSInteger idSelectMenu;
@property (weak, nonatomic) IBOutlet UIView *viewDespuesVisita;
@property (weak, nonatomic) IBOutlet UIView *viewAntesVisita;

//VIsta antes
@property (weak, nonatomic) IBOutlet UIButton *btnPrecios;
@property (weak, nonatomic) IBOutlet UIButton *btnLlegar;
@property (weak, nonatomic) IBOutlet UIButton *btnNormas;
@property (weak, nonatomic) IBOutlet UIButton *btnUsar;
@property (weak, nonatomic) IBOutlet UIButton *btnAntes;

-(IBAction)buttonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UIButton *botonEscultura;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewButtons;

- (IBAction)home_showMenuRefrosted:(id)sender;
//VIsta despues
@property (weak, nonatomic) IBOutlet UIButton *btnMasInformacion;


@end
