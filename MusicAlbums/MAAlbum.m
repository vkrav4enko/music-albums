//
//  MAAlbum.m
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MAAlbum.h"

@implementation MAAlbum
- (id)initWithTitle:(NSString *)title
             artist:(NSString *)artist
           coverUrl:(NSString *)coverUrl
               year:(NSString *)year
{
    self = [super init];
    if (self)
    {
        _title = title;
        _artist = artist;
        _coverUrl = coverUrl;
        _year = year;
        _genre = @"Pop";
    }
    return self;
}
@end
