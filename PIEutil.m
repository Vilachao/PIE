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



@end
