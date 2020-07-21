//
//  LEBaseTableViewV2.m
//  Pods
//
//  Created by emerson larry on 16/9/3.
//
//

#import "LEBaseTableViewV2.h"

@implementation LEBaseTableViewCellV2{
    LEBaseTableViewDisplayCell *lastCell;
}
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LEDefaultCellHeight)];
    return self;
}
-(void) leSetDisplayCell:(LEBaseTableViewDisplayCell *)cell{
    if(lastCell){
        [lastCell setHidden:YES];
    }
    [cell setHidden:NO];
    [self addSubview:cell];
    [self setFrame:CGRectMake(0, 0, LESCREEN_WIDTH, cell.leGetHeight)];
    lastCell=cell;
}
@end

@implementation LEBaseTableViewV2
-(void) dealloc{
    for (NSInteger i=0; i<self.leDisplayCellCache.count; i++) {
        [[self.leDisplayCellCache objectAtIndex:i] removeFromSuperview];
    }
    [self.leDisplayCellCache removeAllObjects];
    [self.leItemsArray removeAllObjects];
}
-(void) leOnRefreshedWithData:(NSMutableArray *)data{
    [self leOnRefreshedDataToDataSource:data];
    LEWeakSelf(self);
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
    LEWeakSelf(self);
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
        LEBaseTableViewDisplayCell *cell=nil;
        if(i<self.leItemsArray.count){
            if(i<self.leDisplayCellCache.count){
                cell=[self.leDisplayCellCache objectAtIndex:i];
            }else{
                id obj=[self.leTableViewCellClassName leGetInstanceFromClassName];
                NSAssert([obj isKindOfClass:[LEBaseTableViewDisplayCell class]],([NSString stringWithFormat:@"请检查自定义DisplayCell是否继承于LEBaseTableViewDisplayCell：%@",self]));
                cell=obj;
                cell=[cell initWithDelegate:self.leCellSelectionDelegate EnableGesture:[NSNumber numberWithBool:self.leIsDisbaleTap]];
                [self.leDisplayCellCache addObject:cell];
            }
            [cell leSetData:[self.leItemsArray objectAtIndex:i]];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row<self.leDisplayCellCache.count){
        return [[self.leDisplayCellCache objectAtIndex:indexPath.row] leGetHeight];
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
}
-(UITableViewCell *) leCellForRowAtIndexPath:(NSIndexPath *) indexPath{
    LEBaseTableViewCellV2 *cell=[self dequeueReusableCellWithIdentifier:LEReuseableCellIdentifier];
    if(!cell){
        cell=[[LEBaseTableViewCellV2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LEReuseableCellIdentifier];
    }
    if(self.leDisplayCellCache&&indexPath.row<self.leDisplayCellCache.count){
        LEBaseTableViewDisplayCell *disCell=[self.leDisplayCellCache objectAtIndex:indexPath.row];
        [cell leSetDisplayCell:disCell];
        [disCell leSetIndex:indexPath];
    }
    return cell;
}
@end

@implementation LEBaseTableViewV2WithRefresh{
    LERefreshHeader *refreshHeader;
    LERefreshFooter *refreshFooter;
}
-(void) leAdditionalInits{
    [super leAdditionalInits];
    refreshHeader=[[LERefreshHeader alloc] initWithTarget:self];
    typeof(self) __weak weakSelf = self;
    refreshHeader.refreshBlock=^(){
        LESuppressPerformSelectorLeakWarning( [weakSelf performSelector:NSSelectorFromString(@"onDelegateRefreshData")]; );
    };
    refreshFooter=[[LERefreshFooter alloc] initWithTarget:self];
    refreshFooter.refreshBlock=^(){
        LESuppressPerformSelectorLeakWarning( [weakSelf performSelector:NSSelectorFromString(@"onDelegateLoadMore")]; );
    };
}
-(void) leOnAutoRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshHeader onBeginRefresh];
    });
}
-(void) leSetTopRefresh:(BOOL) enable{
    refreshHeader.isEnabled=enable;
}
-(void) leSetBottomRefresh:(BOOL) enable{
    refreshFooter.isEnabled=enable;
}
-(void) leOnStopTopRefresh {
    [self onStopRefreshLogic];
}
-(void) leOnStopBottomRefresh {
    [self onStopRefreshLogic];
}
-(void) onStopRefreshLogic{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshHeader onEndRefresh];
        [refreshFooter onEndRefresh];
    });
}

@end








