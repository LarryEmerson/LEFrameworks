//
//  LETableViewPage.h
//  LEUIFrameworkDemo
//
//  Created by Larry Emerson on 15/8/25.
//  Copyright (c) 2015年 Larry Emerson. All rights reserved.
//
#import "LEBaseEmptyView.h"
#import "LEBaseTableView.h" 
#import "LEDataDelegate.h"
@interface LETableViewPage : LEBaseEmptyView<LEGetDataDelegate,LETableViewCellSelectionDelegate>
@property (nonatomic) LEBaseTableView *curTableView;

-(id)initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *)navigationClass NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType TableViewClassName:(NSString *) tableViewClassName CellClassName:(NSString *) cellClassName EmptyCellClassName:(NSString *) emptyCellClassName;
-(id)initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *)navigationClass NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType TableViewClassName:(NSString *) tableViewClassName CellClassName:(NSString *) cellClassName EmptyCellClassName:(NSString *) emptyCellClassName TabbarHeight:(int) tabbarHeight;
//
-(void) onTableViewCellSelectedWithInfo:(NSDictionary *)info;
-(void) onRefreshData;
-(void) onLoadMore;
-(void) onFreshDataLogic:(NSMutableArray *) data;
-(void) onLoadMoreLogic:(NSMutableArray *) data;

@end
