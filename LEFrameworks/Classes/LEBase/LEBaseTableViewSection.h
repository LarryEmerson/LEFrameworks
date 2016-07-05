//
//  LEBaseTableViewSection.h
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/5.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h" 

@interface LEBaseTableViewSection : UIView
@property (nonatomic) UIImageView *curSplit;
@property (nonatomic) UILabel *labelTitle;
-(id) initWithSectionText:(NSString *) text;
-(id) initWithSectionText:(NSString *) text Height:(int) heiht;
-(id) initWithSectionText:(NSString *) text Height:(int) heiht Split:(BOOL) split;
-(id) initWithSectionText:(NSString *)text Color:(UIColor *)color  Height:(int)heiht Split:(BOOL)split;
@end
