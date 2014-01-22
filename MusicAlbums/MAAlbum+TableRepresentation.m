//
//  MAAlbum+TableRepresentaion.m
//  MusicAlbums
//
//  Created by Владимир on 20.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MAAlbum+TableRepresentation.h"

@implementation MAAlbum (TableRepresentaion)

- (NSDictionary *)tr_tableRepresentation
{
    return @{@"titles":@[@"Исполнитель", @"Альбом", @"Жанр", @"Год"],
             @"values":@[self.artist, self.title, self.genre, self.year]};
}

@end
