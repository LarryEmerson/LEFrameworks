//
//  LETableViewPage.m
//  LEUIFrameworkDemo
//
//  Created by Larry Emerson on 15/8/25.
//  Copyright (c) 2015年 Larry Emerson. All rights reserved.
//

#import "LETableViewPage.h"

@implementation LETableViewPage
-(id)initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *)navigationClass NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType TableViewClassName:(NSString *) tableViewClassName CellClassName:(NSString *) cellClassName EmptyCellClassName:(NSString *) emptyCellClassName{
    return [self initWithSuperView:view NavigationViewClassName:navigationClass NavigationDataModel:dataModel EffectType:effectType TableViewClassName:tableViewClassName CellClassName:cellClassName EmptyCellClassName:emptyCellClassName TabbarHeight:0];
}
-(id)initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *)navigationClass NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType TableViewClassName:(NSString *) tableViewClassName CellClassName:(NSString *) cellClassName EmptyCellClassName:(NSString *) emptyCellClassName TabbarHeight:(int) tabbarHeight{
    self=[super initWithSuperView:view NavigationViewClassName:navigationClass NavigationDataModel:dataModel EffectType:effectType];
    if(!tableViewClassName||tableViewClassName.length==0){
        tableViewClassName=@"LEBaseTableView";
    }
    if(!cellClassName||cellClassName.length==0){
        cellClassName=@"LEBaseTableViewCell";
    }
    if(!emptyCellClassName||emptyCellClassName.length==0){
        emptyCellClassName=@"LEBaseEmptyTableViewCell";
    }
    UIView *tableViewContainer=nil;
    if(tabbarHeight>0){
        tableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.viewContainer.bounds.size.width, self.viewContainer.bounds.size.height-tabbarHeight)]];
    }
    self.curTableView=[[tableViewClassName getInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:") withObject:[[LETableViewSettings alloc] initWithSuperViewContainer:self.superViewContainer ParentView:tableViewContainer?:self.viewContainer TableViewCell:cellClassName EmptyTableViewCell:emptyCellClassName GetDataDelegate:self TableViewCellSelectionDelegate:self]];
    [self.curTableView setAlpha:0];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
        [self.curTableView setAlpha:1];
    } completion:^(BOOL isDone){
        
    }];
    return self;
}
 
-(void) onTableViewCellSelectedWithInfo:(NSDictionary *)info{
    NSLog(@"%s 参数tableViewDelegate=nil, 调用父类onTableViewCellSelectedWithInfo。%@",__FUNCTION__, info);
}
-(void) onRefreshData{
    NSLog(@"触发下拉刷新，子类需要重写onRefreshData方法，待获取到数据后需要执行onFreshDataLogic方法");
}
-(void) onLoadMore{
    NSLog(@"上拉获取更多，子类需要重写onLoadMore方法，待获取到数据后需要执行onLoadMoreLogic");
}
-(void) onFreshDataLogic:(NSMutableArray *) data{
    if(self.curTableView){
        [self.curTableView onRefreshedWithData:data];
    }
}
-(void) onLoadMoreLogic:(NSMutableArray *) data{
    if(self.curTableView){
        [self.curTableView onLoadedMoreWithData:data];
    }
}
@end
