//
//  LEMultiImagePicker.m
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/1.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import "LEMultiImagePicker.h"
#import "LEBaseTableView.h"
#import "LEBaseTableViewCell.h"

@interface LEMultiImagePickerFlowPage:LEBaseView<LENavigationDelegate>
//-(NSInteger) getRemainCount;
//-(void) setCell:(ALAsset *) asset Status:(BOOL) status;
@end
@interface LEMultiImagePickerFlowCell : LEBaseCollectionViewCell
@property (nonatomic) BOOL isChecked;
@property (nonatomic) LEMultiImagePickerFlowPage *curPage;
@end
@implementation LEMultiImagePickerFlowCell{
    UIImageView *curImage;
    UIImageView *curIcon;
    ALAsset *curAsset;
}
//-(id) initWithFrame:(CGRect)frame{
//    self=[super initWithFrame:frame];
//    [self leAdditionalInits];
//    return self;
//}
-(void) leAdditionalInits{
    curImage=[[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:curImage];
    curIcon=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopRight Offset:CGPointMake(-2, 2) CGSize:CGSizeZero] Image:[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_MultiImagePickerCheck"]];
    [curIcon setHidden:YES];
//    [self leAddTapEventWithSEL:@selector(onTap) Target:self];
    [curImage setContentMode:UIViewContentModeScaleAspectFill];
    [self setClipsToBounds:YES];
}
//-(void) onTap{
//    if(self.isChecked||[self.curPage getRemainCount]>0){
//        self.isChecked=!self.isChecked;
//        [curIcon setHidden:!self.isChecked];
//        [self.curPage setCell:curAsset Status:self.isChecked];
//    }else{
//        
//    }
//}
-(void) leSetData:(id)data IndexPath:(NSIndexPath *)path{
    [super leSetData: data IndexPath:path];
    curAsset=[data objectForKey:@"asset"];
    BOOL check=[[data objectForKey:@"check"] boolValue];
    [curIcon setHidden:!check];
    [curImage setImage:[UIImage imageWithCGImage:[curAsset aspectRatioThumbnail]]];
}
//-(ALAsset *) getAsset{
//    return curAsset;
//}
@end
@interface LEMultiImagePickerFlowPage ()<LECollectionViewCellSelectionDelegate>
@end
@implementation LEMultiImagePickerFlowPage{
//    UIScrollView *curScrollView;
    NSMutableArray *curArray;
//    NSMutableArray *curCellCache;
    ALAssetsGroup *curGroup;
    int space;
    int cellSize;
    LEBaseNavigation *curNavi;
    id<LEMultiImagePickerDelegate> curDelegate;
    NSInteger remainCount;
    NSMutableArray *curSelections;
    __weak UIViewController *curRootVC;
    LEBaseCollectionView *collection;
    NSInteger maxCount;
}
-(void) leOnCollectionCellSelectedWithInfo:(NSDictionary *)info{
    NSIndexPath *index=[info objectForKey:LEKeyOfIndexPath];
    NSMutableDictionary *dic=[curArray objectAtIndex:index.row];
    BOOL check=[[dic objectForKey:@"check"] boolValue];
    if(curSelections.count<remainCount){
        check=!check;
        [dic setObject:[NSNumber numberWithBool:check] forKey:@"check"];
        if(check){
            [curSelections addObject:index];
        }else{
            [curSelections removeObject:index];
        }
        [self reloadCell];
    }else{
        if(check){
            [curSelections removeObject:index];
            [dic setObject:[NSNumber numberWithBool:NO] forKey:@"check"];
            [self reloadCell];
        }else{
            [self leAddLocalNotification:[NSString stringWithFormat:@"一次最多只能选择%zd张照片",maxCount]];
        }
    }
}
//-(void) setCell:(ALAsset *) asset Status:(BOOL) status{
//    if(status){
//        [curSelections addObject:asset];
//    }else {
//        [curSelections removeObject:asset];
//    }
//}
//-(NSInteger) getRemainCount{
//    if(remainCount==INT_MAX)return INT_MAX;
//    else{
//        NSInteger count=0;
//        for (int i=0; i<curCellCache.count; i++) {
//            LEMultiImagePickerFlowCell *cell=[curCellCache objectAtIndex:i];
//            if(cell.isChecked){
//                count++;
//            }
//        }
//        return remainCount-count;
//    }
//}
-(void) leAdditionalInits{
    curSelections=[NSMutableArray new];
    curNavi=[[LEBaseNavigation alloc] initWithSuperViewAsDelegate:self Title:@"照片图库"];
    [curNavi leSetRightNavigationItemWith:@"完成" Image:nil];
    //
    space=2;
    cellSize=(self.leCurrentFrameWidth-space*5)*1.0/4;
    curArray=[[NSMutableArray alloc] init];
//    curCellCache=[[NSMutableArray alloc] init];
    //
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(cellSize,cellSize);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //    layout.minimumLineSpacing=LELayoutSideSpace;
    layout.minimumInteritemSpacing=space;
    collection=[[LEBaseCollectionView alloc] initWithSettings:[[LECollectionViewSettings alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewBelowCustomizedNavigation EdgeInsects:UIEdgeInsetsZero] CollectionLayout:layout CellClassname:@"LEMultiImagePickerFlowCell" ReusableView:nil DataSource:nil CellSelectionDelegate:self]];
    //
//    curScrollView=[[UIScrollView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewBelowCustomizedNavigation Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(LESCREEN_WIDTH, self.leViewBelowCustomizedNavigation.bounds.size.height)]];
//    [curScrollView setClipsToBounds:YES];
    LEWeakSelf(self);
    [curGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [self addALAsset:result];
        }else{
            if(curArray&&curArray.count>0){
                curArray=[[[curArray reverseObjectEnumerator] allObjects] mutableCopy];
            }
            [weakself reloadCell];
        }
    }];
}
-(void) addALAsset:(ALAsset *) asset{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setObject:asset forKey:@"asset"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"check"];
    [curArray addObject:dic];
}
-(void) leNavigationRightButtonTapped{
    [self.leCurrentViewController.navigationController popToViewController:curRootVC animated:YES];
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leOnMultiImagePickedWith:)]){
        [curDelegate leOnMultiImagePickedWith:[self getData]];
    }
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leOnMultiImageAssetPickedWith:)]){
        [curDelegate leOnMultiImageAssetPickedWith:[self getAssets]];
    }
    
}
-(void) reloadCell{
//    for (int i=0; i<curArray.count; i++) {
//        LEMultiImagePickerFlowCell *cell=[[LEMultiImagePickerFlowCell alloc] initWithFrame:CGRectMake((cellSize+space)*(i%4), (cellSize+space)*(i/4), cellSize, cellSize)];
//        [curScrollView addSubview:cell];
//        [cell setAlAsset:[curArray objectAtIndex:i]];
//        [curCellCache addObject:cell];
//        [cell setCurPage:self];
//    }
//    [curScrollView setContentSize:CGSizeMake(LESCREEN_WIDTH, (cellSize+space)*(curArray.count/4+(curArray.count%4==0?0:1)))];
    [collection leOnRefreshedWithData:curArray];
}
-(NSArray *) getAssets{
    NSMutableArray *muta=[NSMutableArray new];
    //    for (NSInteger i=curSelections.count-1; i>=0; i--) {
    for (NSInteger i=0;i<curSelections.count;i++) {
        NSIndexPath *index=[curSelections objectAtIndex:i];
        ALAssetRepresentation *asset=[[[curArray objectAtIndex:index.row] objectForKey:@"asset"] defaultRepresentation];
        [muta addObject:asset];
    }
    return muta;
}
-(NSArray *) getData{
    NSMutableArray *muta=[NSMutableArray new];
    //    for (NSInteger i=curSelections.count-1; i>=0; i--) {
    for (NSInteger i=0;i<curSelections.count;i++) {
        NSIndexPath *index=[curSelections objectAtIndex:i];
        ALAssetRepresentation *asset=[[[curArray objectAtIndex:index.row] objectForKey:@"asset"] defaultRepresentation];
//        UIImageOrientation ori=UIImageOrientationUp;
//        switch (asset.orientation) {
//            case ALAssetOrientationUp:
//                ori=UIImageOrientationUp;
//                break;
//            case ALAssetOrientationDown:
//                ori=UIImageOrientationDown;
//                break;
//            case ALAssetOrientationLeft:
//                ori=UIImageOrientationLeft;
//                break;
//            case ALAssetOrientationRight:
//                ori=UIImageOrientationRight;
//                break;
//            case ALAssetOrientationUpMirrored:
//                ori=UIImageOrientationUpMirrored;
//                break;
//            case ALAssetOrientationDownMirrored:
//                ori=UIImageOrientationDownMirrored;
//                break;
//            case ALAssetOrientationLeftMirrored:
//                ori=UIImageOrientationLeftMirrored;
//                break;
//            case ALAssetOrientationRightMirrored:
//                ori=UIImageOrientationRightMirrored;
//                break;
//            default:
//                break;
//        }
//        [muta addObject:[UIImage imageWithCGImage:[asset fullResolutionImage] scale:1 orientation:ori]];
        [muta addObject:[UIImage imageWithCGImage:[asset fullScreenImage]]];
    }
    return muta;
    //    NSMutableArray *array=[[NSMutableArray alloc] init];
    //    for (int i=0; i<curCellCache.count; i++) {
    //        LEMultiImagePickerFlowCell *cell=[curCellCache objectAtIndex:i];
    //        if(cell.isChecked){
    //            ALAsset *asset=[cell getAsset];
    //            [array addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]]];
    //        }
    //    }
    //    return array;
}
-(id) initWithViewController:(LEBaseViewController *)vc AssetsGroup:(ALAssetsGroup *) group Delegate:(id<LEMultiImagePickerDelegate>) delegate RemainCount:(NSInteger) remain MaxCount:(NSInteger) max{
    curGroup=group;
    curDelegate=delegate;
    remainCount=remain;
    maxCount=max;
    return [super initWithViewController:vc];
}
-(void) onSetRootVC:(UIViewController *) root{
    curRootVC=root;
}
@end

@interface LEMultiImagePickerFlow:LEBaseViewController
@end
@implementation LEMultiImagePickerFlow{
    LEMultiImagePickerFlowPage *page;
}
-(id) initWithDelegate:(id<LEMultiImagePickerDelegate>)delegate AssetsGroup:(ALAssetsGroup *) group RemainCount:(NSInteger) remain MaxCount:(NSInteger) max{
    self=[super init];
    [page=[[LEMultiImagePickerFlowPage alloc] initWithViewController:self AssetsGroup:group Delegate:delegate RemainCount:remain MaxCount:max] setUserInteractionEnabled:YES];
    return self;
}
-(void) onSetRootVC:(UIViewController *) root{
    [page onSetRootVC:root];
}
-(void) leAdditionalInits{}
@end

//==============================
@interface LEMultiImagePickerCell : LEBaseTableViewCell
@property (nonatomic) NSMutableArray *imagesAssetArray;
@end
@implementation LEMultiImagePickerCell{
    UIImageView *curIcon;
    UILabel *curTitle;
    UILabel *curSubtitle;
    int cellH;
}
-(void) leAdditionalInits{
    cellH=LESCREEN_WIDTH/4;
    [self leSetCellHeight:cellH];
    curIcon=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LELayoutSideSpace20, 0) CGSize:CGSizeMake(cellH-LELayoutSideSpace20, cellH-LELayoutSideSpace20)] Image:nil];
    curTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:curIcon Offset:CGPointMake(LELayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:0 Font:[UIFont boldSystemFontOfSize:LELayoutFontSize17] Width:0 Height:0 Color:LEColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
    curSubtitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:curTitle Offset:CGPointMake(LELayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorTextGray Line:1 Alignment:NSTextAlignmentLeft]];
}
-(void) leSetData:(NSDictionary *)data IndexPath:(NSIndexPath *)path{
    [super leSetData:data IndexPath:path];
    if(data){
        ALAssetsGroup *assetsGroup=[data objectForKey:@"group"];
        [curIcon setImage:[UIImage imageWithCGImage:assetsGroup.posterImage]];
        NSString *title=[NSString stringWithFormat:@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
        NSString *subTitle=[NSString stringWithFormat:@"(%d)", (int)assetsGroup.numberOfAssets];
        [curTitle leSetText:title];
        [curSubtitle leSetText:subTitle];
    }
}
@end

@interface LEMultiImagePickerPage:LEBaseView<LETableViewCellSelectionDelegate,LENavigationDelegate>
@property (nonatomic) ALAssetsLibrary *assetsLibrary;
@property (nonatomic) NSMutableArray *albumsArray;
@end
@implementation LEMultiImagePickerPage{
    LEBaseTableView *curTableView;
    NSMutableArray *curArray;
    id<LEMultiImagePickerDelegate> curDelegate;
    LEBaseNavigation *curNavi;
    NSInteger remainCount;
    __weak UIViewController *curRootVC;
    NSInteger maxCount;
}
//-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEMultiImagePickerDelegate>) delegate{
//    return [self initWithViewController:vc Delegate:delegate RemainCount:INT_MAX];
//}
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEMultiImagePickerDelegate>) delegate RemainCount:(NSInteger) remain MaxCount:(NSInteger) max RootVC:(UIViewController *) root{
    curDelegate=delegate;
    remainCount=remain;
    curRootVC=root;
    maxCount=max;
    return [super initWithViewController:vc];
}
-(void) leAdditionalInits{
    curNavi=[[LEBaseNavigation alloc] initWithSuperViewAsDelegate:self Title:@"照片"];
    [curNavi leSetRightNavigationItemWith:@"取消" Image:nil];
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    curArray=[[NSMutableArray alloc] init];
    curTableView=[[LEBaseTableView alloc] initWithSettings:[[LETableViewSettings alloc] initWithSuperViewContainer:self ParentView:self.leViewBelowCustomizedNavigation TableViewCell:@"LEMultiImagePickerCell" EmptyTableViewCell:nil GetDataDelegate:nil TableViewCellSelectionDelegate:self]];
    [curTableView leSetTopRefresh:NO];
    [curTableView leSetBottomRefresh:NO];
    [self onLoadData];
}
-(void) leNavigationRightButtonTapped{
    [self.leCurrentViewController lePopSelfAnimated];
}
-(void) leOnTableViewCellSelectedWithInfo:(NSDictionary *)info{
    NSIndexPath *index=[info objectForKey:LEKeyOfIndexPath];
    LEMultiImagePickerFlow *vc=[[LEMultiImagePickerFlow alloc] initWithDelegate:curDelegate AssetsGroup:[[self.albumsArray objectAtIndex:index.row] objectForKey:@"group"] RemainCount:remainCount MaxCount:maxCount];
    [vc onSetRootVC:curRootVC];
    [self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onLoadData{
    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
    // 获取当前应用对照片的访问授权状态
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
    if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
        // 展示提示语
    }else{
        self.albumsArray = [[NSMutableArray alloc] init];
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                if (group.numberOfAssets > 0) {
                    // 把相册储存到数组中，方便后面展示相册时使用
                    [self.albumsArray addObject:@{@"group":group}];
                }
            }else{
                if(self.albumsArray&&self.albumsArray.count>0){
                    self.albumsArray=[[[self.albumsArray reverseObjectEnumerator] allObjects] mutableCopy];
                }
                [curTableView leOnRefreshedWithData:self.albumsArray];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"Asset group not found!\n");
        }];
    }
}
@end

@interface LEMultiImagePicker ()
@end
@implementation LEMultiImagePicker
-(id) initWithImagePickerDelegate:(id<LEMultiImagePickerDelegate>) delegate RootVC:(UIViewController *) vc{
    return [self initWithImagePickerDelegate:delegate RemainCount:INT_MAX MaxCount:INT_MAX RootVC:vc];
}
-(id) initWithImagePickerDelegate:(id<LEMultiImagePickerDelegate>) delegate RemainCount:(NSInteger)remain MaxCount:(NSInteger) max RootVC:(UIViewController *) vc{
    self=[super init];
    [[[LEMultiImagePickerPage alloc] initWithViewController:self Delegate:delegate RemainCount:remain MaxCount:max RootVC:vc] setUserInteractionEnabled:YES];
    return self;
}
-(void) leAdditionalInits{}
@end
