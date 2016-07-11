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

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define singleton_interface(className) \
+ (className *)sharedInstance;

#define singleton_implementation(className) \
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

#define LEWeakSelf __weak typeof(self) weakSelf = self;

#pragma mark 资源名称需要对应
#define IMG_Cell_RightArrow     [[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_tableview_icon_arrow"]
#define IMG_ArrowLeft           [[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_common_navigation_btn_back"]

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
#define LayoutSideSpace60                                        60
#define LayoutSideSpace27                                        27
#define LayoutSideSpace20                                        20
#define LayoutSideSpace16                                        16
#define LayoutSideSpace                                          10
#define LayoutChildSideSpace                                     7
#define LayoutInputSpace                                         20
#define LayoutContentBottomSpace45                               45
#define LayoutContentTopSpace30                                  30
#define LayoutContentBottomSpace30                               30
#define LayoutContentTopSpace20                                  20
#define LayoutContentBottomSpace20                               20
#define LayoutContentTopSpace                                    15
#define LayoutContentBottomSpace                                 15
#define LayoutChildContentTopSpace                               10
#define LayoutChildContentBottomSpace                            10
#pragma mark Layout Linespace
#define LayoutTextLineSpace30                                    30
#define LayoutTextLineSpace24                                    24
#define LayoutTextLineSpace20                                    20
#define LayoutTextLineSpace15                                    15
#define LayoutTextLineSpace14                                    14
#define LayoutTextLineSpace                                      12
#define LayoutChildTextLineSpace                                 10
#define LayoutSnapshotTextLineSpace                              7
#pragma mark Layout Avatar
#define LayoutAvatarSizeBig                                      60
#define LayoutAvatarSizeMid                                      40
#define LayoutAvatarSize                                         30
#define LayoutAvatarSpace                                        20
#pragma mark LayoutFont
#define LayoutFontSize70                                         70
#define LayoutFontSize30                                         30
#define LayoutFontSize20                                         20
#define LayoutFontSize17                                         17
#define LayoutFontSize14                                         14
#define LayoutFontSize13                                         13
#define LayoutFontSize12                                         12
#define LayoutFontSize10                                         10
#define LayoutFontSize9                                          9
#define LayoutFontSize7                                          7
#pragma mark Layout Input Height
#define LayoutCommentInputHeight                                 100
#define LayoutInputHeight                                        35
#pragma mark Logs
#define NSLogFunc   fprintf(stderr,"=> FUNC: %s\n",__FUNCTION__);
#define NSLogObject(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"%@", ##__VA_ARGS__] UTF8String]);
#define NSLogInt(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"%d", ##__VA_ARGS__] UTF8String]);
#define NSLogStringAngInt(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"%@ : %d", ##__VA_ARGS__] UTF8String]);
#define NSLogTwoObjects(...) fprintf(stderr,"=> FUNC: %s %s\n",__FUNCTION__,[[NSString stringWithFormat:@"@@\n-->%@\n-->%@", ##__VA_ARGS__] UTF8String]);
#define NSLog(FORMAT, ...) fprintf(stderr,"=> (Line:%d) %s %s\n",__LINE__,__FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#pragma mark 数据存储
#define SXUserDefaults  [NSUserDefaults standardUserDefaults]
#define SXCacheDir      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define SXDocumentDir   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define SXTempDir       NSTemporaryDirectory()
#pragma mark DeviceInfo
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
//#define iPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#pragma mark View
#define LELabelMaxSize CGSizeMake(MAXFLOAT, MAXFLOAT)
#define LeTextShadowColor [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3]
#define LeTextShadowSize CGSizeMake(0.5, 0.5)
#define DefaultButtonVerticalSpace 6
#define DefaultButtonHorizontalSpace 12

#define NavigationBarFontSize 18
#define NavigationBarHeight 44
#define StatusBarHeight 20 
#define BottomTabbarHeight 50
//#define iPhone6ScaleRate 1//(iPhone6||iPhone6Plus?1.25:1)
//#define iPhone6ScaleRateSmall 1//(iPhone6||iPhone6Plus?1.1:1)
//#define iPhoneBigScale  iPhone6||iPhone6Plus
// 
//
#define DefaultCellHeightBig 64
#define DefaultCellHeightMid 52
#define DefaultCellHeightSml 44
#define DefaultCellHeight (IS_IPHONE_6P?DefaultCellHeightBig:(IS_IPHONE_6?DefaultCellHeightMid:DefaultCellHeightSml))
#define DefaultCellIconRect 30

#define DefaultSectionHeight 12
#define DefaultSectionHeightBig 24
#define ColorTableViewGray [UIColor colorWithWhite:0.941 alpha:1.000]

#pragma mark Define Colors
#define ColorGrayDark           [UIColor colorWithRed:0.1959 green:0.2207 blue:0.2707 alpha:1.0]
#define ColorGray               [UIColor colorWithRed:0.6384 green:0.6588 blue:0.7095 alpha:1.0]
#define ColorGrayLight          [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9412 alpha:1.0]
#define ColorTextBlack          [UIColor colorWithRed:0.2549 green:0.2863 blue:0.3412 alpha:1.0]
#define ColorTextGray           [UIColor colorWithRed:0.6966 green:0.7178 blue:0.76    alpha:1.0]
#define ColorBlue               [UIColor colorWithRed:0.1922 green:0.4204 blue:0.8959 alpha:1.0]
#define ColorRed 				[UIColor colorWithRed:0.949 green:0.3451 blue:0.3451  alpha:1.0]
#define ColorSplit              [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.08]
#define ColorTest               [UIColor colorWithRed:0.867 green:0.852 blue:0.539 alpha:1.000]
#define ColorClear              [UIColor clearColor]
#define ColorWhite              [UIColor whiteColor]
#define ColorBlack              [UIColor blackColor]
#define ColorMaskLight          [[UIColor alloc] initWithWhite:0.906 alpha:1.000]
#define ColorMask               [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.1]
#define ColorMask2              [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.2]
#define ColorMask5              [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]
#define ColorMask8              [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.8]
#pragma mark Image Type
#define ImageTypeAsJpeg @"image/jpeg"
#define ImageTypeAsPng  @"image/png"
#define ImageTypeAsGif  @"image/gif"
#define ImageTypeAsTiff @"image/tiff"
#pragma mark other
#define LayoutFontNameArialRoundedMTBold      @"Arial Rounded MT Bold"

#define LEFont(size) [UIFont systemFontOfSize:size]
#define LEBoldFont(size) [UIFont boldSystemFontOfSize:size]


@interface UIViewController (Extension)
-(void) setLeftBarButtonWithImage:(UIImage *) img SEL:(SEL) sel;
-(void) setRightBarButtonWithImage:(UIImage *)img SEL:(SEL) sel;
-(void) setLeftBarButtonAsBackWith:(UIImage *) back;
-(void) setNavigationTitle:(NSString *) title;
-(void) leThroughNavigationAnimatedPush:(UIViewController *) vc;
-(void) lePopSelfAnimated;
@end
@interface NSObject (Extension)
-(NSString *) StringValue;
@end

@interface UIView (Extension)
-(void) addLocalNotification:(NSString *) notification;
-(void) endEdit;
-(void) addTapEventWithSEL:(SEL) sel;
-(void) addTapEventWithSEL:(SEL)sel Target:(id) target;
-(UIImageView *) addTopSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width;
-(UIImageView *) addBottomSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width;
@end

@interface UIImage (Extension)
-(UIImage *)middleStrechedImage;
@end

@interface UIColor (Extension)
-(UIImage *)imageStrechedFromSizeOne;
-(UIImage *)imageWithSize:(CGSize)size;
@end

@interface NSString (Extension)
-(int) asciiLength;
-(CGSize) getSizeWithFont:(UIFont *)font MaxSize:(CGSize) size;
-(NSObject *) getInstanceFromClassName;
-(NSString *) getTrimmedString;
@end

@interface UILabel (Extension)
//- (void)alignTop;
//- (void)alignBottom;
-(void) leSetText:(NSString *) text;
-(CGSize) getLabelTextSize;
-(CGSize) getLabelTextSizeWithMaxWidth:(int) width;
-(void) leSetLineSpace:(float) space;
-(void) leSetLinespace:(float) space Color:(UIColor *) color Range:(NSRange) range;
-(void) redrawAttributedStringWithRect:(CGRect) rect LineSpace:(int) lineSpace;
//
@property (nonatomic) NSNumber *isSupportCopy;
-(void) addLongPressGestureWithSel:(SEL) sel  Target:(id) target;
-(void) addCopyGesture;
@end
@interface UIImageView (Extension)
-(void) leSetImage:(UIImage *) image;
-(void) leSetImage:(UIImage *) image WithSize:(CGSize) size;
@end 
@interface UIButton (Extension)
-(void) leSetText:(NSString *) text;
-(void) verticallyLayoutButton;
@end

@interface LEAutoLayoutSettings : NSObject

@property (nonatomic) UIView *leSuperView;
@property (nonatomic) UIView *leRelativeView;

@property (nonatomic) LEAnchors leAnchor;

@property (nonatomic) CGPoint leOffset;
@property (nonatomic) CGSize leSize;

@property (nonatomic) UIView *leRelativeChangeView;
@property (nonatomic) UIEdgeInsets leEdgeInsets;

@property (nonatomic) int leLabelMaxWidth;
@property (nonatomic) int leLabelMaxHeight;
@property (nonatomic) int leLabelNumberOfLines;
@property (nonatomic) int leButtonMaxWidth;
//AutoLayout
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size;
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size;
-(id) initWithSuperView:(UIView *)superView EdgeInsects:(UIEdgeInsets) edge;
//AutoResize
-(void) setRelativeChangeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge;
@end

@interface UIView (LEUIViewFrameWorks)
+(CGRect) getFrameWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
@property (nonatomic) LEAutoLayoutSettings *leAutoLayoutSettings;
@property (nonatomic) NSMutableArray *leAutoLayoutObservers;
@property (nonatomic) NSMutableArray *leAutoResizeObservers;
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings;
-(void) addAutoResizeRelativeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge;
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

@interface LEUIFramework : NSObject{
    BOOL canItBeTappedVariable;
}
#pragma Singleton
singleton_interface(LEUIFramework)
#pragma public Variables
@property (nonatomic) UIColor *colorNavigationBar;
@property (nonatomic) UIColor *colorNavigationContent;
@property (nonatomic) UIColor *colorViewContainer;
@property (nonatomic) UIScreen *curScreen;
@property (nonatomic) int curScreenScale;
@property (nonatomic) int ScreenWidth;
@property (nonatomic) int ScreenHeight;
//@property (nonatomic) BOOL IsStatusBarNotCovered;
@property (nonatomic) CGRect ScreenBounds;
@property (nonatomic) NSString *SystemVersion;
@property (nonatomic) BOOL IsIOS7;
@property (nonatomic) BOOL IsIOS8;
@property (nonatomic) BOOL IsIOS8OrLater;
//
@property (nonatomic) NSBundle *leFrameworksBundle;
@property (nonatomic) NSDateFormatter *dateFormatter; 
-(BOOL) canItBeTapped;
#pragma Common
+(NSString *) intToString:(int) i;
+(NSString *) numberToString:(NSNumber *) num;
+(UIFont *) getSystemFontWithSize:(int) size;
#pragma UIImage
+(UIImage *) getMiddleStrechedImage:(UIImage *) image ;
+(CGSize) getMiddleStrechedSize:(CGSize) size ;
+(UIImage *) getUIImage:(NSString *) name ;
+(UIImage *) getUIImage:(NSString *) name Streched:(BOOL) isStreched ;
+(CGSize) getSizeWithValue:(int) value;
#pragma UIImageView
+(UIImageView *) getUIImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(NSString *) image Streched:(BOOL) isStreched;
+(UIImageView *) getUIImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image ;
#pragma UITextfield
+(UITextField *) getUITextFieldWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ReturnKeyType:(UIReturnKeyType) type Delegate:(id<UITextFieldDelegate>) delegate;
#pragma UILabel
+(UILabel *) getUILabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ;
#pragma UIButton
+(UIButton *) getCoveredButtonWithSettings:(LEAutoLayoutSettings *) settings SEL:(SEL) sel Target:(id) target;
+(UIButton *) getUIButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings ;

+(UIImage *)createQRForString:(NSString *)qrString Size:(CGFloat) size;
+(UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

+ (BOOL)validateMobile:(NSString *)mobileNum ;
+ (NSString *) getComboString:(id) string,...;
+ (NSString *)typeForImageData:(NSData *)data;
- (NSString *) getImagePathFromLEFrameworksWithName:(NSString *) name;
- (UIImage *) getImageFromLEFrameworksWithName:(NSString *) name;
@end













