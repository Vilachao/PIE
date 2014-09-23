//
//  PIEHomeViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEHomeViewController.h"
#import <REFrostedViewController.h>
#import "Constants.h"
#import "PIEutil.h"
#import "PIEArtistsCollectionViewCell.h"
#import <FTCoreTextView.h>
#import <FTCoreTextStyle.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )


@interface PIEHomeViewController ()

/**
 *  array de imagenes pequeñitas
 */
@property NSArray * arrayOfItems;
/**
 *  Array de imagenes
 */
@property NSArray * arrayOfImages;
/**
 *  Nombre de la imagen a mostrar
 */
@property NSString * imageName;
/**
 *  Se utiliza para controlar que imagen mostrar
 */
@property NSNumber * selRow;
/**
 *  Se utiliza pq cuando deslizas, el evento se lanza 3 veces, se controla en el back y en el fordward
 */
@property int controlDelegatePan;
/**
 *  Es para saber que imagen fue la seleccionada
 */
@property int intt;

/**
 *  Tengo que crear las vistas para poder ocultarlas cuando salga la foto
 */
@property FTCoreTextView *text;


@end

@implementation PIEHomeViewController


- (void)viewDidLoad
{
    
    self.controlDelegatePan = 0;
    
    [super viewDidLoad];
    
    self.arrayOfItems =[PIEutil arrayFilesFolder:@"MiniHome" :nil];
    
    self.arrayOfImages =[PIEutil arrayFilesFolder:@"Home" :nil];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionViewImages setCollectionViewLayout:flowLayout];
    [self cofigurationView];
    self.lblVersion.text  = [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    [self initConTexto];
   }


-(void)viewWillDisappear:(BOOL)animated{
    [self.frostedViewController hideMenuViewController];
}

-(void)viewWillAppear:(BOOL)animated{

    if(self.idSelectMenu==0){ self.queesView.hidden = NO; self.ayuntamientoView.hidden= YES;self.creditosView.hidden= YES;}
    else   if(self.idSelectMenu==1){ self.queesView.hidden = YES; self.ayuntamientoView.hidden= NO;self.creditosView.hidden= YES;}
    else   if(self.idSelectMenu==2){ self.queesView.hidden = YES; self.ayuntamientoView.hidden= YES;self.creditosView.hidden= NO;}

}

-(void)viewDidAppear:(BOOL)animated{
    
//    if ([PIEutil showHOME]==1) {
//        [PIEutil moveViewFrom:[self viewSelect:self.idSelectAnt]  viewTo:self.homeView fromX:320 toX:0 time:0];
//        [PIEutil changeShowHOME:0];
//        [self.frostedViewController dismissViewControllerAnimated:NO completion:nil];

//    [self.frostedViewController.view endEditing:YES];
    self.frostedViewController.delegate=self;
    [self.frostedViewController presentMenuViewController];

}

- (IBAction)home_showMenuRefrosted:(id)sender {
    [self.view endEditing:YES];
   // [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController dismissViewControllerAnimated:NO completion:nil];
    [self.frostedViewController presentMenuViewController];
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
        }
    }
    else {
        [[UIApplication sharedApplication] openURL:url];
    }

}



#pragma mark - Collection Data


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrayOfItems count];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PIEArtistsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCellArtists" forIndexPath:indexPath];
    NSString *nameObra = [self.arrayOfItems objectAtIndex:indexPath.row];
    cell.artists_imageViewCell.image=[PIEutil loadImage:nameObra :@[@"MiniHome"]];
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
    return UIEdgeInsetsMake(5, 27, 5, 27); // top, left, bottom, right
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.frostedViewController.panGestureEnabled = NO;
    self.selRow = [[NSNumber alloc] initWithInteger:indexPath.row];
    self.intt=[self.selRow intValue];
    self.imageName=[self.arrayOfImages objectAtIndex:self.intt];
    self.imageFullGalleryCollection.image= [PIEutil loadImage:self.imageName :@[@"Home"]];
    [self.imageFullGalleryCollection setHidden:false];
    [self.text setHidden:true];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.imageFullGalleryCollection.layer addAnimation:animation forKey:nil];

}

-(void)forwardAcction{
    self.controlDelegatePan ++;
    if(self.controlDelegatePan == 2){
    self.controlDelegatePan =0;
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.8;
    [self.imageFullGalleryCollection.layer addAnimation:animation forKey:nil];
    if(self.intt<[self.arrayOfImages count]-1){
        self.intt=self.intt+1;
        NSString *nameObra = [self.arrayOfImages objectAtIndex:self.intt];
        self.imageFullGalleryCollection.image=[PIEutil loadImage:nameObra :@[@"Home"]];
    }
    }
}


-(void)backAction{
    self.controlDelegatePan ++;
    if(self.controlDelegatePan == 2){
        self.controlDelegatePan =0;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.8;
        [self.imageFullGalleryCollection.layer addAnimation:animation forKey:nil];
        
        if(self.intt>0){
            self.intt=self.intt-1;
            NSString *nameObra = [self.arrayOfImages objectAtIndex:self.intt];
            self.imageFullGalleryCollection.image=[PIEutil loadImage:nameObra :@[@"Home"]];
        }
    }
}




     
-(UIView *)viewSelect:(NSInteger)selectMenu{
    
    switch (selectMenu) {
        case 0:{
            return self.queesView;
            break;
        }
        case 1:{
            return self.ayuntamientoView;
            break;
        }
        case 2:{
            return self.creditosView;
            break;
        }
        default:
            return self.homeView;
    }
}

#pragma  mark -Configuration View -handle Gestures

-(void)cofigurationView{
    self.frostedViewController.delegate=self;
    self.lblTextoMenu.text = klabelTitulo;
     if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.imageFullGalleryCollection setHidden:true];
    [self configureGesture];
}

-(void)configureGesture{
    
    UISwipeGestureRecognizer *swipe;
    
    self.imageFullGalleryCollection.tag = 100;
    // by the way, if not using ARC, make sure to add `autorelease` to
    // the following alloc/init statements
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.imageFullGalleryCollection addGestureRecognizer:tap];
    
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageFullGalleryCollection addGestureRecognizer:swipe];
    
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageFullGalleryCollection addGestureRecognizer:swipe];

}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture{
    if(gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        [self forwardAcction];
    }else if(gesture.direction == UISwipeGestureRecognizerDirectionRight){
        [self backAction];
    }
}

-(void)handleTap:(UITapGestureRecognizer *)gesture{
    self.frostedViewController.panGestureEnabled = YES;
    [self.imageFullGalleryCollection setHidden:true];
        [self.text setHidden:false];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.5;
    [self.imageFullGalleryCollection.layer addAnimation:animation forKey:nil];
    [self moveNavBar];

}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer{
    
    
        if([recognizer locationInView:self.view].y > [[UIScreen mainScreen] bounds].size.height*1/2 )
        {
            self.frostedViewController.panGestureEnabled = false;
        }
        else{
            self.frostedViewController.panGestureEnabled = true;
        }
        
        if(self.imageFullGalleryCollection.hidden == NO)
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

-(void)moveNavBar{

//    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    
}

- (void)initConTexto
{
    
    //Si es iPHONE 4 entramos aquí y definimos el tamaño de los textos a 3,5 pulgadas
    if (IS_IPHONE_4)
    {    if(self.idSelectMenu ==0){
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 10, 240, 3000) scrollViewSize:CGRectMake(0, 0, 320, 50) viewForCore:self.queesView text:kpie_queesTitulo];
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 0, 240, 3000) scrollViewSize:CGRectMake(0, 50, 320, 182) viewForCore:self.queesView text:kpie_quees];
    }else if(self.idSelectMenu ==1){
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 10, 240, 3000) scrollViewSize:CGRectMake(0, 0, 320, 50) viewForCore:self.ayuntamientoView text:kpie_ayuntamientoTitulo];
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 0, 240, 3000) scrollViewSize:CGRectMake(0, 50, 320, 420) viewForCore:self.ayuntamientoView text:kpie_ayuntamiento];
    }else if(self.idSelectMenu ==2){
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 20, 240, 3000) scrollViewSize:CGRectMake(0, 0, 320, 460) viewForCore:self.creditosView text:kpie_creditos_newSpace];}
    
    }else{
//Para cumplir con los anchos en todos lados 40, 240 en el primer parámetro
    if(self.idSelectMenu ==0){
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 10, 240, 3000) scrollViewSize:CGRectMake(0, 0, 320, 50) viewForCore:self.queesView text:kpie_queesTitulo];
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 0, 240, 3000) scrollViewSize:CGRectMake(0, 50, 320, 270) viewForCore:self.queesView text:kpie_quees];
    }else if(self.idSelectMenu ==1){
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 10, 240, 3000) scrollViewSize:CGRectMake(0, 0, 320, 50) viewForCore:self.ayuntamientoView text:kpie_ayuntamientoTitulo];
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 0, 240, 3000) scrollViewSize:CGRectMake(0, 50, 320, 420) viewForCore:self.ayuntamientoView text:kpie_ayuntamiento];
    }else if(self.idSelectMenu ==2){
        self.text = [[PIEutil sharedInstance] createTextSize:CGRectMake(40, 20, 240, 3000) scrollViewSize:CGRectMake(0, 0, 320, 460) viewForCore:self.creditosView text:kpie_creditos_newSpace];

        //[[PIEutil sharedInstance]createTextSizeAyuntamietno:CGRectMake(0, 0, 320, 100) reateTextSize2:CGRectMake(0, 100, 320, 100) reateTextSize3:CGRectMake(0, 200, 320, 100) scrollViewSize:CGRectMake(0, 0, 320, 460) viewForCore:self.creditosView text:kpie_creditos_newSpace text2:kpie_creditos_ayuntamiento text3:kpie_creditos_plaza];
    }}
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
	[self.coreTextView fitToSuggestedHeight];
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
