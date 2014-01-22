//
//  MAPersistencyManager.m
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MAPersistencyManager.h"

@interface MAPersistencyManager ()

{
    NSMutableArray * albums; // Массив всех альбомов
}

@end

@implementation MAPersistencyManager

- (id)init
{
    self = [super init];
    if (self)
    {
        albums = [NSMutableArray arrayWithArray:
                  @[[[MAAlbum alloc] initWithTitle:@"Best of Bowie"
                                          artist:@"David Bowie"
                                        coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_david%20bowie_best%20of%20bowie.png"
                                            year:@"1992"],
                    
                    [[MAAlbum alloc] initWithTitle:@"It's My Life"
                                          artist:@"No Doubt"
                                        coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png"
                                            year:@"2003"],
                    
                    [[MAAlbum alloc] initWithTitle:@"Nothing Like The Sun"
                                          artist:@"Sting"
                                        coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png"
                                            year:@"1999"],
                    
                    [[MAAlbum alloc] initWithTitle:@"Staring at the Sun"
                                          artist:@"U2"
                                        coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png"
                                            year:@"2000"],
                    
                    [[MAAlbum alloc] initWithTitle:@"American Pie"
                                          artist:@"Madonna"
                                        coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_madonna_american%20pie.png"
                                            year:@"2000"]]];
    }
    return self;
}

- (NSArray *)getAlbums
{
    return albums;
}

- (void)addAlbum:(MAAlbum *)album atIndex:(NSUInteger)index
{
    if (albums.count >= index)
        [albums insertObject:album atIndex:index];
    else
        [albums addObject:album];
}

- (void)deleteAlbumAtIndex:(NSUInteger)index
{
    [albums removeObjectAtIndex:index];
}

- (void)saveImage:(UIImage *)image filename:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData * data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage *)getImage:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData * data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

@end
