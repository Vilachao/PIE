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


@interface PIEHomeViewController ()

@property NSArray * arrayOfItems;
@property NSArray * arrayOfImages;
@property NSString * imageName;
@property NSNumber * selRow;
@property int controlDelegatePan;
@property int intt;
@property int activarMail;



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
    self.activarMail=0;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"abrirEmail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activarMail:) name:@"abrirEmail" object:nil];
    
   }

-(void)activarMail:(NSNotification *)not{
    self.activarMail = 1;

}

-(void)viewWillAppear:(BOOL)animated{
    if([PIEutil showHOME] == 2)
        [self.homeView removeFromSuperview];

}

-(void)viewDidAppear:(BOOL)animated{
    if(self.activarMail==1){
        self.activarMail = 0;
        [self abrirMail:nil];
    }
    [self initConTexto];
    if ([PIEutil showHOME]==1) {
        [PIEutil moveViewFrom:[self viewSelect:self.idSelectAnt]  viewTo:self.homeView fromX:320 toX:0 time:0];
        [PIEutil changeShowHOME:0];
        [self.frostedViewController dismissViewControllerAnimated:NO completion:nil];
    }else{
        [self.view endEditing:YES];
        [self.frostedViewController.view endEditing:YES];
        self.frostedViewController.delegate=self;
        [self.frostedViewController presentMenuViewController];        
        if(self.idSelectMenu>self.idSelectAnt)
            [PIEutil moveViewFrom:[self viewSelect:self.idSelectAnt] viewTo:[self viewSelect:self.idSelectMenu] fromX:-320 toX:0 time:0.4];
        else if(self.idSelectAnt<self.idSelectAnt)
            [PIEutil moveViewFrom:[self viewSelect:self.idSelectAnt] viewTo:[self viewSelect:self.idSelectMenu] fromX:0 toX:320 time:0.4];
        
        if(self.idSelectMenu==self.idSelectAnt){
            [PIEutil moveViewFrom:[self viewSelect:self.idSelectAnt] viewTo:[self viewSelect:self.idSelectMenu] fromX:0 toX:0 time:0];
        }
    }
        self.idSelectAnt = self.idSelectMenu;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [PIEutil changeShowHOME:2];
    [self.frostedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)home_showMenuRefrosted:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
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

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    return;
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
    return UIEdgeInsetsMake(5, 20, 5, 20); // top, left, bottom, right
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.frostedViewController.panGestureEnabled = NO;
    self.selRow = [[NSNumber alloc] initWithInteger:indexPath.row];
    self.intt=[self.selRow intValue];
    self.imageName=[self.arrayOfImages objectAtIndex:self.intt];
    self.imageFullGalleryCollection.image= [PIEutil loadImage:self.imageName :@[@"Home"]];
    [self.imageFullGalleryCollection setHidden:false];
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
    self.textViewAyuntamiento.text = kpie_ayuntamiento;
    //self.textViewQueEs.text = kpie_quees;
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
    //FTCore de Créditos
    
    self.coreTextView = [[FTCoreTextView alloc]initWithFrame:CGRectMake(0, 0, 275, 1000)];
    self.creditosScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.creditosView addSubview:self.creditosScroll];
    [self.creditosScroll addSubview:self.coreTextView];
    self.coreTextView.text =@"Validar datos e introducir contenido de créditos\n\n\n\n";
    self.coreTextView.backgroundColor = [UIColor redColor];
    self.coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.coreTextView fitToSuggestedHeight];
    [self.coreTextView addStyles:[self coreTextStyle]];

    //FTCore de Que es el PIE
    
    self.coreQueesTextView = [[FTCoreTextView alloc]initWithFrame:CGRectMake(0, 0, 295, 1100)];
    self.queesScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 0, 295, 325)];
    [self.queesView addSubview:self.queesScroll];
    [self.queesScroll addSubview:self.coreQueesTextView];
    self.coreQueesTextView.text =kpie_quees;
    self.coreQueesTextView.backgroundColor = [UIColor clearColor];
    self.coreQueesTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[self.coreQueesTextView fitToSuggestedHeight];
    [self.coreQueesTextView addStyles:[self coreTextStyle]];
    [self.queesScroll setContentSize:CGSizeMake(CGRectGetWidth(self.coreQueesTextView.frame), CGRectGetMaxY(self.coreQueesTextView.frame))];
    [self.queesScroll setContentOffset:CGPointMake(self.queesScroll.contentOffset.x, 0)        animated:YES];
    //FTCore de Ayuntamiento

    
}
- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
    //  This will be default style of the text not closed in any tag
	FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
	defaultStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:14.f];
	defaultStyle.textAlignment = FTCoreTextAlignementLeft;
	[result addObject:defaultStyle];
	
    //  Create style using convenience method
	FTCoreTextStyle *titleStyle = [FTCoreTextStyle styleWithName:@"title"];
	titleStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:40.f];
	titleStyle.paragraphInset = UIEdgeInsetsMake(20.f, 0, 25.f, 0);
	titleStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:titleStyle];
	
    //  Image will be centered
	FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
	imageStyle.name = FTCoreTextTagImage;
	imageStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:imageStyle];
	
	FTCoreTextStyle *firstLetterStyle = [FTCoreTextStyle new];
	firstLetterStyle.name = @"firstLetter";
	firstLetterStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:30.f];
	[result addObject:firstLetterStyle];
	
    //  This is the link style
    //  Notice that you can make copy of FTCoreTextStyle
    //  and just change any required properties
	FTCoreTextStyle *linkStyle = [defaultStyle copy];
	linkStyle.name = FTCoreTextTagLink;
	linkStyle.color = [UIColor orangeColor];
	[result addObject:linkStyle];
	
	FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
	subtitleStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25.f];
	subtitleStyle.color = [UIColor brownColor];
	subtitleStyle.paragraphInset = UIEdgeInsetsMake(10, 0, 10, 0);
	[result addObject:subtitleStyle];
	
    //  This will be list of items
    //  You can specify custom style for a bullet
	FTCoreTextStyle *bulletStyle = [defaultStyle copy];
	bulletStyle.name = FTCoreTextTagBullet;
	bulletStyle.bulletFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:16.f];
	bulletStyle.bulletColor = [UIColor orangeColor];
	bulletStyle.bulletCharacter = @"❧";
	bulletStyle.paragraphInset = UIEdgeInsetsMake(0, 20.f, 0, 0);
	[result addObject:bulletStyle];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
	italicStyle.name = @"italic";
	italicStyle.underlined = YES;
    italicStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16.f];
	[result addObject:italicStyle];
    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
	boldStyle.name = @"bold";
    boldStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:16.f];
	[result addObject:boldStyle];
    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    [coloredStyle setColor:[UIColor redColor]];
	[result addObject:coloredStyle];
    
    return  result;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //  We need to recalculate fit height on every layout because
    //  when the device orientation changes, the FTCoreText's width changes
    
    //  Make the FTCoreTextView to automatically adjust it's height
    //  so it fits all its rendered text using the actual width
	[self.coreTextView fitToSuggestedHeight];
    
    //  Adjust the scroll view's content size so it can scroll all
    //  the FTCoreTextView's content
    [self.creditosScroll setContentSize:CGSizeMake(CGRectGetWidth(self.creditosScroll.bounds), CGRectGetMaxY(self.coreTextView.frame)+20.0f)];
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
