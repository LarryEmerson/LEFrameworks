//
//  LEBaseTableViewV2.h
//  Pods
//
//  Created by emerson larry on 16/9/3.
//
//

#import <UIKit/UIKit.h>
#import "LEBaseTableView.h"
#import "LEUIFrameworkExtra.h"
#import "LERefresh.h"
#import "LEBaseTableViewDisplayCell.h" 
@interface LEBaseTableViewCellV2 : UITableViewCell
-(void) leSetDisplayCell:(LEBaseTableViewDisplayCell *) cell;
@end
@interface LEBaseTableViewV2 : LEBaseTableView
@property (nonatomic) NSMutableArray *leDisplayCellCache; 
@end
@interface LEBaseTableViewV2WithRefresh : LEBaseTableViewV2 
@end
