//
//  MAPersistencyManager.h
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAAlbum.h"

@interface MAPersistencyManager : NSObject

- (NSArray *)getAlbums;
- (void)addAlbum:(MAAlbum *)album atIndex:(NSUInteger)index;
- (void)deleteAlbumAtIndex:(NSUInteger)index;
- (void)saveImage:(UIImage *)image filename:(NSString *)filename;
- (UIImage *)getImage:(NSString *)filename;
@end
