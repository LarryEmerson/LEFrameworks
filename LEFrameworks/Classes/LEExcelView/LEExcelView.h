//
//  LEExcelView.h
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/17.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "LEBaseTableViewV2.h"
#import "LEBaseTableViewCell.h"
#define LEExcelViewNotification @"LEExcel"
@interface LEExcelView : UIScrollView<UIScrollViewDelegate>
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar;
-(void) leOnRefreshedWithData:(NSMutableArray *) data;
-(void) leOnSetTabbarData:(id) data;
-(void) leScrollToTop;
-(UITableView *) leGetTableView;
@end
@interface LEExcelViewTableViewCell : LEBaseTableViewCell
@property (nonatomic) UIView *leImmovableViewContainer;
@property (nonatomic) UIView *leMovableViewContainer;
@property (nonatomic) int immovableWidth;
@property (nonatomic) int leMovableWidth;
@end

@interface LEExcelViewTabbar : UIView
@property (nonatomic) UIView *leImmovableViewContainer;
@property (nonatomic) UIView *leMovableViewContainer;
@property (nonatomic, weak) id<LETableViewCellSelectionDelegate> delegate;
-(void) leOnSetTabbarData:(id) data;
-(void) leExtraInits NS_REQUIRES_SUPER;
@end
@interface LEExcelViewTableViewCellV2 : LEBaseTableViewDisplayCell
@property (nonatomic) UIView *leImmovableViewContainer;
@property (nonatomic) UIView *leMovableViewContainer;
@property (nonatomic) int immovableWidth;
@property (nonatomic) int leMovableWidth;
-(void) leExtraInits NS_REQUIRES_SUPER;
@end
@interface LEExcelViewV2 : UIScrollView<UIScrollViewDelegate>
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar;
-(void) leOnRefreshedWithData:(NSMutableArray *) data;
-(void) leOnSetTabbarData:(id) data;
-(void) leScrollToTop;
-(UITableView *) leGetTableView;
@end
