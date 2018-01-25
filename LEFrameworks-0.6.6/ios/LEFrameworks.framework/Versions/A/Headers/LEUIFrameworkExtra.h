//
//  LEUIFrameworkExtra.h
//  Pods
//
//  Created by emerson larry on 16/7/25.
//
//

#import "LEUIFramework.h"
#define LEFormatAsLabel     (UILabel *)
#define LEFormatAsImage     (UIImageView *)
#define LEFormatAsButton    (UIButton *)
#define LEFormatAsTextField (UITextField *)

#pragma mark Typedef
#pragma mark _View
typedef __kindof UIView * (^LESuperView)         (UIView *value);
typedef __kindof UIView * (^LERelativeView)      (UIView *value);
typedef __kindof UIView * (^LEAnchor)            (LEAnchors value);
typedef __kindof UIView * (^LEOffset)            (CGPoint value);
typedef __kindof UIView * (^LESize)              (CGSize value);
typedef __kindof UIView * (^LEEdgeInsects)       (UIEdgeInsets value);
typedef __kindof UIView * (^LEBackground)        (UIColor *value);
typedef __kindof UIView * (^LEAutoLayout)        (void);
typedef __kindof UIView * (^LETypeAdapter)       (void);
typedef __kindof UIView * (^LEInit)              (void);
typedef __kindof UIView * (^LEUserInteraction)   (BOOL value);
typedef __kindof UIView * (^LETapEvent)          (SEL sel, id target);
typedef __kindof UIView * (^LERoundCorner)       (CGFloat radius);
#pragma mark _Label
typedef __kindof UIView * (^LEText)              (NSString *value);
typedef __kindof UIView * (^LEFont)              (UIFont *value);
typedef __kindof UIView * (^LEMaxWidth)          (CGFloat value);
typedef __kindof UIView * (^LEMaxHeight)         (CGFloat value);
typedef __kindof UIView * (^LEColor)             (UIColor *value);
typedef __kindof UIView * (^LELine)              (int value);
typedef __kindof UIView * (^LEAlignment)         (NSTextAlignment value);
typedef __kindof UIView * (^LELineSpace)         (CGFloat value);
#pragma mark _Button
typedef __kindof UIView * (^LEImage)                         (UIImage *value);
typedef __kindof UIView * (^LEImageHighlighted)              (UIImage *value);
typedef __kindof UIView * (^LEBackgroundImage)               (UIImage *value);
typedef __kindof UIView * (^LEBackgroundImageHighlighted)    (UIImage *value);
typedef __kindof UIView * (^LEHighlightedColor)              (UIColor *value);
typedef __kindof UIView * (^LEButtonHorizontalEdgeInsects)   (int value);
#pragma mark _TextField
typedef __kindof UIView * (^LEPlaceHolder)                   (NSString *value);
typedef __kindof UIView * (^LEReturnType)                    (UIReturnKeyType value);
typedef __kindof UIView * (^LEDelegateOfTextField)           (id<UITextFieldDelegate> value);

#pragma mark Properties
#pragma mark _View
@interface UIView (LEUIViewFrameWorksExtra)
@property (nonatomic, readonly)LESuperView         leSuperView;
@property (nonatomic, readonly)LERelativeView      leRelativeView;
@property (nonatomic, readonly)LEAnchor            leAnchor;
@property (nonatomic, readonly)LEOffset            leOffset;
@property (nonatomic, readonly)LESize              leSize;
@property (nonatomic, readonly)LEEdgeInsects       leEdgeInsects;
@property (nonatomic, readonly)LEBackground        leBackground;
@property (nonatomic, readonly)LEAutoLayout        leLayout;
@property (nonatomic, readonly)LEUserInteraction   leUserInteraction;
@property (nonatomic, readonly)LETapEvent          leTapEvent;
@property (nonatomic, readonly)LERoundCorner       leRoundCorner;
@property (nonatomic, readonly)LETypeAdapter       leTypeAdapter;
@property (nonatomic, readonly)LEInit              leInit;
#pragma mark for coomon settings
@property (nonatomic, readonly)LEText               leText;
@property (nonatomic, readonly)LEFont               leFont;
@property (nonatomic, readonly)LEMaxWidth           leWidth;
@property (nonatomic, readonly)LEMaxHeight          leHeight;
@property (nonatomic, readonly)LEColor              leColor;
@property (nonatomic, readonly)LELine               leLine;
@property (nonatomic, readonly)LEAlignment          leAlignment;
@property (nonatomic, readonly)LELineSpace          leLineSpace;
@property (nonatomic, readonly)LEImage              leImage;
#pragma mark button
@property (nonatomic, readonly)LEImageHighlighted               leImageHighlighted;
@property (nonatomic, readonly)LEBackgroundImage                leBackgroundImage;
@property (nonatomic, readonly)LEBackgroundImageHighlighted     leBackgroundImageHighlighted;
@property (nonatomic, readonly)LEHighlightedColor               leHighlightedColor;
@property (nonatomic, readonly)LEButtonHorizontalEdgeInsects    leButtonGap;
#pragma mark textfield 
@property (nonatomic, readonly)LEPlaceHolder            lePlaceHolder;
@property (nonatomic, readonly)LEReturnType             leReturnType;
@property (nonatomic, readonly)LEDelegateOfTextField    leDelegateOfTextField;
/**
 设置父view，配合leAnchor。
 */
-(void) leSuperView:(UIView *) view;
/**
 设置参照view。等同父view时可忽略。配合leAnchor，参照view为父view时使用LEAnchorInside，否则使用LEAnchorOutside
 */
-(void) leRelativeView:(UIView *) view;
/**
 设置对齐方式，配合leRelativeView参照view使用。参照view为父view时使用LEAnchorInside，否则使用LEAnchorOutside
 */
-(void) leAnchor:(LEAnchors) anchor;
/**
 设置与参照view的偏移量。左:-x,右:x,上:-y,下:y
 */
-(void) leOffset:(CGPoint) offset;
/**
 设置view的size。Label、image、button的设置可能会失效。
 */
-(void) leSize:(CGSize) size;
/**
 设置内嵌于父view时的edgeInsects。设置后无需设置leAnchor、leOffset及leSize
 */
-(void) leEdgeInsects:(UIEdgeInsets) edgeInsects;
/**
 设置背景色。
 */
-(void) leBackground:(UIColor *) color;
/**
 根据提供条件排版
 */
-(__kindof UIView *) leAutoLayout;
/**
 设置是否运行用户交互
 */
-(void) leUserInteraction:(BOOL) enable;
/**
 (接口已废弃，无需使用)为了去除类型的警告，进行类型适配。
 */
-(__kindof UIView *) leType;
/**
 新：用于创建view时调用初始化leAdditionalInits。旧：等同于 leAdditionalInits+leType。使用情况：view比较复杂，初始化时需要执行并且已经实现了leAdditionalInits
 */
-(__kindof UIView *) leInitSelf;
/**
 给当前view添加tap事件，如果是button走addTarget方式
 */
-(void) leTapEvent:(SEL) sel Target:(id) target;
/**
 设置view的圆角
 */
-(void) leRoundCorner:(CGFloat) radius;
#pragma mark Common settings
/**
 设置文字，用于label、textfield、button
 */
-(void) leText:(NSString *) text;
/**
 设置文号，用于label、textfield、button
 */
-(void) leFont:(UIFont *) font;
/**
 设置view最大宽度，用于所有
 */
-(void) leWidth:(CGFloat) width;
/**
 设置view最大高度，用于所有
 */
-(void) leHeight:(CGFloat) height;
/**
 设置颜色，用于label、textfield、button的normal未选中状态文字颜色
 */
-(void) leColor:(UIColor *) color;
/**
 设置对齐方式，用于label、textfield
 */
-(void) leAlignment:(NSTextAlignment) alignment;
/**
 设置image，用于imageview或button的normal状态的image
 */
-(void) leImage:(UIImage *) image;
#pragma mark label
/**
 设置文字行数
 */
-(void) leLine:(int) line;
/**
 设置文字行间距
 */
-(void) leLineSpace:(CGFloat) linespace;
#pragma mark _Button
/**
 设置选中状态的image
 */
-(void) leImageHighlighted:(UIImage *) image;
/**
 设置未选中状态的背景图backgroundimage
 */
-(void) leBackgroundImage:(UIImage *) image;
/**
 设置选中状态的背景图backgroundimage
 */
-(void) leBackgroundImageHighlighted:(UIImage *) image;
/**
 设置选中状态的文字颜色
 */
-(void) leHighlightedColor:(UIColor *) color;
/**
 设置选中状态的image
 */
-(void) leButtonHorizontalEdgeInsects:(int) gap;
#pragma mark _TextField
/**
 设置文字占位符
 */
-(void) lePlaceHolder:(NSString *) placeHolder;
/**
 设置键盘右下角按钮样式
 */
-(void) leRetureType:(UIReturnKeyType) returnType;
/**
 设置textfield的delegate
 */
-(void) leDelegateOfTextField:(id<UITextFieldDelegate>) delegateOfTextField;
@end

#pragma mark below is old version, not suggested 以下是旧版本内容，不建议使用

#pragma mark UILabel
typedef UILabel * (^LELabelText)        (NSString *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelFont)        (UIFont *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelWidth)       (CGFloat value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelHeight)      (CGFloat value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelColor)       (UIColor *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelLine)        (int value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelAlignment)   (NSTextAlignment value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UILabel * (^LELabelLineSpace)   (CGFloat value) NS_DEPRECATED_IOS(7_0, 10_0);
@interface UILabel (LEUILabelFrameWorksExtra)
@property (nonatomic, readonly)LELabelText          leText NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelFont          leFont NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelWidth         leWidth NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelHeight        leHeight NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelColor         leColor NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelLine          leLine NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelAlignment     leAlignment NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LELabelLineSpace     leLineSpace NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leText:(NSString *) text NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leFont:(UIFont *) font NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leWidth:(CGFloat) width NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leHeight:(CGFloat) height NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leColor:(UIColor *) color NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leLine:(int) line NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leAlignment:(NSTextAlignment) alignment NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leLineSpace:(CGFloat) space NS_DEPRECATED_IOS(7_0, 10_0);
/**
 对当前label进行排版
 */
-(void) leLabelLayout;
@end
#pragma mark UIButton
typedef UIButton * (^LEButtonText)                  (NSString *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonFont)                  (UIFont *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonImage)                 (UIImage *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonBackground)            (UIImage *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonImageHighlighted)      (UIImage *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonBackgroundHighlighted) (UIImage *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonNormalColor)           (UIColor *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonHighlightedColor)      (UIColor *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonMaxWidth)              (int value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonTapEvent)              (SEL sel, id target) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonGap)                   (int value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIButton * (^LEButtonDeadSize)                  (CGSize value) NS_DEPRECATED_IOS(7_0, 10_0);
@interface UIButton (LEUIButtonFrameWorksExtra)
@property (nonatomic, readonly)LEButtonText                     leText NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonFont                     leFont NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonImage                    leImage NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonBackground               leBackgroundImage NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonImageHighlighted         leImageHighlighted NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonBackgroundHighlighted    leBackgroundImageHighlighted NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonNormalColor              leNormalColor NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonHighlightedColor         leHighlightedColor NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonMaxWidth                 leMaxWidth NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonTapEvent                 leTapEvent NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonGap                      leGap NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEButtonDeadSize                 leButtonSize NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leText:(NSString *) text NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leButtonSize:(CGSize) size NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leFont:(UIFont *) font NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leImage:(UIImage *) image NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leBackgroundImage:(UIImage *)image NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leImageHighlighted:(UIImage *) image NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leBackgroundImageHighlighted:(UIImage *)image NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leNormalColor:(UIColor *) color NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leHighlighted:(UIColor *) color NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leMaxWidth:(int) width NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leTapEvent:(SEL) sel Target:(id) target NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leGap:(int) gap NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leSetForTapEventWithSel:(SEL) sel Target:(id) target NS_DEPRECATED_IOS(7_0, 10_0);
/**
 对当前button进行排版
 */
-(void) leButtonLayout;
@end
#pragma mark UITextField
typedef UITextField * (^LETextFieldPlaceHolder)           (NSString *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UITextField * (^LETextFieldFont)                  (UIFont *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UITextField * (^LETextFieldColor)                 (UIColor *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UITextField * (^LETextFieldAlignment)             (NSTextAlignment value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UITextField * (^LETextFieldReturnType)            (UIReturnKeyType value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UITextField * (^LETextFieldDelegate)              (id<UITextFieldDelegate> value) NS_DEPRECATED_IOS(7_0, 10_0);
@interface UITextField (LEUITextFieldFrameWorksExtra)
@property (nonatomic, readonly)LETextFieldPlaceHolder     lePlaceHolder NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LETextFieldFont            leFont NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LETextFieldColor           leColor NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LETextFieldAlignment       leAlignment NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LETextFieldReturnType      leReturnType NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LETextFieldDelegate        leDelegate NS_DEPRECATED_IOS(7_0, 10_0);
-(void) lePlaceHolder:(NSString *) text NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leFont:(UIFont *) font NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leColor:(UIColor *) color NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leAlignment:(NSTextAlignment) alignment NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leReturnType:(UIReturnKeyType) returnType NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leDelegate:(id<UITextFieldDelegate>) delegate NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leTextFieldLayout NS_DEPRECATED_IOS(7_0, 10_0);
@end
#pragma mark UIImageView
typedef UIImageView * (^LEImageWithImageSize)       (UIImage *value) NS_DEPRECATED_IOS(7_0, 10_0);
typedef UIImageView * (^LEImageWithinFrame)         (UIImage *value) NS_DEPRECATED_IOS(7_0, 10_0);
@interface UIImageView (LEUIUIImageViewFrameWorksExtra)
@property (nonatomic, readonly)LEImageWithImageSize     leImage NS_DEPRECATED_IOS(7_0, 10_0);
@property (nonatomic, readonly)LEImageWithinFrame       leImageWithinFrame NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leImage:(UIImage *) image NS_DEPRECATED_IOS(7_0, 10_0);
-(void) leImageWithinFrame:(UIImage *) image NS_DEPRECATED_IOS(7_0, 10_0);
@end



