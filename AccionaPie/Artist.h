//
//  Artist.h
//  AccionaPie
//
//  Created by Jose Maria on 20/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ArtistResource, Sculpture;

@interface Artist : NSManagedObject

@property (nonatomic, retain) NSNumber * idArtist;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * dateBorn;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * descriptionArtist;
@property (nonatomic, retain) NSSet *artistResource;
@property (nonatomic, retain) NSSet *artistSculpture;
@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addArtistResourceObject:(ArtistResource *)value;
- (void)removeArtistResourceObject:(ArtistResource *)value;
- (void)addArtistResource:(NSSet *)values;
- (void)removeArtistResource:(NSSet *)values;

- (void)addArtistSculptureObject:(Sculpture *)value;
- (void)removeArtistSculptureObject:(Sculpture *)value;
- (void)addArtistSculpture:(NSSet *)values;
- (void)removeArtistSculpture:(NSSet *)values;

@end
