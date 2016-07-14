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

#define LESuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define LESingleton_interface(className) \
+ (className *)sharedInstance;

#define LESingleton_implementation(className) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
[_instace leExtraInits];\
}); \
return _instace; \
} \
\
+ (instancetype)sharedInstance \
{ \
return [[self alloc] init]; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}



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
#define LELayoutSideSpace                                          10
#define LELayoutChildSideSpace                                     7
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
#define LELayoutSnapshotTextLineSpace                              7
#pragma mark Layout Avatar
#define LELayoutAvatarSizeBig                                      60
#define LELayoutAvatarSizeMid                                      40
#define LELayoutAvatarSize                                         30
#define LELayoutAvatarSpace                                        20
#pragma mark LayoutFont
#define LELayoutFontSize70                                         70
#define LELayoutFontSize30                                         30
#define LELayoutFontSize20                                         20
#define LELayoutFontSize17                                         17
#define LELayoutFontSize14                                         14
#define LELayoutFontSize13                                         13
#define LELayoutFontSize12                                         12
#define LELayoutFontSize10                                         10
#define LELayoutFontSize9                                          9
#define LELayoutFontSize7                                          7
#pragma mark Layout Input Height
#define LELayoutCommentInputHeight                                 100
#define LELayoutInputHeight                                        35
#pragma mark Logs
#define LELogFunc   fprintf(stderr,"=> FUNC: %s\n",__FUNCTION__);
#define LELogObject(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"%@", ##__VA_ARGS__] UTF8String]);
#define LELogInt(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"%d", ##__VA_ARGS__] UTF8String]);
#define LELogStringAngInt(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"%@ : %d", ##__VA_ARGS__] UTF8String]);
#define LELogTwoObjects(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"@@\n-->%@\n-->%@", ##__VA_ARGS__] UTF8String]);
#define LELog(FORMAT, ...) fprintf(stderr,"=> (Line:%d) %s %s\n",__LINE__,__FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#pragma mark 数据存储
#define LEUserDefaults  [NSUserDefaults standardUserDefaults]
#define LECacheDir      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define LEDocumentDir   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define LETempDir       NSTemporaryDirectory()
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
//#define iPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define LEDevice    TARGET_OS_IPHONE
#define LESimulator TARGET_IPHONE_SIMULATOR

#define LEWeakSelf(type)  __weak typeof(type) weak##type = type;
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
#define LELabelMaxSize CGSizeMake(MAXFLOAT, MAXFLOAT)
#define LeTextShadowColor [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3]
#define LeTextShadowSize CGSizeMake(0.5, 0.5)

#define LEDefaultButtonVerticalSpace 6
#define LEDefaultButtonHorizontalSpace 12

#define LENavigationBarFontSize 18
#define LENavigationBarHeight 44
#define LEStatusBarHeight 20 
#define LEBottomTabbarHeight 50
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

#define LEDefaultSectionHeight 12
#define LEDefaultSectionHeightBig 24

#pragma mark Define Colors
#define LEColorTableViewGray      [UIColor colorWithWhite:0.941 alpha:1.000]
#define LEColorGrayDark           [UIColor colorWithRed:0.1959 green:0.2207 blue:0.2707 alpha:1.0]
#define LEColorGray               [UIColor colorWithRed:0.6384 green:0.6588 blue:0.7095 alpha:1.0]
#define LEColorGrayLight        [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9412 alpha:1.0]
#define LEColorTextBlack          [UIColor colorWithRed:0.2549 green:0.2863 blue:0.3412 alpha:1.0]
#define LEColorTextGray           [UIColor colorWithRed:0.6966 green:0.7178 blue:0.76    alpha:1.0]
#define LEColorBlue               [UIColor colorWithRed:0.1922 green:0.4204 blue:0.8959 alpha:1.0]
#define LEColorRed 				  [UIColor colorWithRed:0.949 green:0.3451 blue:0.3451  alpha:1.0]
#define LEColorSplit              [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.08]
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
#pragma mark ? To String
#define LEIntToString(__int) [NSString stringWithFormat:@"%d",(int)__int]
#define LENumberToString(__number) [NSString stringWithFormat:@"%@",(NSNumber *)__number]
#define LEIntegerToInt(__integer) ((int)__integer)


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
-(void) leExtraInits;
@end

@interface UIView (LEExtension)
-(void) leAddLocalNotification:(NSString *) notification;
-(void) leEndEdit;
-(void) leAddTapEventWithSEL:(SEL) sel;
-(void) leAddTapEventWithSEL:(SEL)sel Target:(id) target;
-(UIImageView *) leAddTopSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width;
-(UIImageView *) leAddBottomSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width;
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
-(NSObject *) leGetInstanceFromClassName;
-(NSString *) leGetTrimmedString;
@end

@interface UILabel (LEExtension)
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
@interface UIImageView (LEExtension)
-(void) leSetImage:(UIImage *) image;
-(void) leSetImage:(UIImage *) image WithSize:(CGSize) size;
@end 
@interface UIButton (LEExtension)
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

@property (nonatomic) int leLabelMaxWidth;
@property (nonatomic) int leLabelMaxHeight;
@property (nonatomic) int leLabelNumberOfLines;
@property (nonatomic) int leButtonMaxWidth;
//AutoLayout
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size;
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size;
-(id) initWithSuperView:(UIView *) superView EdgeInsects:(UIEdgeInsets) edge;
//AutoResize
-(void) leSetRelativeChangeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge;
@end

@interface UIView (LEUIViewFrameWorks)
+(CGRect) leGetFrameWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
@property (nonatomic) LEAutoLayoutSettings *leAutoLayoutSettings;
@property (nonatomic) NSMutableArray *leAutoLayoutObservers;
@property (nonatomic) NSMutableArray *leAutoResizeObservers;
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
-(void) leAddAutoResizeRelativeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge;
-(void) leSetFrame:(CGRect) rect;
-(void) leSetOffset:(CGPoint) offset;
-(void) leSetSize:(CGSize) size;
-(void) leSetLeAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
-(void) leExecAutoLayout;
-(void) leExecAutoResize;
-(void) leExecAutoResizeWithEdgeInsets:(UIEdgeInsets) edge;
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

@interface LEAutoLayoutUIButtonSettings : NSObject
@property (nonatomic) NSString *leTitle;
@property (nonatomic) int leTitleFontSize;
@property (nonatomic) UIFont *leTitleFont;
@property (nonatomic) UIImage *leImage;
@property (nonatomic) UIImage *leBackgroundImage;
@property (nonatomic) UIColor *leColorNormal;
@property (nonatomic) UIColor *leColorSelected;
@property (nonatomic) SEL leSEL;
@property (nonatomic) int leMaxWidth;
@property (nonatomic) UIView *leTargetView;
@property (nonatomic) int leSpace;
-(id) initWithImage:(UIImage *) image SEL:(SEL) sel Target:(UIView *) view;
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected MaxWidth:(int) width SEL:(SEL) sel Target:(UIView *) view;
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected MaxWidth:(int) width SEL:(SEL) sel Target:(UIView *) view HorizontalSpace:(int) space;
@end

@interface LEUIFramework : NSObject
@property (nonatomic,readonly) UIColor *leColorNavigationBar;
@property (nonatomic,readonly) UIColor *leColorNavigationContent;
@property (nonatomic,readonly) UIColor *leColorViewContainer;
@property (nonatomic,readonly) NSBundle *leFrameworksBundle;
@property (nonatomic,readonly) NSDateFormatter *leDateFormatter;
#pragma Singleton
LESingleton_interface(LEUIFramework)
#pragma public Variables
/*
 * @brief 设置导航栏颜色
 */
-(void) leSetColorNavigationBar:(UIColor *) color;
/*
 * @brief 设置导航栏标题颜色
 */
-(void) leSetColorNavigationContent:(UIColor *) color;
/*
 * @brief 设置导航栏下方View的底色
 */
-(void) leSetColorViewContainer:(UIColor *) color;
/*
 * @brief 设置时间打印格式
 */
-(void) leSetDateFormatter:(NSDateFormatter *) formatter;
-(BOOL) leCanItBeTapped;
#pragma Common
+(NSString *) leIntToString:(int) i;
+(NSString *) leNumberToString:(NSNumber *) num;
+(UIFont *) leGetSystemFontWithSize:(int) size;
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













