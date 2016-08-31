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
#import <AssetsLibrary/AssetsLibrary.h>

@interface LEMultiImagePickerFlowCell : UIImageView
@property (nonatomic) BOOL isChecked;
@end
@implementation LEMultiImagePickerFlowCell{
    UIImageView *curIcon;
    ALAsset *curAsset;
}
-(id) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self leExtraInits];
    return self;
}
-(void) leExtraInits{
    [self setUserInteractionEnabled:YES];
    curIcon=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomRight Offset:CGPointMake(-2, -2) CGSize:CGSizeZero] Image:[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_MultiImagePickerCheck"]];
    [curIcon setHidden:YES];
    [self leAddTapEventWithSEL:@selector(onTap) Target:self];
}
-(void) onTap{
    self.isChecked=!self.isChecked;
    [curIcon setHidden:!self.isChecked];
}
-(void) setAlAsset:(ALAsset *) asset{
    curAsset=asset;
    [self setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
}
-(ALAsset *) getAsset{
    return curAsset;
}
@end

@interface LEMultiImagePickerFlowPage:LEBaseView<LENavigationDelegate>
@end
@implementation LEMultiImagePickerFlowPage{
    UIScrollView *curScrollView;
    NSMutableArray *curArray;
    NSMutableArray *curCellCache;
    ALAssetsGroup *curGroup;
    int space;
    int cellSize;
    LEBaseNavigation *curNavi;
    id<LEMultiImagePickerDelegate> curDelegate;
}
-(void) leExtraInits{
    curNavi=[[LEBaseNavigation alloc] initWithSuperViewAsDelegate:self Title:@"照片图库"];
    [curNavi leSetRightNavigationItemWith:@"完成" Image:nil];
    //
    space=2;
    cellSize=(self.leCurrentFrameWidth-space*3)*1.0/4;
    curArray=[[NSMutableArray alloc] init];
    curCellCache=[[NSMutableArray alloc] init];
    curScrollView=[[UIScrollView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewBelowCustomizedNavigation Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(LESCREEN_WIDTH, self.leViewBelowCustomizedNavigation.bounds.size.height)]];
    [curScrollView setClipsToBounds:YES];
    [curGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [curArray addObject:result];
        }else{
            if(curArray&&curArray.count>0){
                curArray=[[[curArray reverseObjectEnumerator] allObjects] mutableCopy];
            }
            [self reloadCell];
        }
    }];
}
-(void) leNavigationRightButtonTapped{
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leOnMultiImagePickedWith:)]){
        [curDelegate leOnMultiImagePickedWith:[self getData]];
    }
    [[self.leCurrentViewController.navigationController popViewControllerAnimated:YES] lePopSelfAnimated];
}
-(void) reloadCell{
    for (int i=0; i<curArray.count; i++) {
        LEMultiImagePickerFlowCell *cell=[[LEMultiImagePickerFlowCell alloc] initWithFrame:CGRectMake((cellSize+space)*(i%4), (cellSize+space)*(i/4), cellSize, cellSize)];
        [curScrollView addSubview:cell];
        [cell setAlAsset:[curArray objectAtIndex:i]];
        [curCellCache addObject:cell];
    }
    [curScrollView setContentSize:CGSizeMake(LESCREEN_WIDTH, (cellSize+space)*(curArray.count/4+(curArray.count%4==0?0:1)))];
}
-(NSArray *) getData{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (int i=0; i<curCellCache.count; i++) {
        LEMultiImagePickerFlowCell *cell=[curCellCache objectAtIndex:i];
        if(cell.isChecked){
            ALAsset *asset=[cell getAsset];
            [array addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]]];
        }
    }
    return array;
}
-(id) initWithViewController:(LEBaseViewController *)vc AssetsGroup:(ALAssetsGroup *) group Delegate:(id<LEMultiImagePickerDelegate>) delegate{
    curGroup=group;
    curDelegate=delegate;
    return [super initWithViewController:vc];
}
@end

@interface LEMultiImagePickerFlow:LEBaseViewController
@end
@implementation LEMultiImagePickerFlow
-(id) initWithDelegate:(id<LEMultiImagePickerDelegate>)delegate AssetsGroup:(ALAssetsGroup *) group{
    self=[super init];
    [[[LEMultiImagePickerFlowPage alloc] initWithViewController:self AssetsGroup:group Delegate:delegate] setUserInteractionEnabled:YES];
    return self;
}
-(void) leExtraInits{}
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
-(void) leExtraInits{
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
}
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEMultiImagePickerDelegate>) delegate{
    curDelegate=delegate;
    return [super initWithViewController:vc];
}
-(void) leExtraInits{
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
    LEMultiImagePickerFlow *vc=[[LEMultiImagePickerFlow alloc] initWithDelegate:curDelegate AssetsGroup:[[self.albumsArray objectAtIndex:index.row] objectForKey:@"group"]];
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
-(id) initWithImagePickerDelegate:(id<LEMultiImagePickerDelegate>) delegate{
    self=[super init];
    [[[LEMultiImagePickerPage alloc] initWithViewController:self Delegate:delegate] setUserInteractionEnabled:YES];
    return self;
}
-(void) leExtraInits{}
@end
