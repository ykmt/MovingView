//
//  MenuDataSource.h
//  MovingView
//
//  Created by ykmt on 2014/07/07.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuDataSource : NSObject <UITableViewDataSource>

- (NSString *)menuDataWithIndexPath:(NSIndexPath *)indexPath;

@end
