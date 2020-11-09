//
//  LEBaseCollectionViewWithRefresh.h
//  Pods
//
//  Created by emerson larry on 16/7/25.
//
//

#import "LEBaseCollectionView.h"
#import "LERefresh.h"


@interface LEBaseCollectionViewWithRefresh : LEBaseCollectionView
/** 为了解决CollectionView 使用FlowLayout后设置了SectionInsects，如果cell内容没有撑满Frame则会造成上啦刷新的位置有偏差*/
-(void) leOnSetContentInsects:(UIEdgeInsets) insects;
@end
