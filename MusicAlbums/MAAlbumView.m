//
//  MAAlbumView.m
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MAAlbumView.h"

@implementation MAAlbumView

{
    UIImageView * coverImage;
    UIActivityIndicatorView * indicator;
}

- (id)initWithFrame:(CGRect)frame
         albumCover:(NSString *)albumCover
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Устанавливаем чёрный фон:
        self.backgroundColor = [UIColor blackColor];
        
        // Создаём изображение с небольшим отступом - 5 пикселей от края:
        coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
        [self addSubview:coverImage];
        [coverImage addObserver:self
                     forKeyPath:@"image"
                        options:0
                        context:nil];
        // Добавляем индикатор активности:
        indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = self.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        [self addSubview:indicator];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MADownloadImageNotification"
                                                            object:self
                                                          userInfo:@{@"coverUrl": albumCover,
                                                                     @"imageView": coverImage}];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"])
    {
        [indicator stopAnimating];
    }
}

- (void)dealloc
{
    [coverImage removeObserver:self forKeyPath:@"image"];
}

@end
