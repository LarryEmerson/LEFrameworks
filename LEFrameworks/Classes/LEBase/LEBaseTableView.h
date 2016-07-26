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
-(void) leOnTableViewCellSelectedWithInfo:(NSDictionary *) info;
@end

@protocol LETableViewDataSourceDelegate <NSObject>
-(void) leOnRefreshData;
@optional
-(void) leOnLoadMore;
@end

@interface LETableViewCellSettings : NSObject
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic, readonly) UITableViewCellStyle leStyle;
@property (nonatomic, readonly) NSString *leReuseIdentifier;
@property (nonatomic, readonly) BOOL leGesture;
-(void) leSetGesture:(BOOL) gesture;
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate;
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(BOOL) gesture;
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier;
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture;
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier;
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture;
@end
@interface LETableViewSettings : NSObject
@property (nonatomic, readonly) NSString *leEmptyTableViewCellClassName;
@property (nonatomic, readonly) NSString *leTableViewCellClassName;
@property (nonatomic, readonly) UIView *leSuperViewContainer;
@property (nonatomic, readonly) UIView *leParentView;
@property (nonatomic, readonly) id<LETableViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leCellSelectionDelegate;
@property (nonatomic, readonly) BOOL leIsAutoRefresh;
-(void) leSetParentView:(UIView *) view;
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent GetDataDelegate:(id<LETableViewDataSourceDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh;
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
