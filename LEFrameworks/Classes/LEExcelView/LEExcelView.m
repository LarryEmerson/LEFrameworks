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
    self.leImmovableWidth=[[param objectForKey:@"immovable"] intValue];
    self.leMovableWidth=[[param objectForKey:@"movable"] intValue];
    int cellHeight=[[param objectForKey:@"height"] intValue];
    self=[super initWithSettings:settings];
    [self leSetBottomSplit:NO Width:0]; 
    
    [self setFrame:CGRectMake(0, 0, self.leImmovableWidth+self.leMovableWidth, cellHeight)];
    viewMovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    viewImmovableContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
    self.leImmovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewImmovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(self.leImmovableWidth, cellHeight)]];
    self.leMovableViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewMovableContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.leImmovableWidth, 0) CGSize:CGSizeMake(self.leMovableWidth, cellHeight)]];
    [self leExtraInits];
    return self;
} 
-(void) setCurTableView:(LEExcelViewTableView *)curTableView{
    _curTableView=curTableView;
    [curTableView addObserver:self forKeyPath:@"leSwipOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"leSwipOffset"]){
        [self.leImmovableViewContainer leSetOffset:CGPointMake(self.curTableView.leSwipOffset, 0)];
    }
}
-(void) leSetData:(id)data IndexPath:(NSIndexPath *)path{
    [super leSetData:data IndexPath:path];
    [self.leImmovableViewContainer leSetOffset:CGPointMake(self.curTableView.leSwipOffset, 0)];
}
@end
@implementation LEExcelViewTabbar{
    LEExcelViewTableView *curTableView;
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
}
-(void) leOnSetTabbarData:(id) data{
    
} 
-(void) addSwipObserver:(LEExcelViewTableView *)tableView{
    curTableView=tableView;
    [curTableView addObserver:self forKeyPath:@"leSwipOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"leSwipOffset"]){
        [self.leImmovableViewContainer leSetOffset:CGPointMake(curTableView.leSwipOffset, 0)];
    }
}
@end
@interface LEExcelViewTableView ()
@property (nonatomic, readwrite) int leSwipOffset;
@end
@implementation LEExcelViewTableView{
    int leImmovableWidth;
    int movableWidth;
    int curHeight;
    int tabbarHeight;
    NSString *curTabbarClassName;
    LEExcelViewTabbar *curTabbar;
}
-(void) leSetSwipOffset:(int) offset{
    self.leSwipOffset=offset;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int)immovable MovableViewWidth:(int)movable TabbarHeight:(int) tabbarH CellHeight:(int) height TabbarClassname:(NSString *) tabbarClassname{
    leImmovableWidth=immovable;
    movableWidth=movable;
    curHeight=height;
    tabbarHeight=tabbarH;
    curTabbarClassName=tabbarClassname;
    return [super initWithSettings:settings];
}
-(UIView *) leViewForHeaderInSection:(NSInteger)section{
    if(!curTabbar){
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:leImmovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:tabbarHeight]};
        LESuppressPerformSelectorLeakWarning(
                                             curTabbar=[[curTabbarClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(leImmovableWidth+movableWidth, tabbarHeight)] withObject:dic];
                                             );
        [curTabbar setDelegate:self.leCellSelectionDelegate];
        [curTabbar addSwipObserver:self];
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
        NSDictionary *dic=@{@"immovable":[NSNumber numberWithInt:leImmovableWidth],@"movable":[NSNumber numberWithInt:movableWidth],@"height":[NSNumber numberWithInt:curHeight]};
        LESuppressPerformSelectorLeakWarning(
                                             cell=[[self.leTableViewCellClassName leGetInstanceFromClassName] performSelector:NSSelectorFromString(@"initWithSettings:UIParam:") withObject:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.leCellSelectionDelegate EnableGesture:NO] withObject:dic];
                                             );
        [cell setCurTableView:self];
    }
    
    if(self.leItemsArray&&indexPath.row<self.leItemsArray.count){
        LESuppressPerformSelectorLeakWarning(
                                             [cell performSelector:NSSelectorFromString(@"leSetData:IndexPath:") withObject:[self.leItemsArray objectAtIndex:indexPath.row] withObject:indexPath];
                                             );
    }
    return cell;
}
@end

@implementation LEExcelView{
    int leImmovableWidth;
    int movableWidth;
    LEExcelViewTableView *curTableView;
}
-(UITableView *) leGetTableView{
    return curTableView;
}
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar{
    leImmovableWidth=immovable;
    movableWidth=movable;
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:settings.leParentView Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:settings.leParentView.bounds.size]];
    [self setContentSize:CGSizeMake(leImmovableWidth+movableWidth, self.bounds.size.height)];
    [self setDelegate:self];
    [self setContentInset:UIEdgeInsetsZero];
    [self setContentOffset:CGPointZero]; 
    UIView *tv=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointZero CGSize:CGSizeMake(leImmovableWidth+movableWidth, self.bounds.size.height)]];
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
    [curTableView leSetSwipOffset:offset.x];
}
@end
