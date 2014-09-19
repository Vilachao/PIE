//
//  PIESculptureViewController.m
//  PIE
//
//  Created by Agustín on 31/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIESculptureViewController.h"
#import "Constants.h"
#import "PIEutil.h"
#import <StreamingKit/STKAudioPlayer.h>
@interface PIESculptureViewController ()
@property NSInteger idEscultura ;
@property NSInteger idArtista ;
@property NSString * nameFolderObraArtista;
@property NSArray * arrayObras;
@property NSArray * arrayAudio;
@property int indiceObra;
@property NSArray *esculturaTextos;
@property NSArray *esculturaTituloTextos;
@property bool sonando;
@property     STKAudioPlayer* audioPlayer;
@end

@implementation PIESculptureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    [self configurationView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sonando = false;
    if(self.audioPlayer==nil)
        self.audioPlayer= [[STKAudioPlayer alloc] init];

    //texto de cada escultura
    self.esculturaTextos= @[KEscultura0Bernet,KEscultura1Canogar,KEscultura2Gonzalez,KEscultura3Cobertera,KEscultura4Lopez,KEscultura5Menendez,KEscultura6Olano,KEscultura7Salvador,KEscultura8Salvador,KEscultura9Salvador];
    //texto de cada escultura
    self.esculturaTituloTextos= @[KEsculturaTitulo0Bernet,KEsculturaTitulo1Canogar,KEsculturaTitulo2Gonzalez,KEsculturaTitulo3Cobertera,KEsculturaTitulo4Lopez,KEsculturaTitulo5Menendez,KEsculturaTitulo6Olano,KEsculturaTitulo7Salvador,KEsculturaTitulo8Salvador,KEsculturaTitulo9Salvador];
    //carpeta de imagenes de las obras
    [self.botonCerrar setTitle:kbotonCerrar];
    // Do any additional setup after loading the view.
    [self.audioButton setBackgroundImage:[UIImage imageNamed:@"sonido"] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self configurationView];
    [[PIEutil sharedInstance] createTextSize:CGRectMake(100, 0, 180,200) scrollViewSize:CGRectMake(5, 0, 320, 200) viewForCore:self.viewEscultura text:self.esculturaTituloTextos[self.idEscultura]];
    [[PIEutil sharedInstance] createTextSize:CGRectMake(0, 0, 180,3000) scrollViewSize:CGRectMake(100, 100, 320, 180) viewForCore:self.viewEscultura text:self.esculturaTextos[self.idEscultura]];

}

-(void)viewWillDisappear:(BOOL)animated{
    [self.audioPlayer stop];
    self.sonando = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -confi view

-(void)configurationView{
    NSArray *components = [self.idCode componentsSeparatedByString:@"."];

    self.indiceObra = 0;
    self.idEscultura = [[components objectAtIndex:0] intValue] - 1;
    self.nameFolderObraArtista = [NSString stringWithFormat:@"%ld",(long)self.idEscultura];
    self.arrayObras = [[NSArray alloc] initWithArray:[PIEutil arrayFilesFolder:@"Esculturas"  :@[self.nameFolderObraArtista]]];
    self.viewButtons.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    self.textViewEscultura.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [self.textViewEscultura setTextColor: [UIColor whiteColor]];
    self.textViewEscultura.selectable = NO;
    self.textViewEscultura.textContainerInset = UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 10.0f);
    self.textViewTituloEscultura.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [self.textViewTituloEscultura setTextColor: [UIColor whiteColor]];
    self.textViewTituloEscultura.selectable = NO;
    self.textViewTituloEscultura.scrollEnabled = YES;
    self.textViewTituloEscultura.textAlignment=NSTextAlignmentJustified;
    self.textViewTituloEscultura.textContainerInset = UIEdgeInsetsMake(5.0f, 5.0f, 10.0f, 0.0f);
    NSString *nameObra = [self.arrayObras objectAtIndex:[self selectImageBackground:self.idEscultura ]];
    self.backgroundImage.image=[PIEutil loadImage:nameObra :@[@"Esculturas",self.nameFolderObraArtista]];
    
    //ARtista imagen
    self.idArtista = [self convierteID:self.idEscultura];
    NSArray *imagesBio = [PIEutil arrayFilesFolder:@"Artistas" :@[@"MiniBiografia"]];
    self.imageViewArtist.image = [PIEutil loadImage:imagesBio[self.idArtista]  :@[@"Artistas",@"MiniBiografia"]];
    self.imageViewArtist.layer.masksToBounds = YES;
    self.imageViewArtist.layer.cornerRadius = 10.0;
}


- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)audioPlay:(id)sender {

    [sender setSelected:YES];

    if(self.sonando){
        [self.audioPlayer stop];
        self.sonando = false;
        [self.audioButton setBackgroundImage:[UIImage imageNamed:@"sonido"] forState:UIControlStateNormal];

    }
    else{
        NSString *audioURL = [NSString stringWithFormat:kAudioURL,self.nameFolderObraArtista];
        [self.audioPlayer play:audioURL];
        self.sonando = true;
        [self.audioButton setBackgroundImage:[UIImage imageNamed:@"sonidoSonando"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)galleryPlay:(id)sender {
    self.indiceObra = 0;
    NSString *nameObra = [self.arrayObras objectAtIndex:self.indiceObra];
    self.imageObra.image=[PIEutil loadImage:nameObra :@[@"Esculturas",self.nameFolderObraArtista]];
    [self.imageObra setHidden:false];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.imageObra.layer addAnimation:animation forKey:nil];
}


#pragma mark - move gesture

- (IBAction)swipeLeft:(id)sender {
    [self forwardAcction];
}

- (IBAction)swipeRight:(id)sender {
    [self backAction];
}

- (IBAction)tap:(id)sender {
    [self.imageObra setHidden:true];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.imageObra.layer addAnimation:animation forKey:nil];
}


-(void)forwardAcction{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.imageObra.layer addAnimation:animation forKey:nil];
    
    if(self.indiceObra<[self.arrayObras count]-1){
        self.indiceObra=self.indiceObra+1;
        NSString *nameObra = [self.arrayObras objectAtIndex:self.indiceObra];
        self.imageObra.image=[PIEutil loadImage:nameObra :@[@"Esculturas",self.nameFolderObraArtista]];
    }
}


-(void)backAction{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.imageObra.layer addAnimation:animation forKey:nil];
    if(self.indiceObra>0){
        self.indiceObra=self.indiceObra-1;
        NSString *nameObra = [self.arrayObras objectAtIndex:self.indiceObra];
        self.imageObra.image=[PIEutil loadImage:nameObra :@[@"Esculturas",self.nameFolderObraArtista]];
    }
}

-(NSInteger)convierteID:(NSInteger )esculturaID{
    if(esculturaID == 7 || esculturaID == 8 || esculturaID == 9){
        return 7;
    }
    return esculturaID;
}

-(NSInteger)selectImageBackground:(NSInteger) idEscultura{
    if(idEscultura ==0) return 3;
    if(idEscultura ==1) return 0;
    if(idEscultura ==2) return 2;
    if(idEscultura ==3) return 2;
    if(idEscultura ==4) return 0;
    if(idEscultura ==5) return 1;
    if(idEscultura ==6) return 5;
    if(idEscultura ==7) return 0;
    if(idEscultura ==8) return 3;
    if(idEscultura ==9) return 0;
    return 0;
}

@end
