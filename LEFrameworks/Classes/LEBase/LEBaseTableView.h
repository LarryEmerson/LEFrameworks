//
//  LEBaseTableView.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "LEBaseEmptyTableViewCell.h"


#define LEReuseableCellIdentifier @"LECELL"

@protocol LETableViewCellSelectionDelegate <NSObject>
/*
 * @brief Cell点击后触发，Key：LEKeyOfIndexPath、LEKeyOfClickStatus...
 */
-(void) leOnTableViewCellSelectedWithInfo:(NSDictionary *) info;
@end

@protocol LETableViewDataSourceDelegate <NSObject>
/*
 * @brief 列表下拉后触发，列表需支持下拉组件或者下拉功能已开启
 */
-(void) leOnRefreshData;
@optional
/*
 * @brief 列表上拉后触发，列表需支持上拉组件或者上拉功能已开启
 */
-(void) leOnLoadMore;
@end

@interface LETableViewCellSettings : NSObject
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
/*
 * @brief 默认 UITableViewCellStyleDefault
 */
@property (nonatomic, readonly) UITableViewCellStyle leStyle;
/*
 * @brief 不同的类型的Cell需要设置不同的值。
 */
@property (nonatomic, readonly) NSString *leReuseIdentifier;
/*
 * @brief 是否加上默认的点击事件，注意：添加默认的点击事件不利于Cell扩展其他的点击事件
 */
@property (nonatomic, readonly) BOOL leGesture;
-(void) leSetGesture:(BOOL) gesture;
/*
 * @brief 默认点击事件、Identifier
 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate;
/*
 * @brief 默认Identifier，gesture：是否添加默认点击事件
 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(BOOL) gesture;
/*
 * @brief 默认点击事件，自定义reuseIdentifier
 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier;
/*
 * @brief 自定义是否开启默认点击事件及reuseIdentifier
 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture;
/*
 * @brief 不建议使用
 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier;
/*
 * @brief 不建议使用
 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture;
@end
@interface LETableViewSettings : NSObject
/*
 * @brief 列表numOfSection=1时，空列表提示Cell类名
 */
@property (nonatomic, readonly) NSString *leEmptyTableViewCellClassName;
/*
 * @brief 列表numOfSection=1时，cell的类名
 */
@property (nonatomic, readonly) NSString *leTableViewCellClassName;
/*
 * @brief 列表View的根节点（VC.view 或者逆向第一个全屏View）。这个概念已经薄弱，初始化建议使用initWithSuperView:
 */
@property (nonatomic, readonly) UIView *leSuperViewContainer;
/*
 * @brief 列表父节点的View，即列表的superview。
 */
@property (nonatomic, readonly) UIView *leParentView;
/*
 * @brief 列表上拉下拉回调
 */
@property (nonatomic, readonly) id<LETableViewDataSourceDelegate> leDataSourceDelegate;
/*
 * @brief 列表Cell点击事件回调
 */
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leCellSelectionDelegate;
/*
 * @brief 列表生成后是否立即自动下拉刷新
 */
@property (nonatomic, readonly) BOOL leIsAutoRefresh;
/*
 * @brief 列表Cell是否自动添加点击事件
 */
@property (nonatomic, readonly) BOOL leDisableTapEvent;
-(void) leSetParentView:(UIView *) view;
/*
 * @brief superView get selection. tap=YES,auto=NO
 */
-(id) initWithSuperView:(UIView *) superView GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/*
 * @brief superView cell empty get selection. tap=YES,auto=NO
 */
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/*
 * @brief superView cell empty get selection tap. auto=NO
 */
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection TapEvent:(BOOL) tap;
/*
 * @brief superView cell empty get selection auto .tap=YES
 */
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh;
//
/*
 * @brief 不建议使用
 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/*
 * @brief 不建议使用
 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
/*
 * @brief 不建议使用
 */
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection TapEvent:(BOOL) tap;
/*
 * @brief 不建议使用
 */
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
-(void) leSetEmptyTableViewCell:(LEBaseEmptyTableViewCell *) emptyTableViewCell;
-(id)   initWithSettings:(LETableViewSettings *) settings;
-(void) leSetTopRefresh:(BOOL) enable;
-(void) leSetBottomRefresh:(BOOL) enable;
//
-(void) leOnStopTopRefresh;
-(void) leOnStopBottomRefresh;
-(void) leOnAutoRefresh;
-(void) leOnAutoRefreshWithDuration:(float) duration;
-(void) leOnRefreshedWithData:(NSMutableArray *)data;
-(void) leOnLoadedMoreWithData:(NSMutableArray *)data;
-(NSInteger) leNumberOfSections;
-(CGFloat) leHeightForSection:(NSInteger) section;
-(UIView *) leViewForHeaderInSection:(NSInteger) section;
-(NSInteger) leNumberOfRowsInSection:(NSInteger) section;
-(UITableViewCell *) leCellForRowAtIndexPath:(NSIndexPath *) indexPath;
@end
