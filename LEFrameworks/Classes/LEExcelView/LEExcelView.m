//
//  LEExcelView.m
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/17.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import "LEExcelView.h"


@implementation LEExcelViewTableViewCell{
    UIView *viewMovableContainer;
    UIView *viewImmovableContainer;
}
- (id)initWithSettings:(LETableViewCellSettings *) settings UIParam:(NSDictionary *) param {
    self.immovableWidth=[[param objectForKey:@"immovable"] intValue];
    self.leMovableWidth=[[param objectForKey:@"movable"] intValue];
    int cellHeight=[[param objectForKey:@"height"] intValue];
    self=[super initWithSettings:settings];
    [self leSetBottomSplit:NO Width:0]; 
    
    [self setFrame:CGRectMake(0, 0, self.immovableWidth+self.leMovableWidth, cellHeight)];
    viewMovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    viewImmovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    self.leImmovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewImmovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(self.immovableWidth, cellHeight)]];
    self.leMovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewMovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.immovableWidth, 0) CGSize:CGSizeMake(self.leMovableWidth, cellHeight)]];
    [self leExtraInits];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leOnExcelViewScrolledWith:) name:LEExcelViewNotification object:nil];
    return self;
}
-(void) leOnExcelViewScrolledWith:(NSNotification *) info{
    if(info){
        id offsetx=[info.userInfo objectForKey:LEExcelViewNotification];
        if(offsetx){
            [self.leImmovableViewContainer leSetOffset:CGPointMake([offsetx floatValue], 0)];
        }
    }
}
-(void) dealloc{
    [self leReleaseView];
}
-(void) leReleaseView{
    [self.leImmovableViewContainer removeFromSuperview];
    [self.leMovableViewContainer removeFromSuperview];
    self.leSelectionDelegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LEExcelViewNotification object:nil];
    //    LELogInt(self.leIndexPath.row)
}
@end


@implementation LEExcelViewTabbar{
    NSDictionary *curParam;
}
-(id) initWithSettings:(LEAutoLayoutSettings *)settings UIParam:(NSDictionary *) param{
    curParam=param;
    self=[super initWithAutoLayoutSettings:settings];
    return self;
}
-(void) leExtraInits{
    int immovable=[[curParam objectForKey:@"immovable"] intValue];
    int movable  =[[curParam objectForKey:@"movable"] intValue];
    UIView *movableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    UIView *immovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    self.leImmovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:immovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(immovable, self.bounds.size.height)]];
    self.leMovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:movableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(immovable, 0) CGSize:CGSizeMake(movable, self.bounds.size.height)]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leOnExcelViewScrolledWith:) name:LEExcelViewNotification object:nil];
}
-(void) dealloc{
    [self leReleaseView];
}
-(void) leReleaseView{
    [self.leMovableViewContainer removeFromSuperview];
    [self.leImmovableViewContainer removeFromSuperview];
    self.delegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LEExcelViewNotification object:nil];
    //    LELogFunc
}
-(void) leOnExcelViewScrolledWith:(NSNotification *) info{
    if(info){
        id offsetx=[info.userInfo objectForKey:LEExcelViewNotification];
        if(offsetx){
            [self.leImmovableViewContainer leSetOffset:CGPointMake([offsetx floatValue], 0)];
        }
    }
}
-(void) leOnSetTabbarData:(id) data{}
@end

@interface LEExcelViewTableView : LEBaseTableView
@end
@implementation LEExcelViewTableView{
    int immovableWidth;
    int movableWidth;
    int curHeight;
    int tabbarHeight;
    NSString *curTabbarClassName;
    LEExcelViewTabbar *curTabbar;
    NSMutableArray *cellCache;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int)immovable MovableViewWidth:(int)movable TabbarHeight:(int) tabbarH CellHeight:(int) height TabbarClassname:(NSString *) tabbarClassname{
    immovableWidth=immovable;
    movableWidth=movable;
    curHeight=height;
    tabbarHeight=tabbarH;
    curTabbarClassName=tabbarClassname;
    cellCache=[NSMutableArray new];
    return [super initWithSettings:settings];
}
-(UIView *) leViewForHeaderInSection:(NSInteger)section{
    if(!curTabbar){
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:immovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:tabbarHeight]};
        LESuppressPerformSelectorLeakWarning(
                                             curTabbar=[[curTabbarClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(immovableWidth+movableWidth, tabbarHeight)] withObject:dic];
                                             );
        [curTabbar setDelegate:self.leCellSelectionDelegate];
    }
    return curTabbar;
}
-(CGFloat) leHeightForSection:(NSInteger)section{
    return tabbarHeight;
}
-(void) leOnSetTabbarData:(id) data{
    [curTabbar leOnSetTabbarData:data];
}
-(UITableViewCell *) leCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LEExcelViewTableViewCell *cell=[self dequeueReusableCellWithIdentifier:LEReuseableCellIdentifier];
    if(!cell){
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:immovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:curHeight]};
        LESuppressPerformSelectorLeakWarning(
                                             cell=[[self.leTableViewCellClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.leCellSelectionDelegate EnableGesture:NO] withObject:dic];
                                             [cellCache addObject:cell];
                                             );
    }
    
    if(self.leItemsArray&&indexPath.row<self.leItemsArray.count){
        [cell leSetData:[self.leItemsArray objectAtIndex:indexPath.row] IndexPath:indexPath]; 
    }
    return cell;
}
-(void) leReleaseView{
    [super leReleaseView];
    [curTabbar leReleaseView];
    [curTabbar removeFromSuperview];
    curTabbar=nil;
    for (NSInteger i=0; i<cellCache.count; i++) {
        [[cellCache objectAtIndex:i] leReleaseView];
        [[cellCache objectAtIndex:i] removeFromSuperview];
    }
    [cellCache removeAllObjects];
    [self removeFromSuperview];
}
@end
@implementation LEExcelView{
    int immovableWidth;
    int movableWidth;
    LEExcelViewTableView *curTableView;
    float lastOffsetX;
}
-(UITableView *) leGetTableView{
    return curTableView;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar{
    immovableWidth=immovable;
    movableWidth=movable;
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:settings.leParentView Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:settings.leParentView.bounds.size]];
    [self setContentSize:CGSizeMake(immovableWidth+movableWidth, self.bounds.size.height)];
    [self setDelegate:self];
    [self setContentInset:UIEdgeInsetsZero];
    [self setContentOffset:CGPointZero]; 
    UIView *tv=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(immovableWidth+movableWidth, self.bounds.size.height)]];
    [settings leSetParentView:tv];
    curTableView=[[LEExcelViewTableView alloc] initWithSettings:settings ImmovableViewWidth:immovable MovableViewWidth:movable TabbarHeight:tabbarH CellHeight:LEDefaultCellHeightBig TabbarClassname:tabbar];
    [curTableView leSetTopRefresh:NO];
    [curTableView leSetBottomRefresh:NO];
    return self;
}
-(void) leScrollToTop{
    [curTableView setContentOffset:CGPointZero animated:YES];
}
-(void) leOnRefreshedWithData:(NSMutableArray *) data{
    [curTableView leOnRefreshedWithData:data];
}
-(void) leOnSetTabbarData:(id) data{
    [curTableView leOnSetTabbarData:data];
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    if(offset.x<0)offset.x=0;
    if(lastOffsetX!=offset.x){
        [[NSNotificationCenter defaultCenter] postNotificationName:LEExcelViewNotification object:nil userInfo:@{LEExcelViewNotification:[NSNumber numberWithFloat:offset.x]}];
        lastOffsetX=offset.x;
        [curTableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, immovableWidth+movableWidth-LESCREEN_WIDTH-offset.x)];
    }
}
-(void) leReleaseView{
    [curTableView leReleaseView];
    curTableView=nil;
}
@end
//==========================================

@implementation LEExcelViewTableViewCellV2{
    UIView *viewMovableContainer;
    UIView *viewImmovableContainer;
}
-(id) initWithDelegate:(id<LETableViewCellSelectionDelegate>)delegate EnableGesture:(NSNumber *)gesture MovableWidth:(int) movable ImmovableWidth:(int) immovable CellHeight:(int) height{
    self.immovableWidth=immovable;
    self.leMovableWidth=movable;
    int cellHeight=height;
    self=[super initWithDelegate:delegate EnableGesture:gesture];
    [self setFrame:CGRectMake(0, 0, self.immovableWidth+self.leMovableWidth, cellHeight)];
    viewMovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    viewImmovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    self.leImmovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewImmovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(self.immovableWidth, cellHeight)]];
    self.leMovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewMovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.immovableWidth, 0) CGSize:CGSizeMake(self.leMovableWidth, cellHeight)]];
    [self leSetCellHeight:cellHeight];
    [self leExtraInits];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leOnExcelViewScrolledWith:) name:LEExcelViewNotification object:nil];
    return self;
}
-(void) leExtraInits{}
-(void) leOnExcelViewScrolledWith:(NSNotification *) info{
    if(info){
        id offsetx=[info.userInfo objectForKey:LEExcelViewNotification];
        if(offsetx){
            [self.leImmovableViewContainer leSetOffset:CGPointMake([offsetx floatValue], 0)];
        }
    }
}
-(void) dealloc{
    [self leReleaseView];
}
-(void) leReleaseView{
    [self.leImmovableViewContainer removeFromSuperview];
    [self.leMovableViewContainer removeFromSuperview];
    self.leSelectionDelegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LEExcelViewNotification object:nil];
    //    LELogInt(self.leIndexPath.row)
}
@end
@interface LEExcelViewTableViewV2 : LEBaseTableViewV2
@end
@implementation LEExcelViewTableViewV2{
    int immovableWidth;
    int movableWidth;
    int curHeight;
    int tabbarHeight;
    NSString *curTabbarClassName;
    LEExcelViewTabbar *curTabbar;
    NSMutableArray *cellCache;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int)immovable MovableViewWidth:(int)movable TabbarHeight:(int) tabbarH CellHeight:(int) height TabbarClassname:(NSString *) tabbarClassname{
    immovableWidth=immovable;
    movableWidth=movable;
    curHeight=height;
    tabbarHeight=tabbarH;
    curTabbarClassName=tabbarClassname;
    cellCache=[NSMutableArray new];
    return [super initWithSettings:settings];
}
-(UIView *) leViewForHeaderInSection:(NSInteger)section{
    if(!curTabbar){
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:immovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:tabbarHeight]};
        LESuppressPerformSelectorLeakWarning(
                                             curTabbar=[[curTabbarClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(immovableWidth+movableWidth, tabbarHeight)] withObject:dic];
                                             );
        [curTabbar setDelegate:self.leCellSelectionDelegate];
    }
    return curTabbar;
}
-(CGFloat) leHeightForSection:(NSInteger)section{
    return tabbarHeight;
}
-(void) leOnSetTabbarData:(id) data{
    [curTabbar leOnSetTabbarData:data];
}
//
-(void) leOnRefreshedWithData:(NSMutableArray *)data{
    [self leOnRefreshedDataToDataSource:data];
    //    LEWeakSelf(self);
    LEExcelViewTableViewV2 *weakself=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself onLoadDisplayCellWithRange:NSMakeRange(0, weakself.leCellCountAppended)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself leOnReloadTableViewForRefreshedDataSource];
            [weakself leOnStopTopRefresh];
        });
    });
}

-(void) leOnLoadedMoreWithData:(NSMutableArray *)data{
    [self leOnAppendedDataToDataSource:data];
    //    LEWeakSelf(self);
    LEExcelViewTableViewV2 *weakself=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself onLoadDisplayCellWithRange:NSMakeRange(weakself.leItemsArray.count-weakself.leCellCountAppended, weakself.leCellCountAppended)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself leOnReloadTableViewForAppendedDataSource];
            [weakself leOnStopBottomRefresh];
        });
    });
}
-(void) onLoadDisplayCellWithRange:(NSRange) range{
    if(!self.leDisplayCellCache){
        self.leDisplayCellCache=[NSMutableArray new];
    }
    for (NSInteger i=range.location; i<range.location+range.length; i++) {
        LEExcelViewTableViewCellV2 *cell=nil;
        if(i<self.leItemsArray.count){
            if(i<self.leDisplayCellCache.count){
                cell=[self.leDisplayCellCache objectAtIndex:i];
            }else{
                id obj=[self.leTableViewCellClassName leGetInstanceFromClassName];
                NSAssert([obj isKindOfClass:[LEBaseTableViewDisplayCell class]],([NSString stringWithFormat:@"请检查自定义DisplayCell是否继承于LEBaseTableViewDisplayCell：%@",self]));
                cell=obj;
                cell=[cell initWithDelegate:self.leCellSelectionDelegate EnableGesture:[NSNumber numberWithBool:self.leIsDisbaleTap] MovableWidth:movableWidth  ImmovableWidth:immovableWidth  CellHeight:curHeight];
                [self.leDisplayCellCache addObject:cell];
            }
            [cell leSetData:[self.leItemsArray objectAtIndex:i]];
        }
    }
}
-(void) leReleaseView{
    [super leReleaseView];
    [curTabbar leReleaseView];
    [curTabbar removeFromSuperview];
    curTabbar=nil;
    for (NSInteger i=0; i<cellCache.count; i++) {
        [[cellCache objectAtIndex:i] leReleaseView];
        [[cellCache objectAtIndex:i] removeFromSuperview];
    }
    [cellCache removeAllObjects];
    [self removeFromSuperview];
}
@end
@implementation LEExcelViewV2{
    int immovableWidth;
    int movableWidth;
    LEExcelViewTableViewV2 *curTableView;
    float lastOffsetX;
}
-(UITableView *) leGetTableView{
    return curTableView;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar{
    immovableWidth=immovable;
    movableWidth=movable;
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:settings.leParentView Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:settings.leParentView.bounds.size]];
    [self setContentSize:CGSizeMake(immovableWidth+movableWidth, self.bounds.size.height)];
    [self setDelegate:self];
    [self setContentInset:UIEdgeInsetsZero];
    [self setContentOffset:CGPointZero];
    UIView *tv=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(immovableWidth+movableWidth, self.bounds.size.height)]];
    [settings leSetParentView:tv];
    curTableView=[[LEExcelViewTableViewV2 alloc] initWithSettings:settings ImmovableViewWidth:immovable MovableViewWidth:movable TabbarHeight:tabbarH CellHeight:LEDefaultCellHeight TabbarClassname:tabbar];
    [curTableView leSetTopRefresh:NO];
    [curTableView leSetBottomRefresh:NO];
    return self;
}
-(void) leScrollToTop{
    [curTableView setContentOffset:CGPointZero animated:NO];
}
-(void) leOnRefreshedWithData:(NSMutableArray *) data{
    [curTableView leOnRefreshedWithData:data];
}
-(void) leOnSetTabbarData:(id) data{
    [curTableView leOnSetTabbarData:data];
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    if(offset.x<0)offset.x=0;
    if(lastOffsetX!=offset.x){
        [[NSNotificationCenter defaultCenter] postNotificationName:LEExcelViewNotification object:nil userInfo:@{LEExcelViewNotification:[NSNumber numberWithFloat:offset.x]}];
        lastOffsetX=offset.x;
        [curTableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, immovableWidth+movableWidth-LESCREEN_WIDTH-offset.x)];
    }
}
-(void) leReleaseView{
    [curTableView leReleaseView];
    curTableView=nil;
}
@end
