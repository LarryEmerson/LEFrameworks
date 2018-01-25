//
//  LEBaseTableViewDisplayCell.h
//  Pods
//
//  Created by emerson larry on 16/9/12.
//
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h"
#import "LEUIFrameworkExtra.h"
@interface LEBaseTableViewDisplayCell : UIView
@property (nonatomic) id leData;
@property (nonatomic, weak) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic) NSIndexPath *leIndexPath;
@property (nonatomic) UIButton *leSelfTapEvent;
-(id) initWithDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(NSNumber *) gesture;
-(void) leSetData:(id)data NS_REQUIRES_SUPER;
-(void) leSetIndex:(NSIndexPath *)index;
-(void) leOnIndexSet;
-(void) leOnCellSelectedWithInfo:(NSDictionary *) info;
-(void) leOnCellSelectedWithIndex:(int) index;
-(void) leSetCellHeight:(CGFloat) height;
-(CGFloat) leGetHeight;
@end
