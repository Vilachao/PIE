//
//  PIEutil.m
//  AccionaPie
//
//  Created by Jose Maria on 19/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import "PIEutil.h"


@implementation PIEutil

+ (PIEutil *) sharedInstance{
    static PIEutil *config = nil;
    if(nil == config){
        config = [[[self class] alloc]init];
        showHOME = 0;
    }
    return config;
}


#pragma mark - navigation into view


+(void)moveViewFrom:(UIView *) from viewTo:(UIView *)to fromX:(NSInteger)x toX:(NSInteger)xTo time:(float)time{
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:time];
    from.frame = CGRectMake(x, from.frame.origin.y, from.frame.size.width, from.frame.size.height);
    to.frame = CGRectMake(xTo, to.frame.origin.y, to.frame.size.width, to.frame.size.height);
    from.hidden = YES;
    to.hidden = NO;
    [UIView commitAnimations];
}


+(NSArray *)arrayFilesFolder:(NSString *)folder :(NSArray *)subfolders{

    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:folder];
    for(NSString *subfolder in subfolders){
       sourcePath = [sourcePath stringByAppendingPathComponent:subfolder];
    }
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath error:NULL];
}

+(UIImage *)loadImage:(NSString *)name :(NSArray *)folderAndSubfolders{
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:folderAndSubfolders[0]];
    for(int i= 1; i<[folderAndSubfolders count];i++){
        sourcePath = [sourcePath stringByAppendingPathComponent:folderAndSubfolders[i]];
    }
    sourcePath = [sourcePath stringByAppendingPathComponent:name];
    BOOL fileExists=[[NSFileManager defaultManager] fileExistsAtPath:sourcePath];
    if(!fileExists){
        NSLog(@"no existe el fichero");
    }
    return [UIImage imageWithContentsOfFile:sourcePath];
}

static int showHOME;
+ (int )showHOME
{
    return showHOME;
}

+ (void )changeShowHOME:(int) a
{
    showHOME = a;
}

#pragma mark - core text
-(FTCoreTextView *)createTextSize:(CGRect)positionCoreText scrollViewSize:(CGRect)scrollViewSize viewForCore:(UIView *)view text:(NSString *)text{
    FTCoreTextView * coreTextView = [[FTCoreTextView alloc]initWithFrame:positionCoreText];
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:scrollViewSize];
    [view addSubview:scrollView];
    [scrollView addSubview:coreTextView];
    coreTextView.text =text;
    coreTextView.backgroundColor = [UIColor clearColor];
    coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [coreTextView fitToSuggestedHeight];
    [coreTextView addStyles:[self coreTextStyle]];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(coreTextView.frame), CGRectGetMaxY(coreTextView.frame))];
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)        animated:YES];
    return coreTextView;

}



- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
    //  This will be default style of the text not closed in any tag
	FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
	defaultStyle.font = [UIFont fontWithName:@"Helvetica-Neue" size:14.f];
	defaultStyle.textAlignment = FTCoreTextAlignementLeft;
    defaultStyle.color = [UIColor whiteColor];
	[result addObject:defaultStyle];
	
    //  Create style using convenience method
	FTCoreTextStyle *titleStyle = [FTCoreTextStyle styleWithName:@"title"];
	titleStyle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.f];
    titleStyle.color = [UIColor whiteColor];
	titleStyle.textAlignment = FTCoreTextAlignementLeft;
	[result addObject:titleStyle];
	
    //  Image will be centered
	FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
	imageStyle.name = FTCoreTextTagImage;
	imageStyle.textAlignment = FTCoreTextAlignementLeft;
	[result addObject:imageStyle];
	
//	FTCoreTextStyle *firstLetterStyle = [FTCoreTextStyle new];
//	firstLetterStyle.name = @"firstLetter";
//	firstLetterStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:30.f];
//	[result addObject:firstLetterStyle];
//	
    //  This is the link style
    //  Notice that you can make copy of FTCoreTextStyle
    //  and just change any required properties
	FTCoreTextStyle *linkStyle = [defaultStyle copy];
	linkStyle.name = FTCoreTextTagLink;
	linkStyle.color = [UIColor orangeColor];
	[result addObject:linkStyle];
	
//	FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
//	subtitleStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25.f];
//	subtitleStyle.color = [UIColor brownColor];
//	subtitleStyle.paragraphInset = UIEdgeInsetsMake(10, 0, 10, 0);
//	[result addObject:subtitleStyle];
//	
    //  This will be list of items
    //  You can specify custom style for a bullet
//	FTCoreTextStyle *bulletStyle = [defaultStyle copy];
//	bulletStyle.name = FTCoreTextTagBullet;
//	bulletStyle.bulletFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:16.f];
//	bulletStyle.bulletColor = [UIColor orangeColor];
//	bulletStyle.bulletCharacter = @"❧";
//	bulletStyle.paragraphInset = UIEdgeInsetsMake(0, 20.f, 0, 0);
//	[result addObject:bulletStyle];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
	italicStyle.name = @"italic";
	italicStyle.underlined = YES;
    italicStyle.font = [UIFont fontWithName:@"Helvetica-Oblique" size:12.f];
	[result addObject:italicStyle];
    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
	boldStyle.name = @"bold";
    boldStyle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.f];
	[result addObject:boldStyle];
    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    [coloredStyle setColor:[UIColor redColor]];
	[result addObject:coloredStyle];
    
    return  result;
}

@end
