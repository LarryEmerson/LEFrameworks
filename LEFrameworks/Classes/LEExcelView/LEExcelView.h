//
//  LEExcelView.h
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/17.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h"
#import "LEBaseTableViewCell.h"

@interface LEExcelView : UIScrollView<UIScrollViewDelegate>
-(id) initWithSettings:(LETableViewSettings *)settings ImmovableViewWidth:(int) immovable MovableViewWidth:(int) movable TabbarHeight:(int) tabbarH TabbarClassname:(NSString *) tabbar;
-(void) onRefreshedWithData:(NSMutableArray *) data;
-(void) onSetTabbarData:(id) data;
@end
@interface LEExcelViewTableView : LEBaseTableView
@property (nonatomic) int swipOffset;
@end
@interface LEExcelViewTableViewCell : LEBaseTableViewCell
@property (nonatomic) UIView *immovableView;
@property (nonatomic) UIView *movableView;
@property (nonatomic) int immovableWidth;
@property (nonatomic) int movableWidth;
-(void) initUIForExcelView; 
@end
@interface LEExcelViewTabbar : UIView
@property (nonatomic) UIView *immovableView;
@property (nonatomic) UIView *movableView; 
-(void) initUIForExcelViewTabbar;
-(void) onSetTabbarData:(id) data;
@end