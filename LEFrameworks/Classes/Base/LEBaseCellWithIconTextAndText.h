//
//  LEBaseCellWithIconTextAndText.h
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewCell.h" 
@interface LEBaseCellWithIconTextAndText : LEBaseTableViewCell
@property (nonatomic) UILabel *labelRight;
-(void) initUIWithData;
-(void) setIcon:(NSString *) icon LeftText:(NSString *) left RightText:(NSString *) right;
@end
