//
//  LEBaseTableViewCell.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LEBaseTableView.h" 
#import "LEUIFramework.h"

@protocol LETableViewCellSelectionDelegate <NSObject>
/** Cell点击后触发，Key：LEKeyOfIndexPath、LEKeyOfClickStatus... */
-(void) leOnTableViewCellSelectedWithInfo:(NSDictionary *) info;
@end
@interface LETableViewCellSettings : NSObject
@property (nonatomic, readonly) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
/** 默认 UITableViewCellStyleDefault */
@property (nonatomic, readonly) UITableViewCellStyle leStyle;
/** 不同的类型的Cell需要设置不同的值。 */
@property (nonatomic, readonly) NSString *leReuseIdentifier;
/** 是否加上默认的点击事件，注意：添加默认的点击事件不利于Cell扩展其他的点击事件 */
@property (nonatomic, readonly) BOOL leGesture;
-(void) leSetGesture:(BOOL) gesture;
/** 默认点击事件、Identifier */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate;
/** 默认Identifier，gesture：是否添加默认点击事件 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate EnableGesture:(BOOL) gesture;
/** 默认点击事件，自定义reuseIdentifier */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier;
/** 自定义是否开启默认点击事件及reuseIdentifier */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture;
/** 不建议使用 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier;
/** 不建议使用 */
-(id) initWithSelectionDelegate:(id<LETableViewCellSelectionDelegate>) delegate TableViewCellStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *) reuseIdentifier  EnableGesture:(BOOL) gesture;
@end
@interface LEBaseTableViewCell : UITableViewCell 
@property (nonatomic, weak) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic, readonly) BOOL leHasTopSplit;
@property (nonatomic, readonly) BOOL leHasBottomSplit; 
@property (nonatomic, readonly) BOOL leHasArrow;  
@property (nonatomic) UILabel *leTitle;
@property (nonatomic) UIButton *leTapEffect;
@property (nonatomic) NSIndexPath *leIndexPath;
//
- (id)initWithSettings:(LETableViewCellSettings *)settings;
-(void) onSetSettings:(LETableViewCellSettings *) settings;
//
-(void) leAdditionalInitsForTopViews;
-(void) leSetBottomSplit:(BOOL) hasSplit;
-(void) leSetBottomSplit:(BOOL) hasSplit Width:(int) width;
-(void) leSetBottomSplit:(BOOL) hasSplit Width:(int) width Offset:(CGPoint) offset;
-(void) leSetEnableArrow:(BOOL)leHasArrow;
-(void) leSetCellHeight:(int) height;
-(void) leSetCellHeight:(int) height TapWidth:(int) width ;
-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path NS_REQUIRES_SUPER;
-(void) leOnCellSelectedWithInfo:(NSDictionary *) info;
-(void) leOnCellSelectedWithIndex:(NSInteger) index;
@end
