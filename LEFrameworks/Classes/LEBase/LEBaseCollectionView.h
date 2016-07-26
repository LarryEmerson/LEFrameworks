//
//  LEBaseCollectionView.h
//  LEFrameworks
//
//  Created by emerson larry on 16/7/21.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEUIFramework.h"
#define LEReuseableCollectionCellIdentifier @"LECollectionCell"
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
@property (nonatomic, readonly) id<LECollectionViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readonly) id<LECollectionViewCellSelectionDelegate> leCellSelectionDelegate;
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings CollectionLayout:(UICollectionViewLayout *) layout CellClassname:(NSString *) cellClassname DataSource:(id<LECollectionViewDataSourceDelegate>) dataSource CellSelectionDelegate:(id<LECollectionViewCellSelectionDelegate>) selection;

@end

@interface LEBaseCollectionViewCell : UICollectionViewCell
@property (nonatomic) BOOL isInited;
@property (nonatomic, readonly) NSIndexPath *leIndexPath;
-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path;
@end
@interface LEBaseCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, readonly) NSMutableArray *leItemsArray;
@property (nonatomic, readonly) id<LECollectionViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readonly) id<LECollectionViewCellSelectionDelegate> leCellSelectionDelegate;
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
-(void) leDeselectCellAtIndex:(NSIndexPath *) index;
-(NSInteger)leCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
-(UICollectionViewCell *)leCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)leNumberOfSectionsInCollectionView:(UICollectionView *)collectionView;
@end
