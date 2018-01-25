//
//  LEBaseEmptyTableViewCell.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/8/28.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h" 
@interface LEBaseEmptyTableViewCell : UITableViewCell
@property (nonatomic) NSDictionary *leCurSettings;
- (id)initWithSettings:(NSDictionary *) settings;
-(void) leCommendsFromTableView:(NSString *) commends;
@end
