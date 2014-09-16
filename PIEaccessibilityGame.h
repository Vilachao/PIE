//
//  PIEaccessibilityGame.h
//  AccionaPie
//
//  Created by Jose Maria on 18/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIEaccessibilityGame : NSObject

@property (strong, nonatomic) NSMutableArray *arrayOfItems;
@property (strong, nonatomic) NSMutableArray *arrayOfSelected;
@property (strong, nonatomic) NSMutableArray *arrayOfDiscovered;
@property (strong, nonatomic) NSString *scoreString;
@property int totalDiscovered;
@property int level;

+ (id)sharedInstance;
- (void)newGameWithLevel:(int)level;
- (BOOL)cellAtIndexPathCanBeSelected:(NSIndexPath *)indexPath;
- (BOOL)twoCellsSelected;
- (void)checkSelectionWithCompletion:(void (^)(BOOL matched, NSArray *selectedCells))completion;

@end
