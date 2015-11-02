//
//  LSYListCell.m
//  LSYListCell
//
//  Created by Labanotation on 15/11/1.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "LSYListCell.h"
#import <objc/runtime.h>
@interface LSYListCell ()
@property (nonatomic,strong) NSMutableArray *sectionStateArray;
@end

static const void *kSelectCellSectionKey;
static const void *kTableViewCellKey;
@implementation LSYListCell
{

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sectionStateArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger ret = 0;
    if ([self.tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        ret = [self.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    if (ret && ret!=_sectionStateArray.count) {
        [_sectionStateArray removeAllObjects];
        for (int count = 0; count<ret; count++) {
             [_sectionStateArray addObject:[NSNumber numberWithBool:_defalutListCell]];
        }
    }
    return ret;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = 0;
    if (_defalutListCell == LSYDefalutListOpen) {
        if ([self.tableViewDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            ret = [self.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
        }
    }
    else if (_defalutListCell == LSYDefalutListClose){
        return 0;
    }
    else if (_defalutListCell == LSYDefalutListDisenable){
        if ([_sectionStateArray count]) {
            if ([_sectionStateArray[section] integerValue] == LSYDefalutListOpen) {
                if ([self.tableViewDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
                    ret = [self.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
                }
            }
        }
    }
    return ret;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *ret = nil;
    if ([self.tableViewDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        ret = [self.tableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return ret;
}

#pragma mark -UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *ret = nil;
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        ret = [self.tableViewDelegate tableView:tableView viewForHeaderInSection:section];
        ret.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer;
        NSNumber *cellUnfold;
        cellUnfold = [NSNumber numberWithBool:_defalutListCell];
        if (!ret.gestureRecognizers.count) {
            
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellUnfold:)];
            objc_setAssociatedObject(tapGestureRecognizer, &kTableViewCellKey, tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [ret addGestureRecognizer:tapGestureRecognizer];
            
        }
        else
        {
            tapGestureRecognizer = ret.gestureRecognizers.firstObject;
        }
        objc_setAssociatedObject(tapGestureRecognizer, &kSelectCellSectionKey, [NSNumber numberWithInteger:section], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        
    }
    return ret;
}
/**
 通过类似这样的方法把代理回调回去或者直接在该代理进行操作
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat ret = 0;
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        ret = [self.tableViewDelegate tableView:tableView heightForHeaderInSection:section];
    }
    return ret;
}
-(void)cellUnfold:(UITapGestureRecognizer *)tap
{
    _defalutListCell = LSYDefalutListDisenable;
    if (_sectionStateArray.count) {
        NSNumber *section = objc_getAssociatedObject(tap, &kSelectCellSectionKey);
        UITableView *tableView = objc_getAssociatedObject(tap, &kTableViewCellKey);
        NSNumber *select = _sectionStateArray[[section integerValue]];
        select = [NSNumber numberWithBool:![select boolValue]];
        _sectionStateArray[[section integerValue]] = select;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:[section integerValue]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

@end
