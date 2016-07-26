//
//  LERefresh.h
//  Pods
//
//  Created by emerson larry on 16/7/11.
//
//

#import <Foundation/Foundation.h>
#import "LEFrameworks.h"

typedef void(^LERefreshBlock)(void);

#define LERefreshStringLoading  @"加载中..."
#define LERefreshStringPullDown @"下拉刷新"
#define LERefreshStringPullUp   @"上拉刷新"
#define LERefreshStringRelease  @"松开即可刷新"

typedef NS_ENUM(NSInteger, LERefreshState) {
    //Inside
    LERefreshBegin = 0,
    LERefreshRelease = 1,
    LERefreshLoading =2,
};

@interface LERefresh : NSObject

@property (nonatomic) UIScrollView *curScrollView;
@property (nonatomic) UIView *refreshContainer;
@property (nonatomic) BOOL isEnabled; 
@property (nonatomic, copy) LERefreshBlock refreshBlock;
@property (nonatomic) NSString *beginRefreshString;
@property (nonatomic) NSString *loadingString;
@property (nonatomic) NSString *refreshReleaseString;
@property (nonatomic) LERefreshState curRefreshState;
@property (nonatomic) UIActivityIndicatorView *curIndicator;
@property (nonatomic) UILabel *curRefreshLabel;
-(instancetype) initWithTarget:(UIScrollView *) scrollview;
-(void) initRefreshView;
-(void) onBeginRefresh;
-(void) onEndRefresh;
-(void) onScrolling NS_REQUIRES_SUPER;
@end

@interface LERefreshHeader : LERefresh
@end
@interface LERefreshFooter : LERefresh
-(void) onSetCollectionViewContentInsects:(UIEdgeInsets ) insects;
@end