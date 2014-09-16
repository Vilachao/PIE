//
//  Sculpture.h
//  AccionaPie
//
//  Created by Jose Maria on 20/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sculpture : NSManagedObject

@property (nonatomic, retain) NSNumber * idSculpture;
@property (nonatomic, retain) NSString * nameQR;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * audio;
@property (nonatomic, retain) NSNumber * idArtist;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * material;
@property (nonatomic, retain) NSString * descriptionSculpture;
@property (nonatomic, retain) NSString * video;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * sizes;
@property (nonatomic, retain) NSManagedObject *sculptureArtist;

@end
