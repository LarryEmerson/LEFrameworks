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
    [self initUI];
    return self;
}
-(void) initUI{
    [self setUserInteractionEnabled:YES];
    curIcon=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomRight Offset:CGPointMake(-2, -2) CGSize:CGSizeZero] Image:[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_LEMultiImagePickerCheck"]];
    [curIcon setHidden:YES];
    [self addTapEventWithSEL:@selector(onTap) Target:self];
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

@interface LEMultiImagePickerFlowPage:LEBaseView
@end
@implementation LEMultiImagePickerFlowPage{
    UIScrollView *curScrollView;
    NSMutableArray *curArray;
    NSMutableArray *curCellCache;
    ALAssetsGroup *curGroup;
    int space;
    int cellSize;
}
-(void) setExtraViewInits{
    space=2;
    cellSize=(self.curFrameWidth-space*3)*1.0/4;
    curArray=[[NSMutableArray alloc] init];
    curCellCache=[[NSMutableArray alloc] init];
    curScrollView=[[UIScrollView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth, self.curFrameHight)]];
    [curGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [curArray addObject:result];
        }else{
            [self reloadCell];
        }
    }];
}
-(void) reloadCell{
    for (int i=0; i<curArray.count; i++) {
        LEMultiImagePickerFlowCell *cell=[[LEMultiImagePickerFlowCell alloc] initWithFrame:CGRectMake((cellSize+space)*(i%4), LayoutSideSpace+(cellSize+space)*(i/4), cellSize, cellSize)];
        [self addSubview:cell];
        [cell setAlAsset:[curArray objectAtIndex:i]];
        [curCellCache addObject:cell];
    }
}
-(NSArray *) getData{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (int i=0; i<curCellCache.count; i++) {
        LEMultiImagePickerFlowCell *cell=[curCellCache objectAtIndex:i];
        if(cell.isChecked){
            ALAsset *asset=[cell getAsset];
            [array addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
        }
    }
    return array;
}
-(id) initWithViewController:(LEBaseViewController *)vc AssetsGroup:(ALAssetsGroup *) group{
    curGroup=group;
    return [super initWithViewController:vc];
}
@end

@interface LEMultiImagePickerFlow:LEBaseViewController
@end
@implementation LEMultiImagePickerFlow{
    BOOL isBarHide;
    LEMultiImagePickerFlowPage *page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isBarHide=self.navigationController.navigationBarHidden;
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.view addSubview:page];
    //    [self setLeftBarButtonAsBackWith:IMG_ArrowLeft];
    [self.navigationItem setTitle:@"照片图库"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(onRight)]];
}
-(void) onRight{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.jumpDelegate&&[self.jumpDelegate respondsToSelector:@selector(onEaseOutPageWithPageName:AndData:)]){
        [self.jumpDelegate onEaseOutPageWithPageName:@"" AndData:[page getData]];
    }
}
-(id) initWithDelegate:(id<LEBaseViewControllerPageJumpDelagte>)delegate AssetsGroup:(ALAssetsGroup *) group{
    self=[super initWithDelegate:delegate];
    page=[[LEMultiImagePickerFlowPage alloc] initWithViewController:self AssetsGroup:group];
    return self;
}
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
-(void) initUI{
    cellH=self.globalVar.ScreenWidth/4;
    [self setCellHeight:cellH];
    curIcon=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace20, 0) CGSize:CGSizeMake(cellH-LayoutSideSpace20, cellH-LayoutSideSpace20)] Image:nil];
    curTitle=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:curIcon Offset:CGPointMake(LayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:0 Font:[UIFont boldSystemFontOfSize:LayoutFontSize17] Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
    curSubtitle=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:curTitle Offset:CGPointMake(LayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextGray Line:1 Alignment:NSTextAlignmentLeft]];
}
-(void) setData:(NSDictionary *)data IndexPath:(NSIndexPath *)path{
    self.curIndexPath=path;
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

@interface LEMultiImagePickerPage:LEBaseView<LETableViewCellSelectionDelegate,LEBaseViewControllerPageJumpDelagte>
@property (nonatomic) ALAssetsLibrary *assetsLibrary;
@property (nonatomic) NSMutableArray *albumsArray;
@end
@implementation LEMultiImagePickerPage{
    LEBaseTableView *curTableView;
    NSMutableArray *curArray;
    id<LEMultiImagePickerDelegate> curDelegate;
}
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEMultiImagePickerDelegate>) delegate{
    curDelegate=delegate;
    return [super initWithViewController:vc];
}
-(void) setExtraViewInits{
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    curArray=[[NSMutableArray alloc] init];
    curTableView=[[LEBaseTableView alloc] initWithSettings:[[LETableViewSettings alloc] initWithSuperViewContainer:self ParentView:self.viewContainer TableViewCell:@"LEMultiImagePickerCell" EmptyTableViewCell:nil GetDataDelegate:nil TableViewCellSelectionDelegate:self]];
    [curTableView setTopRefresh:NO];
    [curTableView setBottomRefresh:NO];
    [self onLoadData];
}
-(void) onTableViewCellSelectedWithInfo:(NSDictionary *)info{
    NSIndexPath *index=[info objectForKey:KeyOfCellIndexPath];
    LEMultiImagePickerFlow *vc=[[LEMultiImagePickerFlow alloc] initWithDelegate:self AssetsGroup:[[self.albumsArray objectAtIndex:index.row] objectForKey:@"group"]];
    [self.curViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onEaseOutPageWithPageName:(NSString *)order AndData:(id)data{
    [self.curViewController.navigationController popViewControllerAnimated:YES];
    if(curDelegate&&[curDelegate respondsToSelector:@selector(onMultiImagePickedWith:)]){
        [curDelegate onMultiImagePickedWith:data];
    }
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
                [curTableView onRefreshedWithData:self.albumsArray];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"Asset group not found!\n");
        }];
    }
}
@end

@interface LEMultiImagePicker ()
@end
@implementation LEMultiImagePicker{
    BOOL isBarHide;
    LEMultiImagePickerPage *page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isBarHide=self.navigationController.navigationBarHidden;
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.view addSubview:page];
    [self setLeftBarButtonAsBackWith:IMG_ArrowLeft];
    [self.navigationItem setTitle:@"照片"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(onRight)]];
}
-(void) onRight{
    [self.navigationController popViewControllerAnimated:YES];
}
-(id) initWithImagePickerDelegate:(id<LEMultiImagePickerDelegate>) delegate{
    self=[super init];
    page=[[LEMultiImagePickerPage alloc] initWithViewController:self Delegate:delegate];
    return self;
}
@end
