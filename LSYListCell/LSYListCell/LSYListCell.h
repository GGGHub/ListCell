//
//  LSYListCell.h
//  LSYListCell
//
//  Created by Labanotation on 15/11/1.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LSYDefalutState)
{
    LSYDefalutListClose,  //默认列表展开
    LSYDefalutListOpen,    //默认列表关闭
    LSYDefalutListDisenable
};
@interface LSYListCell : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) id<UITableViewDataSource>tableViewDataSource;
@property (nonatomic,weak) id<UITableViewDelegate>tableViewDelegate;
@property (nonatomic) LSYDefalutState defalutListCell;
@end
