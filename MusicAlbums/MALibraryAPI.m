//
//  MALibraryAPI.m
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MALibraryAPI.h"
#import "MAPersistencyManager.h"
#import "HTTPClient.h"

@interface MALibraryAPI ()
{
    MAPersistencyManager * persistencyManager;
    HTTPClient * httpClient;
    BOOL isOnline;
}
@end

@implementation MALibraryAPI

+ (MALibraryAPI *) sharedInstance
{
    static MALibraryAPI * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MALibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        persistencyManager = [[MAPersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        isOnline = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadImage:)
                                                     name:@"MADownloadImageNotification"
                                                   object:nil];
    }
    return self;   
}

- (NSArray *)getAlbums
{
    return [persistencyManager getAlbums];
}

- (void)addAlbum:(MAAlbum *)album atIndex:(int)index
{
    [persistencyManager addAlbum:album atIndex:index];
    if (isOnline)
    {
        [httpClient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(int)index
{
    [persistencyManager deleteAlbumAtIndex:index];
    if (isOnline)
    {
        [httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}

- (void)downloadImage:(NSNotification *)notification
{
    NSString * coverUrl = notification.userInfo[@"coverUrl"];
    UIImageView * imageView = notification.userInfo[@"imageView"];
    
    imageView.image = [persistencyManager getImage:[coverUrl lastPathComponent]];
    
    if (imageView.image == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage * image = [httpClient downloadImage:coverUrl];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [persistencyManager saveImage:image filename:[coverUrl lastPathComponent]];
            });
        });
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
