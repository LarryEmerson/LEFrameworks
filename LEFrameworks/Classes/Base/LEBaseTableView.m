//
//  LEBaseTableView.m
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableView.h"

@implementation LETableViewCellSettings
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(BOOL) gesture{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTableViewReuseableCellIdentifier EnableGesture:gesture];
}
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate{
    return [self initWithSelectionDelegate:delegate TableViewCellStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTableViewReuseableCellIdentifier];
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
    self.selectionDelegate=delegate;
    self.style=style;
    self.reuseIdentifier=reuseIdentifier;
    self.gesture=gesture;
    return self;
}
@end
@implementation LETableViewCellSelectionSettings
-(id) initWithIndexPath:(NSIndexPath *) index ClickStatus:(TableViewCellClickStatus) status{
    self=[super init];
    self.indexPath=index;
    self.clickStatus=status;
    return self;
}
@end
@implementation LETableViewSettings
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent GetDataDelegate:(id<LEGetDataDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection{
    return [self initWithSuperViewContainer:superView ParentView:parent TableViewCell:nil EmptyTableViewCell:nil GetDataDelegate:get TableViewCellSelectionDelegate:selection];
}
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LEGetDataDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection{
    return [self initWithSuperViewContainer:superView ParentView:parent TableViewCell:cell EmptyTableViewCell:empty GetDataDelegate:get TableViewCellSelectionDelegate:selection AutoRefresh:NO];
}
-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LEGetDataDelegate>) get   TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection AutoRefresh:(BOOL) autorefresh{
    self=[super init];
    self.superViewContainer=superView;
    self.parentView=parent;
    self.tableViewCellClassName=cell;
    self.emptyTableViewCellClassName=empty;
    self.getDataDelegate=get; 
    self.tableViewCellSelectionDelegate=selection;
    self.isAutoRefresh=autorefresh;
    return self;
}
@end

@interface LEBaseTableView()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate>
@property (nonatomic) DJRefresh *refresh;
@property (nonatomic) NSTimer *curTimer;
@property (nonatomic) DJRefreshDirection curDirection;
@end
@implementation LEBaseTableView{
    BOOL ignoredFirstEmptyCell;
}
- (id) initWithSettings:(LETableViewSettings *) settings{
    self.emptyTableViewCellClassName=settings.emptyTableViewCellClassName?settings.emptyTableViewCellClassName:@"LEBaseEmptyTableViewCell";
    self.tableViewCellClassName=settings.tableViewCellClassName;
    UIView *superView=settings.superViewContainer;
    UIView *parentView=settings.parentView;
    id<LEGetDataDelegate> getDatadelegate=settings.getDataDelegate;
    [self setGetDataDelegate:getDatadelegate];
    [self setCellSelectionDelegate:settings.tableViewCellSelectionDelegate];
    self = [super initWithFrame:parentView.bounds style:UITableViewStylePlain];
    [self setLeAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:parentView EdgeInsects:UIEdgeInsetsZero]];
    [self leExecAutoLayout];
    self.superViewContainer=superView;
    [parentView addSubview:self];
    if (self) {
        [self setBackgroundColor:ColorClear];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setAllowsSelection:NO];
        //
        self.refresh=[DJRefresh refreshWithScrollView:self];
        [self.refresh setDelegate:self];
        [self.refresh setTopEnabled:YES];
        [self.refresh setBottomEnabled:YES];
        [self.refresh setAutoRefreshTop:YES];
        [self initTableView];
        if(settings.isAutoRefresh){
            [self onAutoRefresh];
        } 
    }
    return self;
}
-(DJRefresh *) getRefreshView{
    return self.refresh;
}
-(void) initTableView{
}
//
-(void) setTopRefresh:(BOOL) enable{
    [self.refresh setTopEnabled:enable];
    if(!enable){
        [self.refresh finishRefreshingDirection:DJRefreshDirectionTop animation:YES];
    }
}
-(void) setBottomRefresh:(BOOL) enable{
    [self.refresh setBottomEnabled:enable];
    if(!enable){
        [self.refresh finishRefreshingDirection:DJRefreshDirectionBottom animation:YES];
    }
}
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction {
    self.curDirection=direction;
    [self.curTimer invalidate];
    self.curTimer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(onStopRefreshLogic) userInfo:nil repeats:NO];
    if(direction==DJRefreshDirectionTop){
        [self onDelegateRefreshData];
    }else {
        [self onDelegateLoadMore];
    }
}
//
-(void) onStopRefresh {
    [self.curTimer invalidate];
    self.curTimer=[NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(onStopRefreshLogic) userInfo:nil repeats:NO];
}
-(void) onStopRefreshLogic{
    [self.curTimer invalidate];
    [self reloadData];
    [self.refresh finishRefreshingDirection:self.curDirection animation:YES];
}
//
-(void) onDelegateRefreshData{
    if(self.getDataDelegate){
        if([self.getDataDelegate respondsToSelector:@selector(onRefreshData)]){
            [self.getDataDelegate onRefreshData];
        }
    }
}
-(void) onDelegateLoadMore{
    if(self.getDataDelegate){
        if([self.getDataDelegate respondsToSelector: @selector(onLoadMore)]){
            [self.getDataDelegate onLoadMore];
        }
    }
}
//
-(void) onAutoRefresh{
    if(self.refresh.topEnabled){
        [self.refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
    }
}
-(void) onAutoRefreshWithDuration:(float) duration{
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(onAutoRefresh) userInfo:nil repeats:NO];
}
//
-(void) onRefreshedWithData:(NSMutableArray *)data{
    if(data){
        self.itemsArray=[data mutableCopy];
        self.curDirection=DJRefreshDirectionTop;
        [self onStopRefresh];
    }
}
-(void) onLoadedMoreWithData:(NSMutableArray *)data{
    if(data){
        if(!self.itemsArray){
            self.itemsArray=[[NSMutableArray alloc] init];
        }
        [self.itemsArray addObjectsFromArray:data];
        self.curDirection=DJRefreshDirectionBottom;
        [self onStopRefresh];
    }
}
//
-(NSInteger) _numberOfSections{
    return 1;
}
-(CGFloat) _heightForSection:(NSInteger) section{
    return 0;
}
-(UIView *) _viewForHeaderInSection:(NSInteger) section{
    return nil;
}
-(NSInteger) _numberOfRowsInSection:(NSInteger) section{
    return self.itemsArray?self.itemsArray.count:0;
}
-(UITableViewCell *) _cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    if(indexPath.section==0){
        UITableViewCell *cell=[self dequeueReusableCellWithIdentifier:CommonTableViewReuseableCellIdentifier];
        if(!cell){
            SuppressPerformSelectorLeakWarning(
                                               cell=[[self.tableViewCellClassName getInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:") withObject:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.cellSelectionDelegate]];
                                               );
        }
        if(self.itemsArray&&indexPath.row<self.itemsArray.count){
            SuppressPerformSelectorLeakWarning(
                                               [cell performSelector:NSSelectorFromString(@"setData:IndexPath:") withObject:[self.itemsArray objectAtIndex:indexPath.row] withObject:indexPath];
                                               );
        }
        return cell;
    }
    return nil;
}
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self _numberOfSections];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self _heightForSection:section];
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self _viewForHeaderInSection:section];
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows=[self _numberOfRowsInSection:section];
    if(rows==0 && section==0 && [self _numberOfSections] <=1){
        if(self.itemsArray){
            return 1;
        }else{
            return 0;
        }
    }else{
        return [self _numberOfRowsInSection:section];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && [self _numberOfRowsInSection:0]==0 && [self _numberOfSections] <=1){
        if(!self.emptyTableViewCell){
            SuppressPerformSelectorLeakWarning(
                                               self.emptyTableViewCell=[[self.emptyTableViewCellClassName getInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:") withObject:@{KeyOfCellTitle:@"暂时还没有相关内容"}];
                                               );
        }
        return self.emptyTableViewCell;
    }
    return [self _cellForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}
@end
