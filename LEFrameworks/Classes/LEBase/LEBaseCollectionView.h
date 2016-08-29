//
//  LEBaseCollectionView.h
//  LEFrameworks
//
//  Created by emerson larry on 16/7/21.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEUIFramework.h"
#define LEReuseableCollectionCellIdentifier @"LECollectionCell"
#define LEReuseableCollectionViewIdentifier @"LECollectionView"
@protocol LECollectionViewCellSelectionDelegate <NSObject>
-(void) leOnCollectionCellSelectedWithInfo:(NSDictionary *) info;
@end
@protocol LECollectionViewDataSourceDelegate <NSObject>
-(void) leOnRefreshDataForCollection;
@optional
-(void) leOnLoadMoreForCollection;
@end

@interface LECollectionViewSettings : NSObject
@property (nonatomic, readonly) LEAutoLayoutSettings *leSettings;
@property (nonatomic, readonly) UICollectionViewLayout *leLayout;
@property (nonatomic, readonly) NSString *leCellClassname;
@property (nonatomic, readonly) NSString *leReusableViewClassname;
@property (nonatomic, readonly) id<LECollectionViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readonly) id<LECollectionViewCellSelectionDelegate> leCellSelectionDelegate;
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings CollectionLayout:(UICollectionViewLayout *) layout CellClassname:(NSString *) cellClassname DataSource:(id<LECollectionViewDataSourceDelegate>) dataSource CellSelectionDelegate:(id<LECollectionViewCellSelectionDelegate>) selection;
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings CollectionLayout:(UICollectionViewLayout *) layout CellClassname:(NSString *) cellClassname ReusableView:(NSString *) reusableClassname DataSource:(id<LECollectionViewDataSourceDelegate>) dataSource CellSelectionDelegate:(id<LECollectionViewCellSelectionDelegate>) selection;
@end
@class LEBaseCollectionView;
@interface LEBaseCollectionViewCell : UICollectionViewCell
@property (nonatomic) LEBaseCollectionView *leCollectionView;
@property (nonatomic) BOOL isInited;
@property (nonatomic, readonly) NSIndexPath *leIndexPath;
-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path;
@end
@interface LEBaseCollectionReusableView : UICollectionReusableView
@property (nonatomic) BOOL isInited;
@property (nonatomic, readonly) NSIndexPath *leIndexPath;
-(void) leSetData:(id) data Kind:(NSString *) kind IndexPath:(NSIndexPath *) path;
@end
@interface LEBaseCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, readonly) NSMutableArray *leItemsArray;
@property (nonatomic, readonly) id<LECollectionViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readonly) id<LECollectionViewCellSelectionDelegate> leCellSelectionDelegate;
@property (nonatomic, readwrite) NSMutableArray *leSectionHeaderArray;
-(instancetype) initWithSettings:(LECollectionViewSettings *) settings;
//
-(void) leSetTopRefresh:(BOOL) enable;
-(void) leSetBottomRefresh:(BOOL) enable;
-(void) leAutoDeselectCellAfterSelection:(BOOL) enable;
-(void) leOnStopTopRefresh;
-(void) leOnStopBottomRefresh;
-(void) leOnAutoRefresh;
-(void) leOnAutoRefreshWithDuration:(float) duration;
-(void) leOnRefreshedWithData:(NSMutableArray *)data;
-(void) leOnLoadedMoreWithData:(NSMutableArray *)data;
-(void) leSelectCellAtIndex:(NSIndexPath *)index;
-(void) leDeselectCellAtIndex:(NSIndexPath *) index;
-(NSInteger)leCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
-(UICollectionViewCell *)leCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)leNumberOfSectionsInCollectionView:(UICollectionView *)collectionView;
@end

@interface LEVerticalFlowLayout : UICollectionViewFlowLayout
typedef CGFloat(^LEVerticalFlowLayoutCellHeight)(id data, NSIndexPath *index);
-(void) leSetCollectionView:(LEBaseCollectionView *) target CellHeightGetter:(LEVerticalFlowLayoutCellHeight) block;
@end

@interface LEHorizontalFlowLayout : UICollectionViewFlowLayout
typedef CGFloat(^LEHorizontalFlowLayoutCellWidth)(id data, NSIndexPath *index);
-(void) leSetCollectionView:(LEBaseCollectionView *) target CellWidthGetter:(LEHorizontalFlowLayoutCellWidth) block;
@end