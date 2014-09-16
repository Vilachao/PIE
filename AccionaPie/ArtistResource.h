//
//  ArtistResource.h
//  AccionaPie
//
//  Created by Jose Maria on 20/08/14.
//  Copyright (c) 2014 Kometasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtistResource : NSManagedObject

@property (nonatomic, retain) NSNumber * idArtistResource;
@property (nonatomic, retain) NSNumber * idArtist;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSManagedObject *resourceArtist;

@end
