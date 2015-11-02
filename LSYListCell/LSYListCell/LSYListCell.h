//
//  LSYListCell.h
//  LSYListCell
//
//  Created by Labanotation on 15/11/1.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LSYListCell : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) id<UITableViewDataSource>tableViewDataSource;
@property (nonatomic,weak) id<UITableViewDelegate>tabViewDelegate;
@property (nonatomic) BOOL defalutListCell;  //设置默认默认列表是不是展开的，默认不展开，(0 -- 不展开 1 -- 展开)
@end
