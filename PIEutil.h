
//
//  PIEutil.h
//  AccionaPie
//
//  Created by Jose Maria on 19/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FTCoreTextView.h>

@interface PIEutil : NSObject

+ (PIEutil *) sharedInstance;


/**
 *  Move two Views: from and to from their actual positions to the positon pass by params.Normallity we use this method for transition between views from - to. From dissapera and to Appear
 *
 *  @param from uiview what normality appear in scene
 *  @param to   uiview what normality disappear in scene
 *  @param x    move axis-x of viewfrom
 *  @param xTo  move axis-f of viewTo
 */
+(void)moveViewFrom:(UIView *) from viewTo:(UIView *)to fromX:(NSInteger)x toX:(NSInteger)xTo time:(float)time;


/**
 *  Return files in folder
 *
 *  @param folder folder
*  @param subfolder list subfolders
 *
 *  @return files array
 */
+(NSArray *)arrayFilesFolder:(NSString *)folder :(NSArray *)subfolders;


/**
 *  Load Images
 *
 *  @param name naem image with extension
 *
 *  @return image
 */
+(UIImage *)loadImage:(NSString *)name :(NSArray *)folderAndSubfolders;

/**
 *  Si la variable vale 2, elimina el árbol del menú principal de la vista El parque.
 * Antes si valía uno mostraba el árbol pero se ha creado una vista independiente para la Home.
 *  @return int
 */
+ (int)showHOME;

/**
 *  Change Showhome
 *
 *  @param a value for showHome 0 not show 1 show
 */
+ (void )changeShowHOME:(int)a;


/**
 *  Create CoreText
 *
 *  @param positionCoreText position coretext
 *  @param scrollViewSize   positionScroll
 *  @param view             view
 *  @param text             text
 */
-(FTCoreTextView *)createTextSize:(CGRect)positionCoreText scrollViewSize:(CGRect)scrollViewSize viewForCore:(UIView *)view text:(NSString *)text;

/**
 *  Styles for textViews
 *
 *  @return result formated text
 */
- (NSArray *)coreTextStyle;


@end
