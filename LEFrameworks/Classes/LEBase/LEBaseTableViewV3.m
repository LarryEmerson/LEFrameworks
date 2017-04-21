//
//  LEBaseTableViewV3.m
//  Pods
//
//  Created by emerson larry on 2016/12/16.
//
//

#import "LEBaseTableViewV3.h"

@implementation LEBaseTableViewV3{
    LEBaseTableViewCell *cellForHeightCalc;
    LEBaseEmptyTableViewCell *emptyCellForHeightCalc;
} 
-(void) leAdditionalInits{
    [self registerClass:NSClassFromString(self.leTableViewCellClassName) forCellReuseIdentifier:self.leTableViewCellClassName];
}
-(UITableViewCell *) leCellForRowAtIndexPath:(NSIndexPath *) indexPath{
    if(indexPath.section==0){
        LEBaseTableViewCell *cell=[self dequeueReusableCellWithIdentifier:LEReuseableCellIdentifier forIndexPath:indexPath];
        if(!cell){ 
            [cell onSetSettings:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.leCellSelectionDelegate EnableGesture:!self.leIsDisbaleTap]];
        }
        if(self.leItemsArray&&indexPath.row<self.leItemsArray.count){
            [cell leSetData:[self.leItemsArray objectAtIndex:indexPath.row] IndexPath:indexPath];
        }
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && [self leNumberOfRowsInSection:0]==0 && [self leNumberOfSections] <=1){
        if(!emptyCellForHeightCalc){
            emptyCellForHeightCalc=[(LEBaseEmptyTableViewCell *)[self.leEmptyTableViewCellClassName leGetInstanceFromClassName] initWithSettings:@{LEKeyOfCellTitle:@"暂时还没有相关内容"}];
        }
        return emptyCellForHeightCalc.bounds.size.height;
    }else{
        if(!cellForHeightCalc){
            cellForHeightCalc=[(LEBaseTableViewCell *)[self.leTableViewCellClassName leGetInstanceFromClassName] initWithSettings:[[LETableViewCellSettings alloc] initWithSelectionDelegate:self.leCellSelectionDelegate reuseIdentifier:self.leTableViewCellClassName EnableGesture:!self.leIsDisbaleTap]];
        }
        if(indexPath.row<self.leItemsArray.count){
            [cellForHeightCalc leSetData:[self.leItemsArray objectAtIndex:indexPath.row] IndexPath:indexPath];
        }
        return cellForHeightCalc.bounds.size.height;
    }
}
@end
