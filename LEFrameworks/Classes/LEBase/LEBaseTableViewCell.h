//
//  LEBaseTableViewCell.h
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h"


@interface LEBaseTableViewCell : UITableViewCell 
@property (nonatomic) id<LETableViewCellSelectionDelegate> selectionDelegate;
@property (nonatomic) LEUIFramework *globalVar;
@property (nonatomic) BOOL hasTopSplit;
@property (nonatomic) BOOL hasBottomSplit;
@property (nonatomic) int bottomSplitSpace;
@property (nonatomic) BOOL hasArrow; 
//
@property (nonatomic) int CellLeftSpace;
@property (nonatomic) int CellRightSpace;
//
@property (nonatomic) UIImageView *curArrow;
@property (nonatomic) UIImageView *curBottomSplit;
//
- (id)initWithSettings:(LETableViewCellSettings *)settings;
@property (nonatomic) UILabel *curTitle;
//
-(void) initUI;
-(void) initTopClickUIS;
-(void) setBottomSplit:(BOOL) hasSplit Width:(int) width;
-(void) setBottomSplit:(BOOL) hasSplit Width:(int) width Offset:(CGPoint) offset;
-(void) setEnableArrow:(BOOL)hasArrow;
-(void) setCellHeight:(int) height;
-(void) setCellHeight:(int) height TapWidth:(int) width ;
@property (nonatomic) UIButton *tapEffect;
@property (nonatomic) NSIndexPath *curIndexPath;
-(void) setData:(id) data IndexPath:(NSIndexPath *) path NS_REQUIRES_SUPER;
-(void) onCellSelectedWithIndex:(int) index;
@end
