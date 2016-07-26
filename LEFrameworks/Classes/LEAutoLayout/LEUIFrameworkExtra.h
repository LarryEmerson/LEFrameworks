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

#pragma mark UIView
typedef UIView * (^LESuperView)         (UIView *value);
typedef UIView * (^LERelativeView)      (UIView *value);
typedef UIView * (^LEAnchor)            (LEAnchors value);
typedef UIView * (^LEOffset)            (CGPoint value);
typedef UIView * (^LESize)              (CGSize value);
typedef UIView * (^LEEdgeInsects)       (UIEdgeInsets value);
typedef UIView * (^LEBackground)        (UIColor *value);
typedef UIView * (^LEAutoLayout)        (void);
typedef id       (^LETypeAdapter)       (void);
typedef UIView * (^LEUserInteraction)   (BOOL value);
typedef UIView * (^LETapEvent)          (SEL sel, id target);
typedef UIView * (^LERoundCorner)       (CGFloat radius);

@interface UIView (LEUIViewFrameWorksExtra)
@property (nonatomic, readonly)LESuperView         leSuperView;
@property (nonatomic, readonly)LERelativeView      leRelativeView;
@property (nonatomic, readonly)LEAnchor            leAnchor;
@property (nonatomic, readonly)LEOffset            leOffset;
@property (nonatomic, readonly)LESize              leSize;
@property (nonatomic, readonly)LEEdgeInsects       leEdgeInsects;
@property (nonatomic, readonly)LEBackground        leBackground;
@property (nonatomic, readonly)LEAutoLayout        leLayout;
@property (nonatomic, readonly)LETypeAdapter       leTypeAdapter;
@property (nonatomic, readonly)LEUserInteraction   leUserInteraction;
@property (nonatomic, readonly)LETapEvent          leTapEvent;
@property (nonatomic, readonly)LERoundCorner       leRoundCorner;
-(void) leSuperView:(UIView *) view;
-(void) leRelativeView:(UIView *) view;
-(void) leAnchor:(LEAnchors) anchor;
-(void) leOffset:(CGPoint) offset;
-(void) leSize:(CGSize) size;
-(void) leEdgeInsects:(UIEdgeInsets) edgeInsects;
-(void) leBackground:(UIColor *) color;
-(UIView *) leAutoLayout;
-(void) leUserInteraction:(BOOL) enable;
-(id) leType;
-(void) leTapEvent:(SEL) sel Target:(id) target;
-(void) leRoundCorner:(CGFloat) radius;
@end
#pragma mark UILabel
typedef UILabel * (^LELabelText)        (NSString *value);
typedef UILabel * (^LELabelFont)        (UIFont *value);
typedef UILabel * (^LELabelWidth)       (CGFloat value);
typedef UILabel * (^LELabelHeight)      (CGFloat value);
typedef UILabel * (^LELabelColor)       (UIColor *value);
typedef UILabel * (^LELabelLine)        (int value);
typedef UILabel * (^LELabelAlignment)   (NSTextAlignment value);
typedef UILabel * (^LELabelLineSpace)   (CGFloat value);
@interface UILabel (LEUILabelFrameWorksExtra)
@property (nonatomic, readonly)LELabelText          leText;
@property (nonatomic, readonly)LELabelFont          leFont;
@property (nonatomic, readonly)LELabelWidth         leWidth;
@property (nonatomic, readonly)LELabelHeight        leHeight;
@property (nonatomic, readonly)LELabelColor         leColor;
@property (nonatomic, readonly)LELabelLine          leLine;
@property (nonatomic, readonly)LELabelAlignment     leAlignment;
@property (nonatomic, readonly)LELabelLineSpace     leLineSpace;
-(void) leText:(NSString *) text;
-(void) leFont:(UIFont *) font;
-(void) leWidth:(CGFloat) width;
-(void) leHeight:(CGFloat) height;
-(void) leColor:(UIColor *) color;
-(void) leLine:(int) line;
-(void) leAlignment:(NSTextAlignment) alignment;
-(void) leLineSpace:(CGFloat) space;
-(void) leLabelLayout;
@end
#pragma mark UIButton
typedef UIButton * (^LEButtonText)                  (NSString *value);
typedef UIButton * (^LEButtonFont)                  (UIFont *value);
typedef UIButton * (^LEButtonImage)                 (UIImage *value);
typedef UIButton * (^LEButtonBackground)            (UIImage *value);
typedef UIButton * (^LEButtonImageHighlighted)      (UIImage *value);
typedef UIButton * (^LEButtonBackgroundHighlighted) (UIImage *value);
typedef UIButton * (^LEButtonNormalColor)           (UIColor *value);
typedef UIButton * (^LEButtonHighlightedColor)      (UIColor *value);
typedef UIButton * (^LEButtonMaxWidth)              (int value);
typedef UIButton * (^LEButtonTapEvent)              (SEL sel, id target);
typedef UIButton * (^LEButtonGap)                   (int value);
@interface UIButton (LEUIButtonFrameWorksExtra)
@property (nonatomic, readonly)LEButtonText                     leText;
@property (nonatomic, readonly)LEButtonFont                     leFont;
@property (nonatomic, readonly)LEButtonImage                    leImage;
@property (nonatomic, readonly)LEButtonBackground               leBackgroundImage;
@property (nonatomic, readonly)LEButtonImageHighlighted         leImageHighlighted;
@property (nonatomic, readonly)LEButtonBackgroundHighlighted    leBackgroundImageHighlighted;
@property (nonatomic, readonly)LEButtonNormalColor              leNormalColor;
@property (nonatomic, readonly)LEButtonHighlightedColor         leHighlightedColor;
@property (nonatomic, readonly)LEButtonMaxWidth                 leMaxWidth;
@property (nonatomic, readonly)LEButtonTapEvent                 leTapEvent;
@property (nonatomic, readonly)LEButtonGap                      leGap;
-(void) leText:(NSString *) text;
-(void) leFont:(UIFont *) font;
-(void) leImage:(UIImage *) image;
-(void) leBackgroundImage:(UIImage *)image;
-(void) leImageHighlighted:(UIImage *) image;
-(void) leBackgroundImageHighlighted:(UIImage *)image;
-(void) leNormalColor:(UIColor *) color;
-(void) leHighlighted:(UIColor *) color;
-(void) leMaxWidth:(int) width;
-(void) leTapEvent:(SEL) sel Target:(id) target;
-(void) leGap:(int) gap;
-(void) leButtonLayout;
-(void) leSetForTapEventWithSel:(SEL) sel Target:(id) target;
@end
#pragma mark UITextField
typedef UITextField * (^LETextFieldPlaceHolder)           (NSString *value);
typedef UITextField * (^LETextFieldFont)                  (UIFont *value);
typedef UITextField * (^LETextFieldColor)                 (UIColor *value);
typedef UITextField * (^LETextFieldAlignment)             (NSTextAlignment value);
typedef UITextField * (^LETextFieldReturnType)            (UIReturnKeyType value);
typedef UITextField * (^LETextFieldDelegate)              (id<UITextFieldDelegate> value);
@interface UITextField (LEUITextFieldFrameWorksExtra)
@property (nonatomic, readonly)LETextFieldPlaceHolder     lePlaceHolder;
@property (nonatomic, readonly)LETextFieldFont            leFont;
@property (nonatomic, readonly)LETextFieldColor           leColor;
@property (nonatomic, readonly)LETextFieldAlignment       leAlignment;
@property (nonatomic, readonly)LETextFieldReturnType      leReturnType;
@property (nonatomic, readonly)LETextFieldDelegate        leDelegate;
-(void) lePlaceHolder:(NSString *) text;
-(void) leFont:(UIFont *) font;
-(void) leColor:(UIColor *) color;
-(void) leAlignment:(NSTextAlignment) alignment;
-(void) leReturnType:(UIReturnKeyType) returnType;
-(void) leDelegate:(id<UITextFieldDelegate>) delegate;
-(void) leTextFieldLayout;
@end

#pragma mark UIImageView
typedef UIImageView * (^LEImage)                (UIImage *value);
typedef UIImageView * (^LEImageWithinFrame)     (UIImage *value);
@interface UIImageView (LEUIUIImageViewFrameWorksExtra)
@property (nonatomic, readonly)LEImage                  leImage;
@property (nonatomic, readonly)LEImageWithinFrame       leImageWithinFrame;
-(void) leImage:(UIImage *) image;
-(void) leImageWithinFrame:(UIImage *) image;
@end



