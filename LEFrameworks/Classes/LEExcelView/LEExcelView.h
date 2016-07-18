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
-(void) leOnRefreshedWithData:(NSMutableArray *) data;
-(void) leOnSetTabbarData:(id) data;
@end
@interface LEExcelViewTableView : LEBaseTableView
@property (nonatomic, readonly) int leSwipOffset;
-(void) leSetSwipOffset:(int) offset;
@end
@interface LEExcelViewTableViewCell : LEBaseTableViewCell
@property (nonatomic) UIView *leImmovableViewContainer;
@property (nonatomic) UIView *leMovableViewContainer;
@property (nonatomic) int leImmovableWidth;
@property (nonatomic) int leMovableWidth;
@end
@interface LEExcelViewTabbar : UIView
@property (nonatomic) UIView *leImmovableViewContainer;
@property (nonatomic) UIView *leMovableViewContainer; 
-(void) leOnSetTabbarData:(id) data;
@end
