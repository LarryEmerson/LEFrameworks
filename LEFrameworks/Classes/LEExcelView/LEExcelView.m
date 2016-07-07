//
//  LEExcelView.m
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/17.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import "LEExcelView.h"
@interface LEExcelViewTableViewCell ()
@property (nonatomic) LEExcelViewTableView *curTableView;
@end
@implementation LEExcelViewTableViewCell{
    UIView *viewMovableContainer;
    UIView *viewImmovableContainer;
}
- (id)initWithSettings:(LETableViewCellSettings *) settings UIParam:(NSDictionary *) param {
    self.immovableWidth=[[param objectForKey:@"immovable"] intValue];
    self.movableWidth=[[param objectForKey:@"movable"] intValue];
    int cellHeight=[[param objectForKey:@"height"] intValue];
    self=[super initWithSettings:settings];
    self.hasBottomSplit=NO;
    [self setFrame:CGRectMake(0, 0, self.immovableWidth+self.movableWidth, cellHeight)];
    viewMovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    viewImmovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    self.immovableView=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewImmovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(self.immovableWidth, cellHeight)]];
    self.movableView=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewMovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.immovableWidth, 0) CGSize:CGSizeMake(self.movableWidth, cellHeight)]];
    [self initUIForExcelView];
    return self;
}
-(void) initUIForExcelView{
    
}
-(void) setCurTableView:(LEExcelViewTableView *)curTableView{
    _curTableView=curTableView;
    [curTableView addObserver:self forKeyPath:@"swipOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"swipOffset"]){
        [self.immovableView leSetOffset:CGPointMake(self.curTableView.swipOffset, 0)];
    }
}
-(void) setData:(id)data IndexPath:(NSIndexPath *)path{
    [super setData:data IndexPath:path];
    [self.immovableView leSetOffset:CGPointMake(self.curTableView.swipOffset, 0)];
}
@end
@implementation LEExcelViewTabbar{
    LEExcelViewTableView *curTableView;
}
-(id) initWithSettings:(LEAutoLayoutSettings *)settings UIParam:(NSDictionary *) param{
    self=[super initWithAutoLayoutSettings:settings];
    int immovable=[[param objectForKey:@"immovable"] intValue];
    int movable  =[[param objectForKey:@"movable"] intValue];
    UIView *movableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    UIView *immovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    self.immovableView=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:immovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(immovable, self.bounds.size.height)]];
    self.movableView=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:movableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(immovable, 0) CGSize:CGSizeMake(movable, self.bounds.size.height)]];
    [self initUIForExcelViewTabbar];
    return self;
}
-(void) initUIForExcelViewTabbar{
    
}
-(void) onSetTabbarData:(id) data{
    
}
-(void) setSwipOffset:(int) offset{
    [self.immovableView leSetOffset:CGPointMake(offset, 0)];
}
-(void) addSwipObserver:(LEExcelViewTableView *)tableView{
    curTableView=tableView;
    [curTableView addObserver:self forKeyPath:@"swipOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"swipOffset"]){
        [self.immovableView leSetOffset:CGPointMake(curTableView.swipOffset, 0)];
    }
}
@end
@implementation LEExcelViewTableView{
    int immovableWidth;
    int movableWidth;
    int curHeight;
    int tabbarHeight;
    NSString *curTabbarClassName;
    LEExcelViewTabbar *curTabbar;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int)immovable MovableViewWidth:(int)movable TabbarHeight:(int) tabbarH CellHeight:(int) height TabbarClassname:(NSString *) tabbarClassname{
    immovableWidth=immovable;
    movableWidth=movable;
    curHeight=height;
    tabbarHeight=tabbarH;
    curTabbarClassName=tabbarClassname;
    return [super initWithSettings:settings];
}
-(UIView *) _viewForHeaderInSection:(NSInteger)section{
    if(!curTabbar){
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:immovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:tabbarHeight]};
        SuppressPerformSelectorLeakWarning(
                                           curTabbar=[[curTabbarClassName getInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(immovableWidth+movableWidth, tabbarHeight)] withObject:dic];
                                           );
        [curTabbar addSwipObserver:self];
    }
    return curTabbar;
}
-(CGFloat) _heightForSection:(NSInteger)section{
    return tabbarHeight;
}
-(void) onSetTabbarData:(id) data{
    [curTabbar onSetTabbarData:data];
}
-(UITableViewCell *) _cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LEExcelViewTableViewCell *cell=[self dequeueReusableCellWithIdentifier:CommonTableViewReuseableCellIdentifier];
    if(!cell){
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:immovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:curHeight]};
        SuppressPerformSelectorLeakWarning(
                                           cell=[[self.tableViewCellClassName getInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.cellSelectionDelegate EnableGesture:NO] withObject:dic];
                                           );
        [cell setCurTableView:self];
    }
    
    if(self.itemsArray&&indexPath.row<self.itemsArray.count){
        SuppressPerformSelectorLeakWarning(
                                           [cell performSelector:NSSelectorFromString(@"setData:IndexPath:") withObject:[self.itemsArray objectAtIndex:indexPath.row] withObject:indexPath];
                                           );
    }
    return cell;
}
@end

@implementation LEExcelView{
    int immovableWidth;
    int movableWidth;
    LEExcelViewTableView *curTableView;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar{
    immovableWidth=immovable;
    movableWidth=movable;
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:settings.parentView Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:settings.parentView.bounds.size]];
    [self setContentSize:CGSizeMake(immovableWidth+movableWidth, self.bounds.size.height)];
    [self setDelegate:self];
    [self setContentInset:UIEdgeInsetsZero];
    [self setContentOffset:CGPointZero]; 
    UIView *tv=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(immovableWidth+movableWidth, self.bounds.size.height)]];
    [settings setParentView:tv];
    curTableView=[[LEExcelViewTableView alloc] initWithSettings:settings ImmovableViewWidth:immovable MovableViewWidth:movable TabbarHeight:tabbarH CellHeight:DefaultCellHeightBig TabbarClassname:tabbar];
    [curTableView setTopRefresh:NO];
    [curTableView setBottomRefresh:NO];
    return self;
}
-(void) onRefreshedWithData:(NSMutableArray *) data{
    [curTableView onRefreshedWithData:data];
}
-(void) onSetTabbarData:(id) data{
    [curTableView onSetTabbarData:data];
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    if(offset.x<0)offset.x=0;
    [curTableView setSwipOffset:offset.x]; 
}
@end
