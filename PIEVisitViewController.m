//
//  PIEVisitViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEVisitViewController.h"
#import "PIEModalViewController.h"
#import "Constants.h"
#import "PIEutil.h"
#import <AFPopupView/AFPopupView.h>
#import <REFrostedViewController/REFrostedViewController.h>

@interface PIEVisitViewController ()

@property (nonatomic, strong) AFPopupView *popup;
@property (nonatomic, strong) PIEModalViewController *modalView;
@property int idSelectAnt;
@property    NSArray *textModals;
@property    NSArray *positions;
@property    UIButton *botonAnteriorSeleccionado;
@end

@implementation PIEVisitViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configurationView];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{

        [self.view endEditing:YES];
     //   [self.frostedViewController.view endEditing:YES];
        self.frostedViewController.delegate=self;
        [self.frostedViewController presentMenuViewController];

}

-(void)viewWillAppear:(BOOL)animated{
    if(self.idSelectMenu==0){ self.viewAntesVisita.hidden = NO; self.viewDespuesVisita.hidden= YES;}
    else   if(self.idSelectMenu==1){ self.viewAntesVisita.hidden = YES; self.viewDespuesVisita.hidden= NO;}

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonAction:(id)sender{
    UIButton * button = (UIButton *)sender;
    NSString *textModal = [self.textModals objectAtIndex:button.tag-10];
    self.modalView.texto = textModal ;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NewText" object:nil];
    _popup = [AFPopupView popupWithView:self.modalView.view];
    [_popup show];
}

-(void)hide {
    [_popup hide];
}




#pragma mark Configuration View

-(void)configurationView{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pie_navigationBarBackground"] forBarMetrics:UIBarMetricsDefault];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:Nil];
    self.modalView = [storyboard instantiateViewControllerWithIdentifier:@"Modal"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HideAFPopup" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide) name:@"HideAFPopup" object:nil];
      self.textModals = @[kVisitaTextoAntes,kVisitaTextoHorario,kVisitaTextoComoLlegar,kVisitaNormasParque,kVisitaQR,kVisitaMapa];
    [self.btnLlegar setTitle:kVisitabotonComoLLegar forState:UIControlStateNormal];
    [self.btnNormas setTitle:kVisitabotonnormas forState:UIControlStateNormal];
    [self.btnPrecios setTitle:kVisitabotonHorario forState:UIControlStateNormal];
    [self.btnUsar setTitle:kVisitabotonUsoQR forState:UIControlStateNormal];
    [self.btnAntes setTitle:kVisitabotonAntes forState:UIControlStateNormal];

    NSArray *titles = @[KvisitaDestinoPrincipal,kVisitaDestino0,kVisitaDestino1,kVisitaDestino2,kVisitaDestino4,kVisitaDestino5,kVisitaDestino6,kVisitaDestino7,kVisitaDestino8,kVisitaDestino9,kVisitaDestino10];

    [self.botonEscultura setTitle:titles[0] forState:UIControlStateNormal];
    for(int i =1; i<11;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        button.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:11] ;
        [button addTarget:self
                   action:@selector(botonEsculturaAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(self.botonEscultura.frame.origin.x, self.botonEscultura.frame.origin.y+22*i, self.botonEscultura.frame.size.width,self.botonEscultura.frame.size.height);
        button.tag = self.botonEscultura.tag+i;
        [button setTitleColor:[UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000] forState:UIControlStateNormal];
        [self.scrollViewButtons addSubview:button];
    }
    
    NSLog(@"%f",self.markImageView.frame.origin.x);
    NSLog(@"%f",self.markImageView.frame.origin.y);
//    self.positions = @[[NSValue valueWithCGPoint:CGPointMake(26, 77)],[NSValue valueWithCGPoint:CGPointMake(39, 77)],[NSValue valueWithCGPoint:CGPointMake(75, 74)],[NSValue valueWithCGPoint:CGPointMake(99, 74)],[NSValue valueWithCGPoint:CGPointMake(117, 70)],[NSValue valueWithCGPoint:CGPointMake(129,69)],[NSValue valueWithCGPoint:CGPointMake(132,73)],[NSValue valueWithCGPoint:CGPointMake(143,70)],[NSValue valueWithCGPoint:CGPointMake(165,72)],[NSValue valueWithCGPoint:CGPointMake(173,72)],[NSValue valueWithCGPoint:CGPointMake(203,72)],[NSValue valueWithCGPoint:CGPointMake(216,72)],[NSValue valueWithCGPoint:CGPointMake(223,71)]];
    self.positions = @[[NSValue valueWithCGPoint:CGPointMake(132, 72)],[NSValue valueWithCGPoint:CGPointMake(24, 77)],[NSValue valueWithCGPoint:CGPointMake(73, 73)],[NSValue valueWithCGPoint:CGPointMake(99, 74)],[NSValue valueWithCGPoint:CGPointMake(128, 69)],[NSValue valueWithCGPoint:CGPointMake(143,71)],[NSValue valueWithCGPoint:CGPointMake(165,72)],[NSValue valueWithCGPoint:CGPointMake(173,72)],[NSValue valueWithCGPoint:CGPointMake(203,72)],[NSValue valueWithCGPoint:CGPointMake(216,72)],[NSValue valueWithCGPoint:CGPointMake(225,71)]];
    
    self.botonEscultura.backgroundColor = [UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000];
    [self.botonEscultura setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.botonAnteriorSeleccionado = self.botonEscultura;
    self.lblRecorrido.text = KVisitaRecorrido;
    self.lblSituacion.text = KVisitaSituacion;
}

-(UIView *)viewSelect:(NSInteger)selectMenu{
    
    switch (selectMenu) {
        case 0:{
            return self.viewAntesVisita;
            break;
        }
        case 1:{
            return self.viewDespuesVisita;
            break;
        }
        default:
            return self.viewAntesVisita;
    }
}

- (IBAction)botonEsculturaAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    button.backgroundColor = [UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.botonAnteriorSeleccionado.backgroundColor = [UIColor clearColor];
    [self.botonAnteriorSeleccionado setTitleColor:[UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000] forState:UIControlStateNormal];
    self.botonAnteriorSeleccionado = button;
    [UIView beginAnimations:@"MoveMark" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3f];
    CGPoint point =   [self.positions[button.tag -100] CGPointValue];
    self.markImageView.frame = CGRectMake(point.x, point.y, self.markImageView.frame.size.width,     self.markImageView.frame.size.height);
    [UIView commitAnimations];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.frostedViewController hideMenuViewController];
}

- (IBAction)home_showMenuRefrosted:(id)sender {
    [self.view endEditing:YES];
  //  [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

@end
