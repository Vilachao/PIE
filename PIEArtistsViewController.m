//
//  PIEArtistsViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEArtistsViewController.h"
#import "PIEArtistsCollectionViewCell.h"

#import "PIEutil.h"
#import "Constants.h"

@interface PIEArtistsViewController ()


@property   NSString *imageName;

@property   int indice;
/**
 *  Esto es una chapuza!! el frosteddelegate se llama dos veces en vez de una, entonces uso un contador para controlar que a la segunda se ejecute. Con tiempo mirar porque ocurre esto y arreglarlo.
 */

@property   int controlDelegatePan;
@property   NSString *nameFolderObraArtista;
@property NSMutableDictionary *artistasObra;
@property  (strong)  MPMoviePlayerController* moviePlayer;


@end

@implementation PIEArtistsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.controlDelegatePan = 0;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pie_navigationBarBackground"] forBarMetrics:UIBarMetricsDefault];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.colectionView setCollectionViewLayout:flowLayout];
    [self cofigurationView];
    self.moviePlayer=[[MPMoviePlayerController alloc] init];
    self.moviePlayer.view.transform = CGAffineTransformConcat(self.moviePlayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
}



-(void)viewWillAppear:(BOOL)animated{
    [self.colectionView reloadData];
    
    NSArray *imagesBio = [PIEutil arrayFilesFolder:@"Artistas" :@[@"MiniBiografia"]];
    self.biografiaImageView.image = [PIEutil loadImage:imagesBio[self.idSelectMenu] :@[@"Artistas",@"MiniBiografia"]];

    self.nameFolderObraArtista = [NSString stringWithFormat:@"%ld",(long)self.idSelectMenu];
    self.arrayObras = [[NSArray alloc] initWithArray:[PIEutil arrayFilesFolder:@"Artistas"  :@[self.nameFolderObraArtista]]];
    self.arrayMiniObras = [[NSArray alloc] initWithArray:[PIEutil arrayFilesFolder:@"MiniArtistas"  :@[self.nameFolderObraArtista]]];
    
    NSArray *sortedArrayOfString = [self.arrayObras sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2 options:NSNumericSearch];
    }];
    self.arrayObras=sortedArrayOfString;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.view endEditing:YES];
   // [self.frostedViewController.view endEditing:YES];
    self.frostedViewController.delegate=self;
    [self.frostedViewController presentMenuViewController];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.frostedViewController hideMenuViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.arrayMiniObras count];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PIEArtistsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCellArtists" forIndexPath:indexPath];
    NSString *nameObra = [self.arrayMiniObras objectAtIndex:indexPath.row];
    cell.artists_imageViewCell.image=[PIEutil loadImage:nameObra :@[@"MiniArtistas",self.nameFolderObraArtista]];
    cell.artists_imageViewCell.layer.masksToBounds = YES;
    cell.artists_imageViewCell.layer.cornerRadius = 10.0;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger width = 60;
    CGSize cellSize = CGSizeMake(width, width);
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 20, 5, 20); // top, left, bottom, right
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.indice =(int)indexPath.row;
    if((int)self.idSelectMenu == 0){//artista 0
        self.indice =(int)indexPath.row -2;
        if(indexPath.row==0||indexPath.row==1){//pulso en video (posicion 0 , 1 )
            self.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
            NSString *videoURL = [NSString stringWithFormat:kVideoURL,self.nameFolderObraArtista];
            [self.moviePlayer setContentURL:[NSURL URLWithString:videoURL]];

            UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
            [self.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
            [self.moviePlayer.view setFrame:backgroundWindow.frame];
            [backgroundWindow addSubview:self.moviePlayer.view];
            [self.moviePlayer prepareToPlay];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackComplete:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
            [self.moviePlayer play];

            return;
        }
    }
    self.frostedViewController.panGestureEnabled = NO;
    NSString *nameObra = [self.arrayObras objectAtIndex:self.indice];
    self.obraImageView.image=[PIEutil loadImage:nameObra :@[@"Artistas",self.nameFolderObraArtista]];
    self.viewImageLabel.hidden = NO;
    [self.obraImageView setHidden:false];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.obraImageView.layer addAnimation:animation forKey:nil];
    [self.viewImageLabel.layer  addAnimation:animation forKey:nil];
    self.detalleObra.text = [self getTituloObra:(int)self.idSelectMenu :self.indice];
}

-(void)forwardAcction{
    self.controlDelegatePan ++;
    if(self.controlDelegatePan == 2){
        self.controlDelegatePan = 0;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.8;
        [self.obraImageView.layer addAnimation:animation forKey:nil];

        if(self.indice<[self.arrayObras count]-1){
            self.indice=self.indice+1;
            NSString *nameObra = [self.arrayObras objectAtIndex:self.indice];
            self.obraImageView.image=[PIEutil loadImage:nameObra :@[@"Artistas",self.nameFolderObraArtista]];
        }
    }
    self.detalleObra.text = [self getTituloObra:(int)self.idSelectMenu :(int)self.indice];
}


-(void)backAction{
    self.controlDelegatePan ++;
    if(self.controlDelegatePan == 2){
        self.controlDelegatePan = 0;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.8;
        [self.obraImageView.layer addAnimation:animation forKey:nil];
        
        if(self.indice>0){
            self.indice= self.indice-1;
            NSString *nameObra = [self.arrayObras objectAtIndex:self.indice];
            self.obraImageView.image=[PIEutil loadImage:nameObra :@[@"Artistas",self.nameFolderObraArtista]];
        }
    }
    self.detalleObra.text = [self getTituloObra:(int)self.idSelectMenu :(int)self.indice];
}


-(void)cofigurationView{
    self.frostedViewController.delegate=self;
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.obraImageView setHidden:true];
    [self configureGesture];
    self.viewImageLabel.hidden = YES;
    self.biografiaImageView.layer.masksToBounds = YES;
    self.biografiaImageView.layer.cornerRadius = 10.0;
    [self crearDiccionarioArtistasObras];
    [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 40, 160, 300) scrollViewSize:CGRectMake(0, 0, 200, 300) viewForCore:self.viewArtist text:[self nameArtist:(int)self.idSelectMenu]];
    
    [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 0, 240, 3000) scrollViewSize:CGRectMake(0, 110, 280, 220) viewForCore:self.viewArtist text:[self textArtist:(int)self.idSelectMenu]];
}

#pragma mark -select menu

-(NSString *)textArtist:(int)idSelectMenu{
    switch (idSelectMenu) {
        case 0:
            return kpie_artista0;
            break;
        case 1:
            return kpie_artista1;
            break;
        case 2:
            return kpie_artista2;
            break;
        case 3:
            return kpie_artista3;
            break;
        case 4:
            return kpie_artista4;
            break;
        case 5:
            return kpie_artista5;
            break;
        case 6:
            return kpie_artista6;
            break;
        case 7:
            return kpie_artista7;
            break;
        case 8:
            return kpie_artista8;
            break;
        case 9:
            return kpie_artista9;
            break;
        default:
            break;
    }
    return @"";
}

-(NSString *)nameArtist:(int)idSelectMenu{
    switch (idSelectMenu) {
        case 0:
            return knombrepie_artista0;
            break;
        case 1:
            return knombrepie_artista1;
            break;
        case 2:
            return knombrepie_artista2;
            break;
        case 3:
            return knombrepie_artista3;
            break;
        case 4:
            return knombrepie_artista4;
            break;
        case 5:
            return knombrepie_artista5;
            break;
        case 6:
            return knombrepie_artista6;
            break;
        case 7:
            return knombrepie_artista7;
            break;
        default:
            break;
    }
    return @"";
}

-(void)configureGesture{
    
    
    self.obraImageView.tag = 100;
    // by the way, if not using ARC, make sure to add `autorelease` to
    // the following alloc/init statements
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.obraImageView addGestureRecognizer:tap];
}

-(void)handleTap:(UITapGestureRecognizer *)gesture{
    self.frostedViewController.panGestureEnabled = YES;
    [self.obraImageView setHidden:true];
    self.viewImageLabel.hidden = YES;
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.obraImageView.layer addAnimation:animation forKey:nil];
    
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer{
    if([recognizer locationInView:self.view].y > [[UIScreen mainScreen] bounds].size.height*1/2 )
    {
        self.frostedViewController.panGestureEnabled = false;
    }
    else{
        self.frostedViewController.panGestureEnabled = true;
    }
    
    if(self.obraImageView.hidden == NO)
    {
        self.frostedViewController.panGestureEnabled = NO;
        if ((recognizer.state == UIGestureRecognizerStateEnded))
        {
            CGPoint velocity = [recognizer velocityInView:self.view];
            if (velocity.x <0)   // panning down
            {
                [self forwardAcction];
            }
            else if(velocity.x >0)      // panning up
            {
                [self backAction];
            }
            self.frostedViewController.panGestureEnabled = YES;
        }
        
    }
}

- (IBAction)home_showMenuRefrosted:(id)sender {
    [self.view endEditing:YES];
  //  [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

-(void)showBackgroundImage:(BOOL)show{
    if(show){
        self.viewArtist.hidden = YES;
    }else{
        self.viewArtist.hidden = NO;
    }
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [self.viewArtist.layer addAnimation:animation forKey:nil];
}

-(void)hideBackgroundImage:(BOOL)hide{
    if(hide){
        self.biografiaImageView.hidden = YES;
    }else{
        self.biografiaImageView.hidden = NO;
    }
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.biografiaImageView.layer addAnimation:animation forKey:nil];
}


#pragma mark -diccionario artistas obras

-(void)crearDiccionarioArtistasObras{
    self.artistasObra = [[NSMutableDictionary alloc] init];
    [self.artistasObra setValue:@[kpie_obra_artista0_0, kpie_obra_artista0_1,kpie_obra_artista0_2,kpie_obra_artista0_3,kpie_obra_artista0_4, kpie_obra_artista0_5, kpie_obra_artista0_6] forKey:@"artista0"];
        [self.artistasObra setValue:@[kpie_obra_artista1_0, kpie_obra_artista1_1,kpie_obra_artista1_2,kpie_obra_artista1_3,kpie_obra_artista1_4, kpie_obra_artista1_5, kpie_obra_artista1_6] forKey:@"artista1"];
            [self.artistasObra setValue:@[kpie_obra_artista2_0, kpie_obra_artista2_1,kpie_obra_artista2_2,kpie_obra_artista2_3,kpie_obra_artista2_4, kpie_obra_artista2_5, kpie_obra_artista2_6] forKey:@"artista2"];
                [self.artistasObra setValue:@[kpie_obra_artista3_0, kpie_obra_artista3_1,kpie_obra_artista3_2,kpie_obra_artista3_3,kpie_obra_artista3_4, kpie_obra_artista3_5, kpie_obra_artista3_6] forKey:@"artista3"];
                    [self.artistasObra setValue:@[kpie_obra_artista4_0, kpie_obra_artista4_1,kpie_obra_artista4_2,kpie_obra_artista4_3,kpie_obra_artista4_4, kpie_obra_artista4_5, kpie_obra_artista4_6] forKey:@"artista4"];
                        [self.artistasObra setValue:@[kpie_obra_artista5_0, kpie_obra_artista5_1,kpie_obra_artista5_2,kpie_obra_artista5_3,kpie_obra_artista5_4, kpie_obra_artista5_5, kpie_obra_artista5_6] forKey:@"artista5"];
                            [self.artistasObra setValue:@[kpie_obra_artista6_0, kpie_obra_artista6_1,kpie_obra_artista6_2,kpie_obra_artista6_3,kpie_obra_artista6_4, kpie_obra_artista6_5, kpie_obra_artista6_6] forKey:@"artista6"];
                                [self.artistasObra setValue:@[kpie_obra_artista7_0, kpie_obra_artista7_1,kpie_obra_artista7_2,kpie_obra_artista7_3,kpie_obra_artista7_4, kpie_obra_artista7_5, kpie_obra_artista7_6] forKey:@"artista7"];
}

-(NSString *)getTituloObra:(int)artista :(int)obra{
    NSString *key = [NSString stringWithFormat:@"artista%d",artista];
    NSArray *obrasDeArtista = [self.artistasObra objectForKey:key];
    return obrasDeArtista[obra];
}

- (void)moviePlaybackComplete:(NSNotification *)notification {
    MPMoviePlayerController *moviePlayerController = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayerController];
    [moviePlayerController stop];
    [moviePlayerController.view removeFromSuperview];

}

@end
