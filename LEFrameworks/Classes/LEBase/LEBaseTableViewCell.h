//
//  LEBaseTableViewCell.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h" 
#import "LEUIFramework.h"

@interface LEBaseTableViewCell : UITableViewCell 
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic, readonly) BOOL leHasTopSplit;
@property (nonatomic, readonly) BOOL leHasBottomSplit; 
@property (nonatomic, readonly) BOOL leHasArrow;  
@property (nonatomic) UILabel *leTitle;
@property (nonatomic) UIButton *leTapEffect;
@property (nonatomic) NSIndexPath *leIndexPath;
//
- (id)initWithSettings:(LETableViewCellSettings *)settings;
//
-(void) leExtraInitsForTopViews;
-(void) leSetBottomSplit:(BOOL) hasSplit;
-(void) leSetBottomSplit:(BOOL) hasSplit Width:(int) width;
-(void) leSetBottomSplit:(BOOL) hasSplit Width:(int) width Offset:(CGPoint) offset;
-(void) leSetEnableArrow:(BOOL)leHasArrow;
-(void) leSetCellHeight:(int) height;
-(void) leSetCellHeight:(int) height TapWidth:(int) width ;
-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path NS_REQUIRES_SUPER;
-(void) leOnCellSelectedWithIndex:(int) index;
@end
