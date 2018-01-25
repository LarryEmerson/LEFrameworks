//
//  LEUIFramework.h
//  LEUIFramework
//
//  Created by Larry Emerson on 15/2/19.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sys/sysctl.h"
#import <objc/runtime.h> 
#import "LELocalNotification.h"
#import <LEFoundation/LEFoundations.h>


 
#pragma mark 资源名称需要对应
#define LEIMG_Cell_RightArrow     [[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_tableview_icon_arrow"]
#define LEIMG_ArrowLeft           [[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_common_navigation_btn_back"]

typedef NS_ENUM(NSInteger, LEAnchors) {
    //Inside
    LEAnchorInsideTopLeft = 0,
    LEAnchorInsideTopCenter = 1,
    LEAnchorInsideTopRight =2,
    //
    LEAnchorInsideLeftCenter = 3,
    LEAnchorInsideCenter = 4,
    LEAnchorInsideRightCenter = 5,
    //
    LEAnchorInsideBottomLeft = 6,
    LEAnchorInsideBottomCenter = 7,
    LEAnchorInsideBottomRight = 8,
    //Outside
    LEAnchorOutside1 = 9,
    LEAnchorOutside2 = 10,
    LEAnchorOutside3 = 11,
    LEAnchorOutside4 = 12,
    //
    LEAnchorOutsideTopLeft = 13,
    LEAnchorOutsideTopCenter = 14,
    LEAnchorOutsideTopRight = 15,
    //
    LEAnchorOutsideLeftTop = 16,
    LEAnchorOutsideLeftCenter = 17,
    LEAnchorOutsideLeftBottom = 18,
    //
    LEAnchorOutsideRightTop = 19,
    LEAnchorOutsideRightCenter = 20,
    LEAnchorOutsideRightBottom =21,
    //
    LEAnchorOutsideBottomLeft = 22,
    LEAnchorOutsideBottomCenter = 23,
    LEAnchorOutsideBottomRight =24
};
#pragma mark Layout Space
#define LELayoutSideSpace60                                        60
#define LELayoutSideSpace27                                        27
#define LELayoutSideSpace20                                        20
#define LELayoutSideSpace16                                        16
#define LELayoutSideSpace15                                        15
#define LELayoutSideSpace                                          10
#define LELayoutChildSideSpace                                     8
#define LELayoutInputSpace                                         20
#define LELayoutContentBottomSpace45                               45
#define LELayoutContentTopSpace30                                  30
#define LELayoutContentBottomSpace30                               30
#define LELayoutContentTopSpace20                                  20
#define LELayoutContentBottomSpace20                               20
#define LELayoutContentTopSpace                                    15
#define LELayoutContentBottomSpace                                 15
#define LELayoutChildContentTopSpace                               10
#define LELayoutChildContentBottomSpace                            10
#pragma mark Layout Linespace
#define LELayoutTextLineSpace30                                    30
#define LELayoutTextLineSpace24                                    24
#define LELayoutTextLineSpace20                                    20
#define LELayoutTextLineSpace15                                    15
#define LELayoutTextLineSpace14                                    14
#define LELayoutTextLineSpace                                      12
#define LELayoutChildTextLineSpace                                 10
#define LELayoutSnapshotTextLineSpace                              8
#pragma mark Layout Avatar
#define LELayoutAvatarSizeBig                                      60
#define LELayoutAvatarSizeMid                                      40
#define LELayoutAvatarSize                                         30
#define LELayoutAvatarSpace                                        20
#pragma mark LayoutFont
#define LELayoutFontSize70                                         70
#define LELayoutFontSize30                                         30
#define LELayoutFontSize20                                         20
#define LELayoutFontSize18                                         18
#define LELayoutFontSize17                                         17
#define LELayoutFontSize16                                         16
#define LELayoutFontSize14                                         14
#define LELayoutFontSize13                                         13
#define LELayoutFontSize12                                         12
#define LELayoutFontSize10                                         10
#define LELayoutFontSize9                                          9
#define LELayoutFontSize7                                          7
#pragma mark Layout Input Height
#define LELayoutCommentInputHeight                                 100
#define LELayoutInputHeight                                        35
 
#pragma mark DeviceInfo
#define LEIS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define LEIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define LEIS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define LESCREEN_BOUNDS     ([[UIScreen mainScreen] bounds])
#define LESCREEN_SCALE      ([[UIScreen mainScreen] scale])
#define LESCREEN_SCALE_INT  ((int)[[UIScreen mainScreen] scale])
#define LESCREEN_WIDTH      ([[UIScreen mainScreen] bounds].size.width)
#define LESCREEN_HEIGHT     ([[UIScreen mainScreen] bounds].size.height)
#define LESCREEN_MAX_LENGTH (MAX(LESCREEN_WIDTH, LESCREEN_HEIGHT))
#define LESCREEN_MIN_LENGTH (MIN(LESCREEN_WIDTH, LESCREEN_HEIGHT))

#define LEIS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define LEIS_IPHONE_5 (LEIS_IPHONE && LESCREEN_MAX_LENGTH == 568.0)
#define LEIS_IPHONE_6 (LEIS_IPHONE && LESCREEN_MAX_LENGTH == 667.0)
#define LEIS_IPHONE_6P (LEIS_IPHONE && LESCREEN_MAX_LENGTH == 736.0)
#define LEIS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//(LEIS_IPHONE && LESCREEN_MAX_LENGTH == 812.0)
//#define iPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define LEDevice    TARGET_OS_IPHONE
#define LESimulator TARGET_IPHONE_SIMULATOR
 
#define LEStrongSelf(type)  __strong typeof(type) type = weak##type;

#pragma mark View
#define LEViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
if(Width>0)[View.layer setBorderWidth:(Width)];\
if(Color)[View.layer setBorderColor:[Color CGColor]]

#define LEDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LERadianToDegrees(radian) (radian*180.0)/(M_PI)

#define LERandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define LELabelMaxSize CGSizeMake(INT16_MAX, INT16_MAX)
#define LeTextShadowColor [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3]
#define LeTextShadowSize CGSizeMake(0.5, 0.5)

#define LEDefaultButtonVerticalSpace 6
#define LEDefaultButtonHorizontalSpace 12

#define LENavigationBarFontSize 18
#define LENavigationBarHeight 44
#define LEStatusBarHeight (LEIS_IPHONE_X?44:20)
#define LEBottomTabbarHeight 49
#define LEBottomTabbarHeightAddon (LEIS_IPHONE_X?(83-LEBottomTabbarHeight):0)
//#define iPhone6ScaleRate 1//(iPhone6||iPhone6Plus?1.25:1)
//#define iPhone6ScaleRateSmall 1//(iPhone6||iPhone6Plus?1.1:1)
//#define iPhoneBigScale  iPhone6||iPhone6Plus
// 
//
#define LEDefaultCellHeightBig 64
#define LEDefaultCellHeightMid 52
#define LEDefaultCellHeightSml 44
#define LEDefaultCellHeight (LEIS_IPHONE_6P?LEDefaultCellHeightBig:(LEIS_IPHONE_6?LEDefaultCellHeightMid:LEDefaultCellHeightSml))
#define LEDefaultCellIconRect 30

#define LEDefaultSectionHeight8 8
#define LEDefaultSectionHeight 12
#define LEDefaultSectionHeightBig 24

#pragma mark Define Colors
#define LEColorTableViewGray      [UIColor colorWithWhite:0.941 alpha:1.000]
#define LEColorGrayDark           [UIColor colorWithRed:0.1892 green:0.2134 blue:0.2779 alpha:1.0]
#define LEColorGray               [UIColor colorWithRed:0.6384 green:0.6588 blue:0.7095 alpha:1.0]
#define LEColorGrayLight          [UIColor colorWithRed:0.9264 green:0.9263 blue:0.9263 alpha:1.0]
#define LEColorTextBlack          [UIColor colorWithRed:0.2549 green:0.2863 blue:0.3412 alpha:1.0]
#define LEColorTextGray           [UIColor colorWithRed:0.372 green:0.3934 blue:0.4507    alpha:1.0]
#define LEColorBlue               [UIColor colorWithRed:0.2071 green:0.467 blue:0.8529 alpha:1.0]
#define LEColorRed 				  [UIColor colorWithRed:0.9337 green:0.2135 blue:0.3201  alpha:1.0]
#define LEColorSplit              [UIColor colorWithRed:0.9655 green:0.9653 blue:0.9703 alpha:1.0]
#define LEColorSection            [UIColor colorWithRed:0.9412 green:0.9502 blue:0.9703 alpha:0.08]
#define LEColorTest               [UIColor colorWithRed:0.867 green:0.852 blue:0.539 alpha:1.000]
#define LEColorClear              [UIColor clearColor]
#define LEColorWhite              [UIColor whiteColor]
#define LEColorBlack              [UIColor blackColor]
#define LEColorMaskLight          [[UIColor alloc] initWithWhite:0.906 alpha:1.000]
#define LEColorMask               [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.1]
#define LEColorMask2              [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.2]
#define LEColorMask5              [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]
#define LEColorMask8              [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.8]
#pragma mark Image Type
#define LEImageTypeAsJpeg @"image/jpeg"
#define LEImageTypeAsPng  @"image/png"
#define LEImageTypeAsGif  @"image/gif"
#define LEImageTypeAsTiff @"image/tiff"
#pragma mark Font
#define LayoutFontNameArialRoundedMTBold      @"Arial Rounded MT Bold"
#define LEFont(size) [UIFont systemFontOfSize:size]
#define LEBoldFont(size) [UIFont boldSystemFontOfSize:size]

#pragma mark GCD
//GCD - 一次性执行
#define LEDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define LEDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define LEDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
 
#pragma mark 
#define LEKeyOfCellSplit                @"cellsplit"
#define LEKeyOfIndexPath                @"cellindex"
#define LEKeyOfClickStatus              @"cellstatus"
#define LEKeyOfClickStatusContent       @"cellstatuscontent"
#define LEKeyOfClickStatusContentExtra  @"cellstatuscontentextra"
#define LEKeyOfClickStatusAsDefault     0
#define LEKeyOfCellTitle                @"emptycelltitle"
#define LESquareSize(__integer)         CGSizeMake(__integer,__integer)

@interface UIViewController (LEExtension)
-(void) leSetLeftBarButtonWithImage:(UIImage *) img SEL:(SEL) sel;
-(void) leSetRightBarButtonWithImage:(UIImage *)img SEL:(SEL) sel;
-(void) leSetLeftBarButtonAsBackWith:(UIImage *) back;
-(void) leSetNavigationTitle:(NSString *) title;
-(void) leThroughNavigationAnimatedPush:(UIViewController *) vc;
-(void) lePopSelfAnimated;
@end

@interface NSObject (LEExtension)
-(NSString *) leStringValue;
/**
 用于初始化，来自于NSObject意味着每个对象都可以实现该方法 */
-(void) leAdditionalInits;
/**
 用于给每个对象添加释放代码逻辑 */
-(void) leRelease;
@end

@interface UIView (LEExtension)
-(void) leAddLocalNotification:(NSString *) notification;
-(void) leEndEdit;
-(void) leAddTapEventWithSEL:(SEL) sel;
-(void) leAddTapEventWithSEL:(SEL)sel Target:(id) target;
-(void) leSetRoundCornerWithRadius:(CGFloat) radius;
-(UIImageView *) leAddTopSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width;
-(UIImageView *) leAddBottomSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width;
-(UIImageView *) leAddLeftSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Height:(int) height;
-(UIImageView *) leAddRightSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Height:(int) height;
-(void) leReleaseView;
@end

@interface UIImage (LEExtension)
-(UIImage *)leMiddleStrechedImage;
@end

@interface UIColor (LEExtension)
-(UIImage *)leImageStrechedFromSizeOne;
-(UIImage *)leImageWithSize:(CGSize)size;
@end

@interface NSString (LEExtension)
-(int) leAsciiLength;
-(CGSize) leGetSizeWithFont:(UIFont *)font MaxSize:(CGSize) size;
-(CGSize) leGetSizeWithFont:(UIFont *)font MaxSize:(CGSize) size ParagraphStyle:(NSMutableParagraphStyle *) style;
-(CGSize) leGetSizeWithFont:(UIFont *)font MaxSize:(CGSize) size LineSpcae:(int) linespace Alignment:(NSTextAlignment) alignment;
-(NSObject *) leGetInstanceFromClassName;
-(NSString *) leGetTrimmedString;
@end

@interface LEAutoLayoutLabelSettings : NSObject
@property (nonatomic) NSString *leText;
@property (nonatomic) int leFontSize;
@property (nonatomic) UIFont *leFont;
@property (nonatomic) int leWidth;
@property (nonatomic) int leHeight;
@property (nonatomic) UIColor *leColor;
@property (nonatomic) int leLine;
@property (nonatomic) NSTextAlignment leAlignment;
-(id) initWithText:(NSString *) text FontSize:(int) fontSize Font:(UIFont *) font Width:(int) width Height:(int) height Color:(UIColor *) color Line:(int) line Alignment:(NSTextAlignment) alignment;
@end

@interface UIImageView (LEExtension)
-(void) leSetImage:(UIImage *) image;
-(void) leSetImage:(UIImage *) image WithSize:(CGSize) size;
@end

@interface UILabel (LEExtension)
@property (nonatomic) LEAutoLayoutLabelSettings *leAutoLayoutLabelSettings;
//- (void)alignTop;
//- (void)alignBottom;
-(CGSize) leGetLabelTextSize;
-(CGSize) leGetLabelTextSizeWithMaxWidth:(int) width;
-(void) leSetText:(NSString *) text;
-(void) leSetLineSpace:(float) space;
-(void) leSetLinespace:(float) space Color:(UIColor *) color Range:(NSRange) range;
-(void) leRedrawAttributedStringWithRect:(CGRect) rect LineSpace:(int) lineSpace;
//
@property (nonatomic) NSNumber *leIsSupportCopy;
-(void) leAddLongPressGestureWithSel:(SEL) sel  Target:(id) target;
-(void) leAddCopyGesture;
@end

@interface LEAutoLayoutUIButtonSettings : NSObject
@property (nonatomic) NSString *leTitle;
@property (nonatomic) int leTitleFontSize;
@property (nonatomic) UIFont *leTitleFont;
@property (nonatomic) UIImage *leImage;
@property (nonatomic) UIImage *leBackgroundImage;
@property (nonatomic) UIImage *leImageHighlighted;
@property (nonatomic) UIImage *leBackgroundImageHighlighted;
@property (nonatomic) UIColor *leColorNormal;
@property (nonatomic) UIColor *leColorSelected;
@property (nonatomic) int leMaxWidth;
@property (nonatomic) SEL leSEL;
@property (nonatomic) id leTarget;
@property (nonatomic) int leSpace;
@property (nonatomic) CGSize leDeadSize;
-(id) initWithImage:(UIImage *) image SEL:(SEL) sel Target:(id) target;
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected MaxWidth:(int) width SEL:(SEL) sel Target:(id) target;
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected MaxWidth:(int) width SEL:(SEL) sel Target:(id) target HorizontalSpace:(int) space;
@end
@interface UIButton (LEExtension)
@property (nonatomic) LEAutoLayoutUIButtonSettings *leAutoLayoutButtonSettings;
-(void) leSetText:(NSString *) text;
-(void) leVerticallyLayoutButton;
@end

@interface LEAutoLayoutSettings : NSObject

@property (nonatomic) UIView *leSuperView;
@property (nonatomic) UIView *leRelativeView;

@property (nonatomic) LEAnchors leAnchor;

@property (nonatomic) CGPoint leOffset;
@property (nonatomic) CGSize  leSize;

@property (nonatomic) UIView *leRelativeChangeView;
@property (nonatomic) UIEdgeInsets leEdgeInsets;

//AutoLayout
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size;
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size;
-(id) initWithSuperView:(UIView *) superView EdgeInsects:(UIEdgeInsets) edge;
//AutoResize
-(void) leSetRelativeChangeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge;
@end

@interface UIView (LEUIViewFrameWorks)
@property (nonatomic) NSMutableArray *leAutoLayoutObservers;
@property (nonatomic) NSMutableArray *leAutoResizeObservers;
+(CGRect) leGetFrameWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
@property (nonatomic) LEAutoLayoutSettings *leAutoLayoutSettings;
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings; 
//
-(void) leAddAutoResizeRelativeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge;
-(void) leSetFrame:(CGRect) rect;
-(void) leSetOffset:(CGPoint) offset;
-(void) leSetSize:(CGSize) size;
-(void) leSetLeAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
-(void) leExecAutoLayout;
-(void) leExecAutoResize;
-(void) leExecAutoResizeWithEdgeInsets:(UIEdgeInsets) edge;
@end

@interface LEUIFramework : NSObject
@property (nonatomic,readonly) int leNavigationButtonFontsize;
@property (nonatomic,readonly) UIImage *leImageNavigationBack;
@property (nonatomic,readonly) UIImage *leImageNavigationBar;
@property (nonatomic,readonly) UIColor *leColorNavigationBar;
@property (nonatomic,readonly) UIColor *leColorNavigationContent;
@property (nonatomic,readonly) UIColor *leColorViewContainer;
@property (nonatomic,readonly) NSBundle *leFrameworksBundle;
@property (nonatomic,readonly) NSDateFormatter *leDateFormatter;
#pragma Singleton
LESingleton_interface(LEUIFramework)
#pragma public Variables
/** 设置导航栏按钮字体大小 */
-(void) leSetNavigationButtonFontsize:(int) fontsize;
/** 设置导航栏返回按钮 */
-(void) leSetImageNavigationBack:(UIImage *) image;
/** 设置导航栏颜色 */
-(void) leSetImageNavigationBar:(UIImage *) image;
/** 设置导航栏颜色 */
-(void) leSetColorNavigationBar:(UIColor *) color;
/** 设置导航栏标题颜色 */
-(void) leSetColorNavigationContent:(UIColor *) color;
/** 设置导航栏下方View的底色 */
-(void) leSetColorViewContainer:(UIColor *) color;
/** 设置时间打印格式 */
-(void) leSetDateFormatter:(NSDateFormatter *) formatter;
-(BOOL) leCanItBeTapped;
#pragma Common
+(NSString *) leIntToString:(int) i;
+(NSString *) leNumberToString:(NSNumber *) num;
+(UIFont *) leGetSystemFontWithSize:(int) size;
+(UIView *) getTransparentCircleLayerForView:(UIView *) view Diameter:(float) diameter MaskColor:(UIColor *) maskColor;
#pragma UIImage
+(UIImage *) leGetMiddleStrechedImage:(UIImage *) image ;
+(CGSize) leGetMiddleStrechedSize:(CGSize) size ;
+(UIImage *) leGetUIImage:(NSString *) name ;
+(UIImage *) leGetUIImage:(NSString *) name Streched:(BOOL) isStreched ;
+(CGSize) leGetSizeWithValue:(int) value;
#pragma UIImageView
+(UIImageView *) leGetImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(NSString *) image Streched:(BOOL) isStreched;
+(UIImageView *) leGetImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image ;
#pragma UITextfield
+(UITextField *) leGetTextFieldWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ReturnKeyType:(UIReturnKeyType) type Delegate:(id<UITextFieldDelegate>) delegate;
#pragma UILabel
+(UILabel *) leGetLabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ;
#pragma UIButton
+(UIButton *) leGetCoveredButtonWithSettings:(LEAutoLayoutSettings *) settings SEL:(SEL) sel Target:(id) target;
+(UIButton *) leGetButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings ;

+(UIImage *) leCreateQRForString:(NSString *)qrString Size:(CGFloat) size;
+(UIImage*) leImageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

+ (BOOL) leValidateMobile:(NSString *)mobileNum ;
+ (NSString *) leGetComboString:(id) string,...;
+ (NSString *) leTypeForImageData:(NSData *)data;
- (NSString *) leGetImagePathFromLEFrameworksWithName:(NSString *) name;
- (UIImage *) leGetImageFromLEFrameworksWithName:(NSString *) name;
@end













