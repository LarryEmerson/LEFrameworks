//
//  LEBaseTableView.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableView.h"

@interface LETableViewCellSettings ()
@property (nonatomic, readwrite) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic, readwrite) UITableViewCellStyle leStyle;
@property (nonatomic, readwrite) NSString *leReuseIdentifier;
@property (nonatomic, readwrite) BOOL leGesture;
@end
@interface LETableViewSettings ()
@property (nonatomic, readwrite) NSString *leEmptyTableViewCellClassName;
@property (nonatomic, readwrite) NSString *leTableViewCellClassName;
@property (nonatomic, readwrite) UIView *leSuperViewContainer;
@property (nonatomic, readwrite) UIView *leParentView;
@property (nonatomic, readwrite) id<LETableViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readwrite) id<LETableViewCellSelectionDelegate> leCellSelectionDelegate;
@property (nonatomic, readwrite) BOOL leIsAutoRefresh;
@property (nonatomic, readwrite) BOOL leDisableTapEvent;
@end
@interface LEBaseTableView ()
@property (nonatomic, readwrite) LEBaseEmptyTableViewCell *leEmptyTableViewCell;
@property (nonatomic, readwrite) id<LETableViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readwrite) id<LETableViewCellSelectionDelegate> leCellSelectionDelegate;
@property (nonatomic, readwrite) UIView * leSuperViewContainer;
@property (nonatomic, readwrite) NSMutableArray *leItemsArray;
@property (nonatomic, readwrite) NSString *leEmptyTableViewCellClassName;
@property (nonatomic, readwrite) NSString *leTableViewCellClassName;
@property (nonatomic, readwrite) BOOL leIsDisbaleTap;
@end

@implementation LETableViewCellSettings
-(void) leSetGesture:(BOOL) gesture{
    self.leGesture=gesture;
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(BOOL) gesture{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:UITableViewCellStyleDefault reuseIdentifier:LEReuseableCellIdentifier EnableGesture:gesture];
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:UITableViewCellStyleDefault reuseIdentifier:LEReuseableCellIdentifier];
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:style reuseIdentifier:reuseIdentifier EnableGesture:YES];
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier EnableGesture:gesture];
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture{
    self=[super init];
    self.leSelectionDelegate=delegate;
    self.leStyle=style;
    self.leReuseIdentifier=reuseIdentifier;
    self.leGesture=gesture;
    return self;
}
@end 
@implementation LETableViewSettings
-(void) leSetParentView:(UIView *) view{
    self.leParentView=view;
}
-(id) initWithSuperView:(UIView *) superView GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection{
    return [self initWithSuperView:superView TableViewCell:nil EmptyTableViewCell:nil GetDataDelegate:get TableViewCellSelectionDelegate:selection];
}
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection{
    return [self initWithSuperView:superView TableViewCell:cell EmptyTableViewCell:empty GetDataDelegate:get TableViewCellSelectionDelegate:selection AutoRefresh:NO];
}
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection TapEvent:(BOOL) tap{
    self=[self initWithSuperView:superView TableViewCell:cell EmptyTableViewCell:empty GetDataDelegate:get TableViewCellSelectionDelegate:selection AutoRefresh:NO];
    self.leDisableTapEvent=!tap;
    return self;
}
-(id) initWithSuperView:(UIView *) superView TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh{
    return [self initWithSuperViewContainer:superView ParentView:superView TableViewCell:cell EmptyTableViewCell:empty GetDataDelegate:get TableViewCellSelectionDelegate:selection AutoRefresh:NO];
}
//
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent GetDataDelegate:(id<LETableViewDataSourceDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection{
    return [self initWithSuperViewContainer:superView ParentView:parent TableViewCell:nil EmptyTableViewCell:nil GetDataDelegate:get TableViewCellSelectionDelegate:selection];
}
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection{
    return [self initWithSuperViewContainer:superView ParentView:parent TableViewCell:cell EmptyTableViewCell:empty GetDataDelegate:get TableViewCellSelectionDelegate:selection AutoRefresh:NO];
}
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection TapEvent:(BOOL) tap{
    self=[self initWithSuperViewContainer:superView ParentView:parent TableViewCell:cell EmptyTableViewCell:empty GetDataDelegate:get TableViewCellSelectionDelegate:selection AutoRefresh:NO];
    self.leDisableTapEvent=!tap;
    return self;
}
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh{
    self=[super init];
    self.leSuperViewContainer=superView;
    self.leParentView=parent;
    self.leTableViewCellClassName=cell;
    self.leEmptyTableViewCellClassName=empty;
    self.leDataSourceDelegate=get;
    self.leCellSelectionDelegate=selection;
    self.leIsAutoRefresh=autorefresh;
    return self;
}
@end

@interface LEBaseTableView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation LEBaseTableView{
    //    BOOL ignoredFirstEmptyCell; 
}
-(void) leSetEmptyTableViewCell:(LEBaseEmptyTableViewCell *) emptyTableViewCell{
    self.leEmptyTableViewCell=emptyTableViewCell;
}
- (id) initWithSettings:(LETableViewSettings *) settings{
    self.leIsDisbaleTap=settings.leDisableTapEvent;
    self.leEmptyTableViewCellClassName=settings.leEmptyTableViewCellClassName?settings.leEmptyTableViewCellClassName:@"LEBaseEmptyTableViewCell";
    self.leTableViewCellClassName=settings.leTableViewCellClassName;
    UIView *superView=settings.leSuperViewContainer;
    UIView *leParentView=settings.leParentView; 
    [self setLeDataSourceDelegate:settings.leDataSourceDelegate];
    [self setLeCellSelectionDelegate:settings.leCellSelectionDelegate];
    self = [super initWithFrame:leParentView.bounds style:UITableViewStylePlain];
    [self setLeAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:leParentView EdgeInsects:UIEdgeInsetsZero]];
    [self leExecAutoLayout];
    self.leSuperViewContainer=superView; 
    [leParentView addSubview:self];
    if (self) {
        [self setBackgroundColor:LEColorClear];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setAllowsSelection:NO];
        //
        [self leExtraInits];
        if(settings.leIsAutoRefresh){
            [self leOnAutoRefresh];
        } 
    }
    return self;
} 
//
-(void) onDelegateRefreshData{
    if(self.leDataSourceDelegate){
        if([self.leDataSourceDelegate respondsToSelector:@selector(leOnRefreshData)]){
            [self.leDataSourceDelegate leOnRefreshData];
        }
    }
}
-(void) onDelegateLoadMore{
    if(self.leDataSourceDelegate){
        if([self.leDataSourceDelegate respondsToSelector: @selector(leOnLoadMore)]){
            [self.leDataSourceDelegate leOnLoadMore];
        }
    }
}
//
-(void) leOnAutoRefresh{
}
-(void) leOnAutoRefreshWithDuration:(float) duration{
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(leOnAutoRefresh) userInfo:nil repeats:NO];
}
#pragma mark Refresh
-(void) leSetTopRefresh:(BOOL) enable{
    
}
-(void) leOnRefreshedWithData:(NSMutableArray *)data{
    [self leOnRefreshedDataToDataSource:data];
    [self leOnReloadTableViewForRefreshedDataSource];
    [self leOnStopTopRefresh];
}
-(void) leOnRefreshedDataToDataSource:(NSMutableArray *) data{
    if(data){
        self.leItemsArray=[data mutableCopy];
        self.leCellCountAppended=data.count;
    }
}
-(void) leOnReloadTableViewForRefreshedDataSource{
    [self reloadData];
}
-(void) leOnStopTopRefresh{}
#pragma mark Append
-(void) leSetBottomRefresh:(BOOL) enable{
    
}
-(void) leOnLoadedMoreWithData:(NSMutableArray *)data{
    [self leOnAppendedDataToDataSource:data];
    [self leOnReloadTableViewForAppendedDataSource];
    [self leOnStopBottomRefresh];
}
-(void) leOnAppendedDataToDataSource:(NSMutableArray *) data{
    if(data){
        if(!self.leItemsArray){
            self.leItemsArray=[[NSMutableArray alloc] init];
        }
        self.leCellCountAppended=data.count;
        [self.leItemsArray addObjectsFromArray:data];
    }
}
-(void) leOnReloadTableViewForAppendedDataSource{
    if(self.leCellCountAppended!=self.leItemsArray.count){
        //使用insertRowsAtIndexPaths，在网络延迟严重的情况下容易出现 Assertion failure in -[xxx _endCellAnimationsWithContext:]。目前退回使用reloaddata
        //        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
        //        NSInteger section=[self leNumberOfSections]>1?[self leNumberOfSections]-1:0;
        //        for (int ind = 0; ind < self.leCellCountAppended; ind++) {
        //            NSIndexPath *newPath =  [NSIndexPath indexPathForRow:self.leItemsArray.count-self.leCellCountAppended+ind inSection:section];
        //            [insertIndexPaths addObject:newPath];
        //        }
        //        [self insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self reloadData];
    }
}
-(void) leOnStopBottomRefresh{}
//
-(NSInteger) leNumberOfSections{
    return 1;
}
-(CGFloat) leHeightForSection:(NSInteger) section{
    return 0;
}
-(UIView *) leViewForHeaderInSection:(NSInteger) section{
    return nil;
}
-(NSInteger) leNumberOfRowsInSection:(NSInteger) section{
    return self.leItemsArray?self.leItemsArray.count:0;
}
-(UITableViewCell *) leCellForRowAtIndexPath:(NSIndexPath *) indexPath{
    if(indexPath.section==0){
        UITableViewCell *cell=[self dequeueReusableCellWithIdentifier:LEReuseableCellIdentifier];
        if(!cell){
            LESuppressPerformSelectorLeakWarning(
                                                 cell=[[self.leTableViewCellClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:") withObject:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.leCellSelectionDelegate EnableGesture:!self.leIsDisbaleTap]];
                                                 );
        }
        if(self.leItemsArray&&indexPath.row<self.leItemsArray.count){
            LESuppressPerformSelectorLeakWarning(
                                                 [cell performSelector:NSSelectorFromString(@"leSetData:IndexPath:") withObject:[self.leItemsArray objectAtIndex:indexPath.row] withObject:indexPath];
                                                 );
        }
        return cell;
    }
    return nil;
}
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self leNumberOfSections];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self leHeightForSection:section];
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self leViewForHeaderInSection:section];
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows=[self leNumberOfRowsInSection:section];
    if(rows==0 && section==0 && [self leNumberOfSections] <=1){
        if(self.leItemsArray){
            return 1;
        }else{
            return 0;
        }
    }else{
        return [self leNumberOfRowsInSection:section];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && [self leNumberOfRowsInSection:0]==0 && [self leNumberOfSections] <=1){
        if(!self.leEmptyTableViewCell){
            LESuppressPerformSelectorLeakWarning(
                                                 self.leEmptyTableViewCell=[[self.leEmptyTableViewCellClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:") withObject:@{LEKeyOfCellTitle:@"暂时还没有相关内容"}];
                                                 );
        }
        return self.leEmptyTableViewCell;
    }
    return [self leCellForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}
@end
