//
//  LEBaseCollectionView.m
//  LEFrameworks
//
//  Created by emerson larry on 16/7/21.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEBaseCollectionView.h" 

@interface LECollectionViewSettings ()
@property (nonatomic, readwrite) LEAutoLayoutSettings *leSettings;
@property (nonatomic, readwrite) UICollectionViewLayout *leLayout;
@property (nonatomic, readwrite) NSString *leCellClassname;
@property (nonatomic, readwrite) id<LECollectionViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readwrite) id<LECollectionViewCellSelectionDelegate> leCellSelectionDelegate;
@end
@implementation LECollectionViewSettings
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings CollectionLayout:(UICollectionViewLayout *) layout CellClassname:(NSString *) cellClassname DataSource:(id<LECollectionViewDataSourceDelegate>) dataSource CellSelectionDelegate:(id<LECollectionViewCellSelectionDelegate>) selection{
    self=[super init];
    self.leSettings=settings;
    self.leLayout=layout;
    self.leCellClassname=cellClassname;
    self.leDataSourceDelegate=dataSource;
    self.leCellSelectionDelegate=selection;
    return self;
}
@end
//Cell
@interface LEBaseCollectionViewCell ()
@property (nonatomic, readwrite) NSIndexPath *leIndexPath;
@end
@implementation LEBaseCollectionViewCell
-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path{
    self.leIndexPath=path;
}
@end

//View
@interface LEBaseCollectionView ()
@property (nonatomic, readwrite) NSMutableArray *leItemsArray;
@property (nonatomic, readwrite) id<LECollectionViewDataSourceDelegate> leDataSourceDelegate;
@property (nonatomic, readwrite) id<LECollectionViewCellSelectionDelegate> leCellSelectionDelegate;
@end
@implementation LEBaseCollectionView{
    BOOL autoDeselect;
    NSString *curCellClassname;
}
-(void) leAutoDeselectCellAfterSelection:(BOOL) enable{
    autoDeselect=enable;
}
//
-(void) leSetTopRefresh:(BOOL) enable{
    
}
-(void) leSetBottomRefresh:(BOOL) enable{
    
}
//
-(void) leOnStopTopRefresh {
    [self reloadData];
}
-(void) leOnStopBottomRefresh {
    [self reloadData];
}
//
-(void) onDelegateRefreshData{
    //    LELogFunc
    if(self.leDataSourceDelegate){
        if([self.leDataSourceDelegate respondsToSelector:@selector(leOnRefreshDataForCollection)]){
            [self.leDataSourceDelegate leOnRefreshDataForCollection];
        }
    }
}
-(void) onDelegateLoadMore{
    //    LELogFunc
    if(self.leDataSourceDelegate){
        if([self.leDataSourceDelegate respondsToSelector: @selector(leOnLoadMoreForCollection)]){
            [self.leDataSourceDelegate leOnLoadMoreForCollection];
        }
    }
}
//
-(void) leOnAutoRefresh{
}
-(void) leOnAutoRefreshWithDuration:(float) duration{
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(leOnAutoRefresh) userInfo:nil repeats:NO];
}
//
-(void) leOnRefreshedWithData:(NSMutableArray *)data{
    if(data){
        self.leItemsArray=[data mutableCopy];
    }
    [self leOnStopTopRefresh];
}
-(void) leOnLoadedMoreWithData:(NSMutableArray *)data{
    if(data){
        if(!self.leItemsArray){
            self.leItemsArray=[[NSMutableArray alloc] init];
        }
        [self.leItemsArray addObjectsFromArray:data];
    }
    [self leOnStopBottomRefresh];
}
-(void) leDeselectCellAtIndex:(NSIndexPath *) index{
    [self deselectItemAtIndexPath:index animated:YES];
}
//==========
-(instancetype) initWithSettings:(LECollectionViewSettings *) settings{
    CGRect rect=[UIView leGetFrameWithAutoLayoutSettings:settings.leSettings];
    self=[super initWithFrame:rect collectionViewLayout:settings.leLayout];
    [settings.leSettings.leSuperView addSubview:self];
    self.leAutoLayoutSettings=settings.leSettings;
    self.leDataSourceDelegate=settings.leDataSourceDelegate;
    self.leCellSelectionDelegate=settings.leCellSelectionDelegate;
    [self setAllowsSelection:YES];
    [self setDelegate:self];
    [self setDataSource:self];
    [self registerClass:NSClassFromString(settings.leCellClassname) forCellWithReuseIdentifier:LEReuseableCollectionCellIdentifier];
    [self setBackgroundColor:LEColorClear];
    [self leExtraInits];
    [self setAlwaysBounceVertical:YES];
    autoDeselect=YES;
    return self;
}
//Sections
- (NSInteger)leNumberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self leNumberOfSectionsInCollectionView:collectionView];
}
//numbers
- (NSInteger)leCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.leItemsArray?self.leItemsArray.count:0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self leCollectionView:collectionView numberOfItemsInSection:section];
}
//Cell
- (UICollectionViewCell *)leCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LEBaseCollectionViewCell *cell=[self dequeueReusableCellWithReuseIdentifier:LEReuseableCollectionCellIdentifier forIndexPath:indexPath];
    if(!cell.isInited){
        cell.isInited=YES;
        [cell leExtraInits];
    }
    [cell leSetData:self.leItemsArray&&indexPath.row<self.leItemsArray.count?[self.leItemsArray objectAtIndex:indexPath.row]:nil IndexPath:indexPath];
    return cell;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self leCollectionView:collectionView cellForItemAtIndexPath:indexPath];
}
//
- (void)leCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.leCellSelectionDelegate&&[self.leCellSelectionDelegate respondsToSelector:@selector(leOnCollectionCellSelectedWithInfo:)]){
        [self.leCellSelectionDelegate leOnCollectionCellSelectedWithInfo:@{LEKeyOfIndexPath:indexPath}];
    }
    if(autoDeselect){
        [self leDeselectCellAtIndex:indexPath];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self leCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
}
@end


