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
@property (nonatomic) LEUIFramework *globalVar; 
@property (nonatomic) NSDictionary *curSettings;
- (id)initWithSettings:(NSDictionary *) settings;
-(void) initUI;
-(void) commendsFromTableView:(NSString *) commends;
@end
