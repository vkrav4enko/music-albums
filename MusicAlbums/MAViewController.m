//
//  MAViewController.m
//  MusicAlbums
//
//  Created by Владимир on 19.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MAViewController.h"
#import "MALibraryAPI.h"
#import "MAAlbum+TableRepresentation.h"
#import "MAHorizontalScroller.h"
#import "MAAlbumView.h"

@interface MAViewController () <UITableViewDataSource, UITableViewDelegate, MAHorizontalScrollerDelegate>
{
    UITableView * dataTable;
    NSArray * allAlbums;
    NSDictionary * currentAlbumData;
    int currentAlbumIndex;
    MAHorizontalScroller *scroller;
}
@end

@implementation MAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1.f];
    currentAlbumIndex = 0;
    
    allAlbums = [[MALibraryAPI sharedInstance] getAlbums];
    
    // UITableView
    CGRect frame = CGRectMake(0.f, 120.f, self.view.frame.size.width, self.view.frame.size.height - 120.f);
    dataTable = [[UITableView alloc] initWithFrame:frame
                                             style:UITableViewStyleGrouped];
    dataTable.delegate = self;
    dataTable.dataSource = self;
    dataTable.backgroundView = nil;
    [self.view addSubview:dataTable];
    
    scroller = [[MAHorizontalScroller alloc] initWithFrame:CGRectMake(0.f, 20.f, self.view.frame.size.width, 120.f)];
    scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
    scroller.delegate = self;
    [self.view addSubview:scroller];
    
    [self reloadScroller];
    
    [self showDataForAlbumAtIndex:currentAlbumIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDataForAlbumAtIndex:(int)albumIndex
{
    if (albumIndex < allAlbums.count)
    {
        MAAlbum * album = allAlbums[albumIndex];
        currentAlbumData = [album tr_tableRepresentation];
    }
    else
    {
        currentAlbumData = nil;
    }
    
    [dataTable reloadData];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentAlbumData[@"titles"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = currentAlbumData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = currentAlbumData[@"values"][indexPath.row];
    
    return cell;
}

#pragma mark - MAHorizontalScrollerDelegate methods

- (NSInteger)numberOfViewsForHorizontalScroller:(MAHorizontalScroller *)scroller
{
    return allAlbums.count;
}

- (UIView *)horizontalScroller:(MAHorizontalScroller *)scroller viewAtIndex:(int)index
{
    return [[MAAlbumView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) albumCover:[[allAlbums objectAtIndex:index] coverUrl]];
}

- (void)horizontalScroller:(MAHorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    currentAlbumIndex = index;
    [self showDataForAlbumAtIndex:index];
}

- (void)reloadScroller
{
    allAlbums = [[MALibraryAPI sharedInstance] getAlbums];
    if (currentAlbumIndex < 0)
        currentAlbumIndex = 0;
    else if (currentAlbumIndex >= allAlbums.count)
        currentAlbumIndex = allAlbums.count - 1;
    [scroller reload];
    
    [self showDataForAlbumAtIndex:currentAlbumIndex];
}

@end
