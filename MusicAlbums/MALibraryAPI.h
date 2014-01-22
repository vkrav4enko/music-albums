//
//  MALibraryAPI.h
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAAlbum.h"

@interface MALibraryAPI : NSObject

+ (MALibraryAPI *)sharedInstance;

- (NSArray *)getAlbums;
- (void)addAlbum:(MAAlbum *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;

@end
