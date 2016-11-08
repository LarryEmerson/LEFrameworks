//
//  LEUIFrameworkExtra.m
//  Pods
//
//  Created by emerson larry on 16/7/25.
//
//

#import "LEUIFrameworkExtra.h"
#pragma mark UIView
@implementation UIView (LEUIViewFrameWorksExtra)
#pragma mark button
-(void) initAutoLayoutButtonSettingsUIBUWith:(UIButton *) button{
    if(button.leAutoLayoutButtonSettings==nil){
        button.leAutoLayoutButtonSettings=[[LEAutoLayoutUIButtonSettings alloc] init];
        button.leAutoLayoutButtonSettings.leTitleFont=LEFont(LELayoutFontSize10);
        button.leAutoLayoutButtonSettings.leColorNormal=LEColorWhite;
        button.leAutoLayoutButtonSettings.leColorSelected=LEColorGray;
    }
}
-(LEImage)leImage {
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leImage:value];
        return weakSelf;
    };
}
-(void) leImage:(UIImage *) image{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leImage=image;
    }else if([self isKindOfClass:[UIImageView class]]){
        UIImageView *view=(UIImageView *)self;
        [view leSetImage:image];
    }
}
-(LEImageHighlighted)leImageHighlighted {
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leImageHighlighted:value];
        return weakSelf;
    };
}
-(void) leImageHighlighted:(UIImage *) image{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leImageHighlighted=image;
    }
}
-(LEBackgroundImage)leBackgroundImage {
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leBackgroundImage:value];
        return weakSelf;
    };
}
-(void) leBackgroundImage:(UIImage *) image{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leBackgroundImage=image;
    }
}
-(LEBackgroundImageHighlighted)leBackgroundImageHighlighted {
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leBackgroundImageHighlighted:value];
        return weakSelf;
    };
}
-(void) leBackgroundImageHighlighted:(UIImage *) image{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leBackgroundImageHighlighted=image;
    }
}
-(LEHighlightedColor)leHighlightedColor {
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leHighlightedColor:value];
        return weakSelf;
    };
}
-(void) leHighlightedColor:(UIColor *) color{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leColorSelected=color;
    }
}
-(LEButtonHorizontalEdgeInsects)leButtonGap {
    __weak typeof(self) weakSelf = self;
    return ^(int value) {
        [weakSelf leButtonHorizontalEdgeInsects:value];
        return weakSelf;
    };
}
-(void) leButtonHorizontalEdgeInsects:(int) gap{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leSpace=gap;
    }
}
#pragma mark textfield
-(LEPlaceHolder)lePlaceHolder {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *value) {
        [weakSelf lePlaceHolder:value];
        return weakSelf;
    };
}
-(void) lePlaceHolder:(NSString *) placeHolder{
    if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setPlaceholder:placeHolder];
    }
}
-(LEReturnType)leReturnType {
    __weak typeof(self) weakSelf = self;
    return ^(UIReturnKeyType value) {
        [weakSelf leRetureType:value];
        return weakSelf;
    };
}
-(void) leRetureType:(UIReturnKeyType) returnType{
    if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setReturnKeyType:returnType];
    }
}
-(LEDelegateOfTextField)leDelegateOfTextField {
    __weak typeof(self) weakSelf = self;
    return ^(id<UITextFieldDelegate> value) {
        [weakSelf leDelegateOfTextField:value];
        return weakSelf;
    };
}
-(void) leDelegateOfTextField:(id<UITextFieldDelegate>) delegateOfTextField{
    if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setDelegate:delegateOfTextField];
    }
}
#pragma mark label
-(void) initAutoLayoutLabelSettingsWith:(UILabel *) label{
    if(label.leAutoLayoutLabelSettings==nil){
        label.leAutoLayoutLabelSettings=[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:LELayoutFontSize12 Font:nil Width:0 Height:0 Color:LEColorTextBlack Line:0 Alignment:NSTextAlignmentLeft];
    }
}
-(LEText)leText {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *value) {
        [weakSelf leText:value];
        return weakSelf;
    };
}
-(void) leText:(NSString *) text{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leText=text;
    }else if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leTitle=text;
    }else if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setText:text];
    }
}
-(LEFont)leFont {
    __weak typeof(self) weakSelf = self;
    return ^(UIFont *value) {
        [weakSelf leFont:value];
        return weakSelf;
    };
}
-(void) leFont:(UIFont *) font{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leFont=font;
    }else if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leTitleFont=font;
    }else if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setFont:font];
    }
}
-(LEMaxWidth)leWidth {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf leWidth:value];
        return weakSelf;
    };
}
-(void) leWidth:(CGFloat) width{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leWidth=width;
    }else if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leDeadSize=CGSizeMake(width, view.leAutoLayoutButtonSettings.leDeadSize.height);
    }else {
        [self initAutoLayoutSettings];
        self.leAutoLayoutSettings.leSize=CGSizeMake(width, self.leAutoLayoutSettings.leSize.height);
    }
}
-(LEMaxHeight)leHeight {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf leHeight:value];
        return weakSelf;
    };
}
-(void) leHeight:(CGFloat) height{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leHeight=height;
    }else if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leDeadSize=CGSizeMake(view.leAutoLayoutButtonSettings.leDeadSize.width,height);
    }else {
        [self initAutoLayoutSettings];
        self.leAutoLayoutSettings.leSize=CGSizeMake(self.leAutoLayoutSettings.leSize.height, height);
    }
}
-(LEColor)leColor {
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leColor:value];
        return weakSelf;
    };
}
-(void) leColor:(UIColor *) color{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leColor=color;
    }else if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leColorNormal=color;
    }else if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setTextColor:color];
    }
}
-(LELine)leLine {
    __weak typeof(self) weakSelf = self;
    return ^(int value) {
        [weakSelf leLine:value];
        return weakSelf;
    };
}
-(void) leLine:(int) line{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leLine=line;
    }
}
-(LEAlignment)leAlignment {
    __weak typeof(self) weakSelf = self;
    return ^(NSTextAlignment value) {
        [weakSelf leAlignment:value];
        return weakSelf;
    };
}
-(void) leAlignment:(NSTextAlignment) alignment{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        label.leAutoLayoutLabelSettings.leAlignment=alignment;
    }else if([self isKindOfClass:[UITextField class]]){
        UITextField *view=(UITextField *)self;
        [view setTextAlignment:alignment];
    }
}
-(LELineSpace)leLineSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf leLineSpace:value];
        return weakSelf;
    };
}
-(void) leLineSpace:(CGFloat) linespace{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *label=(UILabel *)self;
        [self initAutoLayoutLabelSettingsWith:label];
        [label leSetLineSpace:linespace];
    }
}
//
-(void) initAutoLayoutSettings{
    if(self.leAutoLayoutSettings==nil){
        self.leAutoLayoutSettings=[[LEAutoLayoutSettings alloc] init];
    }
}
- (LETypeAdapter)leTypeAdapter {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf leType];
        return weakSelf;
    };
}
-(id) leType{ 
    return self;
}
- (LEInit)leInit {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf leInitSelf];
        return weakSelf;
    };
}
-(id) leInitSelf{
    [self leExtraInits];
    return self;
}
- (LEAutoLayout)leLayout {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf leAutoLayout];
        return weakSelf;
    };
}
-(id)leAutoLayout{
    if([self isKindOfClass:[UILabel class]]){
        UILabel *view=(UILabel *)self;
        [view leLabelLayout];
    }else if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [view leButtonLayout];
    }else{
        [self leExecAutoLayout];
    }
    return self;
}
//
- (LESuperView)leSuperView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView *value) {
        [weakSelf leSuperView:value];
        return weakSelf;
    };
}
-(LERelativeView)leRelativeView{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *value) {
        [weakSelf leRelativeView:value];
        return weakSelf;
    };
}
-(LEAnchor)leAnchor{
    __weak typeof(self) weakSelf = self;
    return ^(LEAnchors value) {
        [weakSelf leAnchor:value];
        return weakSelf;
    };
}
-(LEOffset)leOffset{
    __weak typeof(self) weakSelf = self;
    return ^(CGPoint value) {
        [weakSelf leOffset:value];
        return weakSelf;
    };
}
-(LESize)leSize{
    __weak typeof(self) weakSelf = self;
    return ^(CGSize value) {
        [weakSelf leSize:value];
        return weakSelf;
    };
}
-(LEEdgeInsects)leEdgeInsects{
    __weak typeof(self) weakSelf = self;
    return ^(UIEdgeInsets value) {
        [weakSelf leEdgeInsects:value];
        return weakSelf;
    };
}
-(LEBackground)leBackground{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leBackground:value];
        return weakSelf;
    };
}
-(LEUserInteraction)leUserInteraction{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL value) {
        [weakSelf leUserInteraction:value];
        return weakSelf;
    };
}
-(LETapEvent)leTapEvent{
    __weak typeof(self) weakSelf = self;
    return ^(SEL sel, id target) {
        [weakSelf leTapEvent:sel Target:target];
        return weakSelf;
    };
}
-(LERoundCorner)leRoundCorner{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat radius) {
        [weakSelf leRoundCorner:radius];
        return weakSelf;
    };
}
-(void) leRoundCorner:(CGFloat)radius{
    [self leSetRoundCornerWithRadius:radius];
}
-(void) leSuperView:(UIView *) view{
    [self initAutoLayoutSettings];
    self.leAutoLayoutSettings.leSuperView=view;
    if(self.leAutoLayoutSettings.leRelativeView==nil){
        self.leAutoLayoutSettings.leRelativeView=view;
    }
    [view addSubview:self];
    
}
-(void) leRelativeView:(UIView *) view{
    [self initAutoLayoutSettings];
    self.leAutoLayoutSettings.leRelativeView=view;
    if(self.leAutoLayoutSettings.leSuperView==nil){
        self.leAutoLayoutSettings.leSuperView=view;
    }
    if(self.leAutoLayoutSettings.leRelativeView){
        if(!self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers){
            self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers=[[NSMutableArray alloc] init];
        }
        [self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers addObject:self];
    }
}
-(void) leAnchor:(LEAnchors) anchor{
    [self initAutoLayoutSettings];
    self.leAutoLayoutSettings.leAnchor=anchor;
}
-(void) leOffset:(CGPoint) offset{
    [self initAutoLayoutSettings];
    self.leAutoLayoutSettings.leOffset=offset;
}
-(void) leSize:(CGSize) size{
    [self initAutoLayoutSettings];
    self.leAutoLayoutSettings.leSize=size;
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leDeadSize=size;
    }
}
-(void) leEdgeInsects:(UIEdgeInsets) edgeInsects{
    [self initAutoLayoutSettings];
    self.leAutoLayoutSettings.leEdgeInsets=edgeInsects;
    if(self.leAutoLayoutSettings.leSuperView&&self.leAutoLayoutSettings.leRelativeView){
        CGSize relativeSize=self.leAutoLayoutSettings.leSuperView.frame.size;
        edgeInsects.left=-fabs(edgeInsects.left);
        edgeInsects.right=-fabs(edgeInsects.right);
        edgeInsects.top=-fabs(edgeInsects.top);
        edgeInsects.bottom=-fabs(edgeInsects.bottom);
        self.leAutoLayoutSettings.leOffset=CGPointMake(-edgeInsects.left, -edgeInsects.top);
        self.leAutoLayoutSettings.leSize=CGSizeMake(relativeSize.width+edgeInsects.left+edgeInsects.right, relativeSize.height+edgeInsects.top+edgeInsects.bottom);
        if([self isKindOfClass:[UIButton class]]){
            UIButton *button=(UIButton *)self;
            [self initAutoLayoutButtonSettingsUIBUWith:button];
            button.leAutoLayoutButtonSettings.leDeadSize=self.leAutoLayoutSettings.leSize;
        }
        self.leAutoLayoutSettings.leRelativeChangeView=self.leAutoLayoutSettings.leSuperView;
        self.leAutoLayoutSettings.leEdgeInsets=edgeInsects;
        //
        if(!self.leAutoLayoutSettings.leRelativeChangeView.leAutoResizeObservers){
            self.leAutoLayoutSettings.leRelativeChangeView.leAutoResizeObservers=[[NSMutableArray alloc] init];
        } 
    }
    
}
-(void) leBackground:(UIColor *)color{
    [self setBackgroundColor:color];
}
-(void) leUserInteraction:(BOOL)enable{
    [self setUserInteractionEnabled:enable];
}
-(void) leTapEvent:(SEL)sel Target:(id)target{
    if([self isKindOfClass:[UIButton class]]){
        UIButton *view=(UIButton *)self;
        [self initAutoLayoutButtonSettingsUIBUWith:view];
        view.leAutoLayoutButtonSettings.leTarget=target;
        view.leAutoLayoutButtonSettings.leSEL=sel;
    }else{
        [self leAddTapEventWithSEL:sel Target:target];
    }
}
@end

#pragma mark UILabel
@implementation UILabel (LEUILabelFrameWorksExtra)
-(void) initAutoLayoutLabelSettings{
    if(self.leAutoLayoutLabelSettings==nil){
        self.leAutoLayoutLabelSettings=[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:LELayoutFontSize12 Font:nil Width:0 Height:0 Color:LEColorTextBlack Line:0 Alignment:NSTextAlignmentLeft];
    }
} 
-(void)leLabelLayout{
    if(!self.leAutoLayoutLabelSettings.leText||self.leAutoLayoutLabelSettings.leText.length==0){//解决未执行letext时，label不显示的问题
        self.leText(@"");
    }
    int width=self.leAutoLayoutLabelSettings.leWidth;
    int height=self.leAutoLayoutLabelSettings.leHeight;
    if(width<=0/*||width>LESCREEN_WIDTH*/){
        width=LESCREEN_WIDTH;
    }
    self.leAutoLayoutLabelSettings.leWidth=width;
    if(height==0){
        height=LELabelMaxSize.height;
    }
    CGSize size=CGSizeZero;
    if(self.leAutoLayoutLabelSettings.leText){
        if(self.leAutoLayoutLabelSettings.leLine==0){
            size=[self.leAutoLayoutLabelSettings.leText leGetSizeWithFont:self.leAutoLayoutLabelSettings.leFont MaxSize:CGSizeMake(width, height)];
        }else if(self.leAutoLayoutLabelSettings.leLine>=1){
            size=[self.leAutoLayoutLabelSettings.leText leGetSizeWithFont:self.leAutoLayoutLabelSettings.leFont MaxSize:CGSizeMake(width, height)];
            if(self.leAutoLayoutLabelSettings.leLine==1&&self.leAutoLayoutLabelSettings.leHeight==0){
                size.height=self.font.lineHeight;
            }else{
                size.height=self.font.lineHeight*self.leAutoLayoutLabelSettings.leLine;
            }
            if(self.leAutoLayoutLabelSettings.leHeight!=0){
                size.height=self.leAutoLayoutLabelSettings.leHeight;
            }
        }
    }else{
        size=CGSizeMake(self.leAutoLayoutLabelSettings.leWidth, self.leAutoLayoutLabelSettings.leHeight);
    }
    self.leAutoLayoutSettings.leSize=size;
    
    UILabel *label=self;
    [label setTextAlignment:self.leAutoLayoutLabelSettings.leAlignment];
    [label setTextColor:self.leAutoLayoutLabelSettings.leColor];
    [label setFont:self.leAutoLayoutLabelSettings.leFont];
    [label setNumberOfLines:self.leAutoLayoutLabelSettings.leLine];
    #ifdef __IPHONE_7_0
    #else
    [label setBackgroundColor:LEColorClear];
    #endif
    [label setText:self.leAutoLayoutLabelSettings.leText];
    [self leExecAutoLayout]; 
}
//
-(LELabelText)leText{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *text) {
        [weakSelf leText:text];
        return weakSelf;
    };
}
-(LELabelFont)leFont{
    __weak typeof(self) weakSelf = self;
    return ^(UIFont *value) {
        [weakSelf leFont:value];
        return weakSelf;
    };
}
-(LELabelWidth)leWidth{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf leWidth:value];
        return weakSelf;
    };
}
-(LELabelHeight)leHeight{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf leHeight:value];
        return weakSelf;
    };
}
-(LELabelColor)leColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leColor:value];
        return weakSelf;
    };
}
-(LELabelLine)leLine{
    __weak typeof(self) weakSelf = self;
    return ^(int value) {
        [weakSelf leLine:value];
        if(value==1){
            [weakSelf leHeight:weakSelf.font.lineHeight];
        }
        return weakSelf;
    };
}
-(LELabelAlignment)leAlignment{
    __weak typeof(self) weakSelf = self;
    return ^(NSTextAlignment value) {
        [weakSelf leAlignment:value];
        return weakSelf;
    };
}
-(LELabelLineSpace)leLineSpace{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf leLineSpace:value];
        return weakSelf;
    };
}
-(void) leLineSpace:(CGFloat)space{
    [self leSetLineSpace:space];
}
-(void) leText:(NSString *) text{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leText=text;
    [self setText:text];
}
-(void) leFont:(UIFont *) font{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leFont=font;
    [self setFont:font];
}
-(void) leWidth:(CGFloat) width{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leWidth=width;
}
-(void) leHeight:(CGFloat) height{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leHeight=height;
}
-(void) leColor:(UIColor *) color{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leColor=color;
    [self setTextColor:color];
}
-(void) leLine:(int) line{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leLine=line;
    [self setNumberOfLines:line];
}
-(void) leAlignment:(NSTextAlignment) alignment{
    [self initAutoLayoutLabelSettings];
    self.leAutoLayoutLabelSettings.leAlignment=alignment;
    [self setTextAlignment:alignment];
}
@end
#pragma mark UIButton
@implementation UIButton (LEUIButtonFrameWorksExtra)
-(void) initAutoLayoutButtonSettings{
    if(self.leAutoLayoutButtonSettings==nil){
        self.leAutoLayoutButtonSettings=[[LEAutoLayoutUIButtonSettings alloc] init];
        self.leAutoLayoutButtonSettings.leTitleFont=LEFont(LELayoutFontSize10);
        self.leAutoLayoutButtonSettings.leColorNormal=LEColorWhite;
        self.leAutoLayoutButtonSettings.leColorSelected=LEColorGray;
    }
}
-(LEButtonDeadSize) leButtonSize{
    __weak typeof(self) weakSelf = self;
    return ^(CGSize value) {
        [weakSelf leButtonSize:value];
        return weakSelf;
    };
}
-(LEButtonText) leText{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *value) {
        [weakSelf leText:value];
        return weakSelf;
    };
}
-(LEButtonFont) leFont{
    __weak typeof(self) weakSelf = self;
    return ^(UIFont *value) {
        [weakSelf leFont:value];
        return weakSelf;
    };
}
-(LEButtonImage) leImage{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leImage:value];
        return weakSelf;
    };
}
-(LEButtonBackground) leBackgroundImage{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leBackgroundImage:value];
        return weakSelf;
    };
}
-(LEButtonImageHighlighted) leImageHighlighted{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leImageHighlighted:value];
        return weakSelf;
    };
}
-(LEButtonBackgroundHighlighted) leBackgroundImageHighlighted{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leBackgroundImageHighlighted:value];
        return weakSelf;
    };
}


-(LEButtonNormalColor) leNormalColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leNormalColor:value];
        return weakSelf;
    };
}
-(LEButtonHighlightedColor) leHighlightedColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leHighlighted:value];
        return weakSelf;
    };
}
-(LEButtonMaxWidth) leMaxWidth{
    __weak typeof(self) weakSelf = self;
    return ^(int value) {
        [weakSelf leMaxWidth:value];
        return weakSelf;
    };
}
-(LEButtonTapEvent) leTapEvent{
    __weak typeof(self) weakSelf = self;
    return ^(SEL sel, id target) {
        [weakSelf leTapEvent:sel Target:target];
        return weakSelf;
    };
}
-(LEButtonGap) leGap{
    __weak typeof(self) weakSelf = self;
    return ^(int value) {
        [weakSelf leGap:value];
        return weakSelf;
    };
}
-(void) leButtonSize:(CGSize) size{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leDeadSize=size;
}
-(void) leText:(NSString *) text{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leTitle=text;
}
-(void) leFont:(UIFont *) font{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leTitleFont=font;
}
-(void) leImage:(UIImage *) image{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leImage=image;
}
-(void) leBackgroundImage:(UIImage *)image{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leBackgroundImage=image;
}
-(void) leImageHighlighted:(UIImage *) image{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leImageHighlighted=image;
}
-(void) leBackgroundImageHighlighted:(UIImage *)image{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leBackgroundImageHighlighted=image;
}

-(void) leNormalColor:(UIColor *) color{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leColorNormal=color;
}
-(void) leHighlighted:(UIColor *) color{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leColorSelected=color;
}
-(void) leMaxWidth:(int) width{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leMaxWidth=width;
}
-(void) leTapEvent:(SEL) sel Target:(id) target{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leSEL=sel;
    self.leAutoLayoutButtonSettings.leTarget=target;
}
-(void) leGap:(int) gap{
    [self initAutoLayoutButtonSettings];
    self.leAutoLayoutButtonSettings.leSpace=gap;
}
-(void) leButtonLayout{
    UIButton *button=self;
    [button.titleLabel setFont:self.leAutoLayoutButtonSettings.leTitleFont];
    [button setTitle:self.leAutoLayoutButtonSettings.leTitle forState:UIControlStateNormal];
    [button setTitleColor:self.leAutoLayoutButtonSettings.leColorNormal forState:UIControlStateNormal];
    [button setTitleColor:self.leAutoLayoutButtonSettings.leColorSelected forState:UIControlStateHighlighted];
    [button setImage:self.leAutoLayoutButtonSettings.leImage forState:UIControlStateNormal];
    [button setBackgroundImage:self.leAutoLayoutButtonSettings.leBackgroundImage forState:UIControlStateNormal];
    [button setImage:self.leAutoLayoutButtonSettings.leImageHighlighted forState:UIControlStateHighlighted];
    [button setBackgroundImage:self.leAutoLayoutButtonSettings.leBackgroundImageHighlighted forState:UIControlStateHighlighted];
    [button addTarget:self.leAutoLayoutButtonSettings.leTarget action:self.leAutoLayoutButtonSettings.leSEL forControlEvents:UIControlEventTouchUpInside];
    UIImage *img=self.leAutoLayoutButtonSettings.leImage;
    //
    int space=self.leAutoLayoutButtonSettings.leSpace;
    if(space==0){
        space=LEDefaultButtonHorizontalSpace;
    } 
    CGSize finalSize=self.leAutoLayoutButtonSettings.leDeadSize;
    if(finalSize.width==0||finalSize.height==0){
        CGSize textSize=[self.leAutoLayoutButtonSettings.leTitle leGetSizeWithFont:self.leAutoLayoutButtonSettings.leTitleFont MaxSize:LELabelMaxSize];
        finalSize.width = textSize.width+space*2+(img?img.size.width:0);
        finalSize.height=MAX(textSize.height, img?img.size.height:0)+LEDefaultButtonVerticalSpace*2;
        if(self.leAutoLayoutButtonSettings.leMaxWidth>0||self.leAutoLayoutButtonSettings.leDeadSize.width>0){
            finalSize.width=MIN(self.leAutoLayoutButtonSettings.leMaxWidth, finalSize.width);
            finalSize.width=MIN(self.leAutoLayoutButtonSettings.leDeadSize.width, finalSize.width);
        }
        if(self.leAutoLayoutButtonSettings.leDeadSize.height>0){
            finalSize.height=MIN(self.leAutoLayoutButtonSettings.leDeadSize.height, finalSize.height);
        }
    }
    self.leAutoLayoutSettings.leSize=finalSize;
    [button leExecAutoLayout];
}
-(void) leSetForTapEventWithSel:(SEL) sel Target:(id) target{
    self.leAutoLayoutButtonSettings.leSEL=sel;
    self.leAutoLayoutButtonSettings.leTarget=target;
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundImage:[LEColorMask2 leImageStrechedFromSizeOne] forState:UIControlStateHighlighted];
    [self leExecAutoLayout];
}
@end
#pragma mark UITextField
@implementation UITextField (LEUITextFieldFrameWorksExtra)

-(LETextFieldPlaceHolder)lePlaceHolder{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *value) {
        [weakSelf lePlaceHolder:value];
        return weakSelf;
    };
}
-(LETextFieldFont)leFont{
    __weak typeof(self) weakSelf = self;
    return ^(UIFont *value) {
        [weakSelf leFont:value];
        return weakSelf;
    };
}
-(LETextFieldColor)leColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *value) {
        [weakSelf leColor:value];
        return weakSelf;
    };
}
-(LETextFieldAlignment)leAlignment{
    __weak typeof(self) weakSelf = self;
    return ^(NSTextAlignment value) {
        [weakSelf leAlignment:value];
        return weakSelf;
    };
}
-(LETextFieldReturnType)leReturnType{
    __weak typeof(self) weakSelf = self;
    return ^(UIReturnKeyType value) {
        [weakSelf leReturnType:value];
        return weakSelf;
    };
}
-(LETextFieldDelegate)leDelegate{
    __weak typeof(self) weakSelf = self;
    return ^(id<UITextFieldDelegate> value) {
        [weakSelf leDelegate:value];
        return weakSelf;
    };
}
-(void) lePlaceHolder:(NSString *) text{
    [self setPlaceholder:text];
}
-(void) leFont:(UIFont *) font{
    [self setFont:font];
}
-(void) leColor:(UIColor *) color{
    [self setTextColor:color];
}
-(void) leAlignment:(NSTextAlignment) alignment{
    [self setTextAlignment:alignment];
}
-(void) leReturnType:(UIReturnKeyType) returnType{
    [self setReturnKeyType:returnType];
}
-(void) leDelegate:(id<UITextFieldDelegate>) delegate{
    [self setDelegate:delegate];
}
-(void) leTextFieldLayout{
    [self leExecAutoLayout];
}
@end
#pragma mark UIImageView
@implementation UIImageView (LEUIUIImageViewFrameWorksExtra)
-(LEImageWithImageSize)leImage{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leImage:value];
        return weakSelf;
    };
}
-(void) leImage:(UIImage *) image{
    [self leSetImage:image];
}
-(LEImageWithinFrame)leImageWithinFrame{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *value) {
        [weakSelf leImageWithinFrame:value];
        return weakSelf;
    };
}
-(void) leImageWithinFrame:(UIImage *) image{
    [self leSetImage:image WithSize:self.bounds.size];
}
@end




