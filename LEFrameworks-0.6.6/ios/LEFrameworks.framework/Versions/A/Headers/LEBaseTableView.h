//
//  LEBaseTableView.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "LEBaseEmptyTableViewCell.h"
#import "LEBaseTableViewCell.h"
#import "LEBaseEmptyTableViewCell.h"


#define LEReuseableCellIdentifier @"LECELL"



@protocol LETableViewDataSourceDelegate <NSObject>
/** 列表下拉后触发，列表需支持下拉组件或者下拉功能已开启 */
-(void) leOnRefreshData;
@optional
/** 列表上拉后触发，列表需支持上拉组件或者上拉功能已开启 */
-(void) leOnLoadMore;
@end


@interface LETableViewSettings : NSObject
/** 列表numOfSection=1时，空列表提示Cell类名 */
@property (nonatomic, readonly) NSString *leEmptyTableViewCellClassName;
/** 列表numOfSection=1时，cell的类名 */
@property (nonatomic, readonly) NSString *leTableViewCellClassName;
/** 列表View的根节点（VC.view 或者逆向第一个全屏View）。这个概念已经薄弱，初始化建议使用initWithSuperView: */
@property (nonatomic, readonly) UIView *leSuperViewContainer;
/** 列表父节点的View，即列表的superview。 */
@property (nonatomic, readonly) UIView *leParentView;
/** 列表上拉下拉回调 */
@property (nonatomic, readonly) id<LETableViewDataSourceDelegate> leDataSourceDelegate;
/** 列表Cell点击事件回调 */
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leCellSelectionDelegate;
/** 列表生成后是否立即自动下拉刷新 */
@property (nonatomic, readonly) BOOL leIsAutoRefresh;
/** 列表Cell是否自动添加点击事件 */
@property (nonatomic, readonly) BOOL leDisableTapEvent;
-(void) leSetParentView:(UIView *) view;
/** superView get selection. tap=YES,auto=NO */
-(id) initWithSuperView:(UIView *) superView GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/** superView cell empty get selection. tap=YES,auto=NO */
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/** superView cell empty get selection tap. auto=NO */
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection TapEvent:(BOOL) tap;
/** superView cell empty get selection auto .tap=YES */
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh;
//
/** 不建议使用 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/** 不建议使用 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/** 不建议使用 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection TapEvent:(BOOL) tap;
/** 不建议使用 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh;
@end

@interface LEBaseTableView : UITableView
@property (nonatomic, readonly) LEBaseEmptyTableViewCell *leEmptyTableViewCell;
@property (nonatomic, readonly) id<LETableViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leCellSelectionDelegate;
@property (nonatomic, readonly) UIView * leSuperViewContainer;
@property (nonatomic, readonly) NSMutableArray *leItemsArray;
@property (nonatomic, readonly) NSString *leEmptyTableViewCellClassName;
@property (nonatomic, readonly) NSString *leTableViewCellClassName;
@property (nonatomic, readonly) BOOL leIsDisbaleTap;
@property (nonatomic)           NSInteger leCellCountAppended;
-(void) leSetEmptyTableViewCell:(LEBaseEmptyTableViewCell *) emptyTableViewCell;
-(id)   initWithSettings:(LETableViewSettings *) settings; 
#pragma mark Refresh
-(void) leSetTopRefresh:(BOOL) enable;
-(void) leOnAutoRefresh;
-(void) leOnAutoRefreshWithDuration:(float) duration;

-(void) leOnRefreshedWithData:(NSMutableArray *)data;
-(void) leOnRefreshedDataToDataSource:(NSMutableArray *) data;
-(void) leOnReloadTableViewForRefreshedDataSource;
-(void) leOnStopTopRefresh;
#pragma mark Append
-(void) leSetBottomRefresh:(BOOL) enable;
-(void) leClearCells;
-(void) leOnLoadedMoreWithData:(NSMutableArray *)data;
-(void) leOnAppendedDataToDataSource:(NSMutableArray *) data;
-(void) leOnReloadTableViewForAppendedDataSource;
-(void) leOnStopBottomRefresh;
#pragma mark TableView datasource & delegate
-(NSInteger) leNumberOfSections;
-(CGFloat) leHeightForSection:(NSInteger) section;
-(UIView *) leViewForHeaderInSection:(NSInteger) section;
-(NSInteger) leNumberOfRowsInSection:(NSInteger) section;
-(UITableViewCell *) leCellForRowAtIndexPath:(NSIndexPath *) indexPath; 
@end
