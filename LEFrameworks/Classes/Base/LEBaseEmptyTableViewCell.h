//
//  LEBaseEmptyTableViewCell.h
//  four23
//
//  Created by Larry Emerson on 15/8/28.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h"
 
@interface LEBaseEmptyTableViewCell : UITableViewCell
@property (nonatomic) LEUIFramework *globalVar; 
@property (nonatomic) NSDictionary *curSettings;
- (id)initWithSettings:(NSDictionary *) settings;
-(void) initUI;
-(void) commendsFromTableView:(NSString *) commends;
@end
