//
//  MAAlbum.h
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAAlbum : NSObject
@property (nonatomic, copy, readonly) NSString * title, * artist, * genre, * coverUrl, * year;

- (id)initWithTitle:(NSString *)title
             artist:(NSString *)artist
           coverUrl:(NSString *)coverUrl
               year:(NSString *)year;
@end
