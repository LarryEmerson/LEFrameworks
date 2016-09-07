//
//  LEBaseTableViewV2.h
//  Pods
//
//  Created by emerson larry on 16/9/3.
//
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h"
#import "LEUIFrameworkExtra.h"
#import "LERefresh.h"
@interface LEBaseTableViewDisplayCell:UIView
@property (nonatomic) id leData;
@property (nonatomic) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic) NSIndexPath *leIndexPath;
@property (nonatomic) UIButton *leSelfTapEvent;
-(id) initWithDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(NSNumber *) gesture;
-(void) leSetData:(id)data NS_REQUIRES_SUPER;
-(void) leSetIndex:(NSIndexPath *)index;
-(void) leOnCellSelectedWithInfo:(NSDictionary *) info;
-(void) leOnCellSelectedWithIndex:(int) index;
-(void) leSetCellHeight:(CGFloat) height;
-(CGFloat) leGetHeight;
@end
@interface LEBaseTableViewCellV2 : UITableViewCell
-(void) leSetDisplayCell:(LEBaseTableViewDisplayCell *) cell;
@end
@interface LEBaseTableViewV2 : LEBaseTableView
@property (nonatomic) NSMutableArray *leDisplayCellCache; 
@end
@interface LEBaseTableViewV2WithRefresh : LEBaseTableViewV2 
@end
