//
//  MenuDataSource.m
//  MovingView
//
//  Created by ykmt on 2014/07/07.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "MenuDataSource.h"

@interface MenuDataSource ()
{
    
}
@property (strong, nonatomic) NSArray *menus;
@end

@implementation MenuDataSource


#pragma mark - Public

- (NSString *)menuDataWithIndexPath:(NSIndexPath *)indexPath
{
    return _menus[indexPath.row];
}

#pragma mark -

- (id)init
{
    self = [super init];
    if (self)
    {
        self.menus = @[@"タイムライン", @"カード"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NormalCell";

    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _menus[indexPath.row];
    
    return cell;
}

@end
