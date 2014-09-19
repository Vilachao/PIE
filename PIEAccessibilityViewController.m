//
//  PIEAccessibilityViewController.m
//  AccionaPie
//
//  Created by Jose Maria on 12/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEAccessibilityViewController.h"
#import "PIEAccessibilityGameCollectionViewCell.h"
#import "PIEaccessibilityGame.h"
#import "Constants.h"


@interface PIEAccessibilityViewController ()

@property (nonatomic, strong) PIEaccessibilityGame *memoryGame;

@end

@implementation PIEAccessibilityViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _memoryGame = [PIEaccessibilityGame sharedInstance];
    self.accessibility_segmentedButtonLevel.selectedSegmentIndex = _memoryGame.level;
    [self configurationView];
}

-(void)viewDidAppear:(BOOL)animated{

        [self.view endEditing:YES];
        [self.frostedViewController.view endEditing:YES];
        self.frostedViewController.delegate=self;
        [self.frostedViewController presentMenuViewController];

    if (self.idSelectMenu == 0) {
        self.accesibilityView.hidden = YES;
    }else{
        self.accesibilityView.hidden = NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)accessibility_actionChangeLevel:(id)sender {
    
    [_memoryGame newGameWithLevel:self.accessibility_segmentedButtonLevel.selectedSegmentIndex];
    [self.accessibility_collectionViewImages reloadData];
    
}

- (IBAction)accessibility_actionRestartGame:(id)sender {
    
    [_memoryGame newGameWithLevel:1];
    [self.accessibility_collectionViewImages reloadData];
}

- (IBAction)jugar:(id)sender {
    if(self.accesibilityView.hidden == NO){
        self.accesibilityView.hidden = YES;
        self.viewGame.hidden= NO;
    }else{
        self.accesibilityView.hidden = NO;
        self.viewGame.hidden= YES;
    }
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [self.accesibilityView.layer addAnimation:animation forKey:nil];
    [self.viewGame.layer addAnimation:animation forKey:nil];

}

#pragma mark - UICollectionView Data Source Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_memoryGame.arrayOfItems count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PIEAccessibilityGameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    cell.accessibilityGameCell_imageCover.image = [UIImage imageNamed:@"cartaTapada"];
    cell.accessibilityGameCell_imageSecret.image = [_memoryGame.arrayOfItems objectAtIndex:indexPath.row];
    cell.accessibilityGameCell_imageSecret.alpha = 0.0;
    cell.accessibilityGameCell_imageCover.alpha = 1.0;
    
    if ([[_memoryGame.arrayOfDiscovered objectAtIndex:indexPath.row] isEqualToString:@"NO"]) {
        cell.backgroundColor = [UIColor colorWithRed:0.247 green:0.522 blue:0.565 alpha:1.000];
    } else {
        cell.backgroundColor = [UIColor redColor];
        cell.accessibilityGameCell_imageSecret.alpha = 1.0;
        cell.accessibilityGameCell_imageCover.alpha = 0.0;
    }
    
    return cell;
    
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int screenWidth = self.accessibility_collectionViewImages.bounds.size.width;
    
    NSInteger width = screenWidth / sqrt([_memoryGame.arrayOfItems count]);
    
    CGSize cellSize = CGSizeMake(width, width);
    
    return cellSize;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_memoryGame cellAtIndexPathCanBeSelected:indexPath]) {
        if ([_memoryGame.arrayOfSelected count] == 2) {
            for (NSIndexPath *indexPathSelected in _memoryGame.arrayOfSelected) {
                [self hideTheShowedObjectAtIndexPath:indexPathSelected];
            }
            [_memoryGame.arrayOfSelected removeAllObjects];
        } else if ([_memoryGame.arrayOfSelected count] == 1) {
            if (![indexPath isEqual:[_memoryGame.arrayOfSelected objectAtIndex:0]]) {
                [self showTheHidenObjectAtIndexPath:indexPath];
                [_memoryGame.arrayOfSelected addObject:indexPath];
            }
        } else {
            [self showTheHidenObjectAtIndexPath:indexPath];
            [_memoryGame.arrayOfSelected addObject:indexPath];
        }
    }
}

#pragma mark - Animated selections

-(void)showTheHidenObjectAtIndexPath:(NSIndexPath *)indexPath
{
    PIEAccessibilityGameCollectionViewCell *cell = (PIEAccessibilityGameCollectionViewCell *)[self.accessibility_collectionViewImages cellForItemAtIndexPath:indexPath];
    cell.accessibilityGameCell_imageSecret.alpha = 0.0;
    cell.accessibilityGameCell_imageCover.alpha = 1.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.accessibilityGameCell_imageSecret.alpha = 1.0;
        cell.accessibilityGameCell_imageCover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_memoryGame checkSelectionWithCompletion:^(BOOL matched, NSArray *selectedCells) {
            if (matched) {
                for (NSIndexPath *cell in selectedCells) {
                    [self changeTheColorOfTheCellAtIndexPath:cell];
                }
            }
        }];
    }];
}

-(void)hideTheShowedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    PIEAccessibilityGameCollectionViewCell *cell = (PIEAccessibilityGameCollectionViewCell *)[self.accessibility_collectionViewImages cellForItemAtIndexPath:indexPath];
    cell.accessibilityGameCell_imageSecret.alpha = 1.0;
    cell.accessibilityGameCell_imageCover.alpha = 0.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.accessibilityGameCell_imageSecret.alpha = 0.0;
        cell.accessibilityGameCell_imageCover.alpha = 1.0;
    }];
}

-(void)changeTheColorOfTheCellAtIndexPath:(NSIndexPath *)indexPath
{
    PIEAccessibilityGameCollectionViewCell *cell = (PIEAccessibilityGameCollectionViewCell *)[self.accessibility_collectionViewImages cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        cell.backgroundColor = [UIColor redColor];
    }];
}

-(void)configurationView{

    NSArray *textos = @[kAccesibilidadNinos,kAccesibilidadReducida,kAccesibilidadVisual,kAccesibilidadAuditiva];
    self.textViewAccesibility.text = [textos objectAtIndex:self.idSelectMenu];
    self.textViewAccesibility.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.textViewAccesibility.selectable = NO;
    [self.buttonReiniciar setTitle:kAccesibilidadLabel forState:UIControlStateNormal];
    
}



- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer{
//    if([recognizer locationInView:self.view].y > [[UIScreen mainScreen] bounds].size.height*1/2 )
//    {
//        self.frostedViewController.panGestureEnabled = false;
//    }
//    else{
//        self.frostedViewController.panGestureEnabled = true;
//    }

   }

- (IBAction)home_showMenuRefrosted:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
@end
