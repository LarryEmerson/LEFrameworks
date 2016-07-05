
//
//  LEDataDelegate.h
//  LEFrameworks
//
//  Created by Larry Emerson on 15/8/27.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#ifndef LEFrameworks_LEDataDelegate_h
#define LEFrameworks_LEDataDelegate_h

@protocol LETableViewCellSelectionDelegate <NSObject>
-(void) onTableViewCellSelectedWithInfo:(NSDictionary *) info;
@end

@protocol LEGetDataDelegate <NSObject>
-(void) onRefreshData;
@optional
-(void) onLoadMore;
@end


//@protocol LESetDataDelegate <NSObject> 
//-(void) onRefreshedData:(NSMutableArray *) data;
//-(void) onLoadedMoreData:(NSMutableArray *) data;
//@end

#endif
