//
//  PIEaccessibilityGame.m
//  AccionaPie
//
//  Created by Jose Maria on 18/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEaccessibilityGame.h"
#import "PIEutil.h"
/**
 *  Esta clase estática implementa la funcionalidad o motor del juego
 */

@implementation PIEaccessibilityGame


+ (id)sharedInstance {
    static PIEaccessibilityGame *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _level = 1;
        [self newGameWithLevel:_level];
    }
    return self;
}

#pragma mark - Metodos para la gestión de los arrays

- (void)newGameWithLevel:(int)level
{
    _level = level;
    int numberOfItems = pow(((_level + 1) * 2), 2);
    
    
    if (!_arrayOfDiscovered) {
        _arrayOfDiscovered = [[NSMutableArray alloc] initWithCapacity:0];
    } else {
        [_arrayOfDiscovered removeAllObjects];
    }
    for (int i = 0; i < numberOfItems; i++) {
        [_arrayOfDiscovered addObject:@"NO"];
    }
    
    if (!_arrayOfSelected) {
        _arrayOfSelected = [[NSMutableArray alloc] initWithCapacity:0];
    } else {
        [_arrayOfSelected removeAllObjects];
    }
    
    if (!_arrayOfItems) {
        _arrayOfItems = [[NSMutableArray alloc] init];
    } else {
        [_arrayOfItems removeAllObjects];
    }
    for (int i = 0; i < numberOfItems / 2 ; i++) {
        NSArray *imagesBio = [PIEutil arrayFilesFolder:@"Esculturas" :@[@"imagenesJuego"]];
        [_arrayOfItems addObject: [PIEutil loadImage:imagesBio[i]  :@[@"Esculturas",@"imagenesJuego"]]];
    }
    [_arrayOfItems addObjectsFromArray:_arrayOfItems];
    [self shuffle];
    
    _totalDiscovered = 0;
    
    [self reloadScoreLabel];
}

- (void)shuffle
{
    NSUInteger count = [_arrayOfItems count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [_arrayOfItems exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (BOOL)cellAtIndexPathCanBeSelected:(NSIndexPath *)indexPath
{
    if ([[_arrayOfDiscovered objectAtIndex:indexPath.row] isEqualToString:@"NO"]) {
        return YES;
    }
    return NO;
}

- (BOOL)twoCellsSelected
{
    if ([_arrayOfSelected count] == 2) {
        return YES;
    }
    return NO;
}

- (void)checkSelectionWithCompletion:(void (^)(BOOL, NSArray *))completion
{
    if ([_arrayOfSelected count] == 2) {
        NSIndexPath *firstSelection = [_arrayOfSelected objectAtIndex:0];
        NSIndexPath *secondSelection = [_arrayOfSelected objectAtIndex:1];
        if ([[_arrayOfItems objectAtIndex:firstSelection.row] isEqual:[_arrayOfItems objectAtIndex:secondSelection.row]]) {
            completion(YES, _arrayOfSelected);
            [_arrayOfSelected removeAllObjects];
            [_arrayOfDiscovered replaceObjectAtIndex:firstSelection.row withObject:@"YES"];
            [_arrayOfDiscovered replaceObjectAtIndex:secondSelection.row withObject:@"YES"];
            _totalDiscovered += 2;
            [self reloadScoreLabel];
        }
    }
    completion(NO, nil);
}

- (void)reloadScoreLabel
{
    _scoreString = [NSString stringWithFormat:@"%i/%lu", _totalDiscovered, (unsigned long)[_arrayOfItems count]];
}

@end
