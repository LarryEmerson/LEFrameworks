//
//  LEUIFramework.m
//  LEUIFramework
//
//  Created by Larry Emerson on 15/2/19.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEUIFramework.h"

@implementation UIViewController (LEExtension)
-(void) leSetLeftBarButtonWithImage:(UIImage *)img SEL:(SEL)sel{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:sel] animated:YES];
}
-(void) leSetRightBarButtonWithImage:(UIImage *)img SEL:(SEL)sel{
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:sel] animated:YES];
}
-(void) leSetLeftBarButtonAsBackWith:(UIImage *) back{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:back style:UIBarButtonItemStylePlain target:self action:@selector(onVCBack)] animated:YES];
}
-(void) leSetNavigationTitle:(NSString *) title{
    [self.navigationItem setTitle:title];
}
-(void) leThroughNavigationAnimatedPush:(UIViewController *) vc{
    [self.navigationController pushViewController:vc animated:YES];
}
-(void) lePopSelfAnimated{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) onVCBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
@implementation NSObject (LEExtension)
-(NSString *) leStringValue{
    return [NSString stringWithFormat:@"%@",self];
}
-(void) leExtraInits{}
-(void) leRelease{}
@end

@implementation UIView (LEExtension) 
-(UIView *) getSuperView:(UIView *) view{
    return view.superview?[self getSuperView:view.superview]:view;
}
-(void) leAddLocalNotification:(NSString *) notification{
    if(notification&&notification.length>0){
        [LELocalNotification showText:notification WithEnterTime:0.3 AndPauseTime:0.8 ReleaseWhenFinished:YES]; 
    }
}
//
-(void) leEndEdit{
    [self endEditing:YES];
}
-(void) leAddTapEventWithSEL:(SEL) sel{ 
    [self leAddTapEventWithSEL:sel Target:self ];
}
-(void) leSetRoundCornerWithRadius:(CGFloat) radius{
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
}
-(void) leAddTapEventWithSEL:(SEL)sel Target:(id) target{
    if([target respondsToSelector:@selector(setUserInteractionEnabled:)]){
        [target setUserInteractionEnabled:YES];
    }
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:sel]];
}
-(UIImageView *) leAddTopSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width{
    UIImageView *img=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:offset CGSize:CGSizeMake(width, 0.5)] Image:[color leImageStrechedFromSizeOne]];
    return img;
}
-(UIImageView *) leAddBottomSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width{
    UIImageView *img= [LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:offset CGSize:CGSizeMake(width, 0.5)] Image:[color leImageStrechedFromSizeOne]];
    return img;
}
-(UIImageView *) leAddLeftSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Height:(int) height{
    UIImageView *img=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:offset CGSize:CGSizeMake(0.5, height)] Image:[color leImageStrechedFromSizeOne]];
    return img;
}
-(UIImageView *) leAddRightSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Height:(int) height{
    UIImageView *img= [LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideRightCenter Offset:offset CGSize:CGSizeMake(0.5, height)] Image:[color leImageStrechedFromSizeOne]];
    return img;
}
-(void) leReleaseView{}
@end

@implementation UITableView (LEExtension)
-(BOOL) touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}
@end

@implementation UIImage (LEExtension)
-(UIImage *)leMiddleStrechedImage{
    return [self stretchableImageWithLeftCapWidth:self.size.width/2 topCapHeight:self.size.height/2];
}
@end

@implementation UIColor (LEExtension)
-(UIImage *)leImageStrechedFromSizeOne{
    UIImage *img=[self leImageWithSize:CGSizeMake(1, 1)];
    UIImage *streched= [img leMiddleStrechedImage];
    img=nil;
    return streched;
}
-(UIImage *)leImageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation NSString (LEExtension)
-(int) leAsciiLength{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return (int)[da length];
}
-(NSString *) leGetTrimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
} 
-(NSObject *) leGetInstanceFromClassName{
    NSObject *obj=[NSClassFromString(self) alloc];
    NSAssert(obj!=nil,([NSString stringWithFormat:@"请检查类名是否正确：%@",self]));
    return obj;
}
-(CGSize) leGetSizeWithFont:(UIFont *)font MaxSize:(CGSize) size{
    return [self leGetSizeWithFont:font MaxSize:size ParagraphStyle:nil];
}
-(CGSize) leGetSizeWithFont:(UIFont *)font MaxSize:(CGSize) size ParagraphStyle:(NSMutableParagraphStyle *) style{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setObject:font forKey:NSFontAttributeName];
    if(style){
        [dic setObject:style forKey:NSParagraphStyleAttributeName];
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic  context:nil];
    rect.size.height=(int)rect.size.height+1;
    return rect.size;
}
-(CGSize) leGetSizeWithFont:(UIFont *)font MaxSize:(CGSize) size LineSpcae:(int) linespace Alignment:(NSTextAlignment) alignment{
    if(!self){
        return CGSizeZero;
    }
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setObject:font forKey:NSFontAttributeName];
    if(linespace>0){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:linespace];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        [paragraphStyle setAlignment:alignment];
        [dic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    rect.size.height=(int)rect.size.height+1;
    return rect.size;
}
@end

@implementation UILabel (LEExtension)
static void * LEAutoLayoutLabelSettingsKey = (void *) @"LEAutoLayoutLabelSettings";
- (LEAutoLayoutLabelSettings *) leAutoLayoutLabelSettings {
    return objc_getAssociatedObject(self, LEAutoLayoutLabelSettingsKey);
}
- (void) setLeAutoLayoutLabelSettings:(LEAutoLayoutLabelSettings *)leAutoLayoutLabelSettings{
    objc_setAssociatedObject(self, LEAutoLayoutLabelSettingsKey, leAutoLayoutLabelSettings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) leSetText:(NSString *) text{
    if(self.leAutoLayoutLabelSettings){
        int width=self.leAutoLayoutLabelSettings.leWidth;
        int height=self.leAutoLayoutLabelSettings.leHeight;
        if(width<=0/*||width>LESCREEN_WIDTH*/){
            width=LESCREEN_WIDTH;
        }
        CGSize size=CGSizeZero;
        if(text){
            if(self.leAutoLayoutLabelSettings.leLine==0){
                size=[text leGetSizeWithFont:self.font MaxSize:CGSizeMake(width, height)];
            }else if(self.leAutoLayoutLabelSettings.leLine>=1){
                size=[text leGetSizeWithFont:self.font MaxSize:CGSizeMake(width, height)];
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
        [self leSetSize:size];
    }
    [self setText:text];
}
-(CGSize) leGetLabelTextSize{
    return [self.text leGetSizeWithFont:self.font MaxSize:LELabelMaxSize];
}
-(CGSize) leGetLabelTextSizeWithMaxWidth:(int) width{
    return [self.text leGetSizeWithFont:self.font MaxSize:CGSizeMake(width, LELabelMaxSize.height)];
}
-(void) leSetLineSpace:(float) space{
    [self leSetLinespace:space Color:nil Range:NSMakeRange(0, 0)];
}
-(void) leSetLinespace:(float) space Color:(UIColor *) color Range:(NSRange) range{
    if(self.text){ 
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle=nil;
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        [dic setObject:self.font forKey:NSFontAttributeName];
        if(space>0){
            paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:space];
            [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
            [paragraphStyle setAlignment:self.textAlignment];
            [dic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
        }
        [attributedString addAttributes:dic range:NSMakeRange(0, self.text.length)];
        if(color){
            [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        [self setAttributedText:attributedString];
        //
        int width=self.leAutoLayoutLabelSettings.leWidth;
        if(width==0||width>LESCREEN_WIDTH){
            width=LESCREEN_WIDTH;
        }
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, LELabelMaxSize.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        [self leSetSize:CGSizeMake(rect.size.width, rect.size.height)];
        [self leRedrawAttributedStringWithRect:rect LineSpace:space];
    }
}
-(void) leRedrawAttributedStringWithRect:(CGRect) rect LineSpace:(int) lineSpace{
    if(self.attributedText){
        __block BOOL hasColor=NO;
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.text.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
         ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
             if([attributes objectForKey:NSForegroundColorAttributeName]&&!NSEqualRanges(range, NSMakeRange(0, self.text.length))){
                 hasColor=YES;
             }
         }];
        if(hasColor &&rect.size.height<=self.font.lineHeight+lineSpace){
            NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
            [attr addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithInt: -lineSpace/2+1] range:NSMakeRange(0, self.text.length)];
            [self setAttributedText:attr];
            if(self.leAutoLayoutSettings){
                [self leSetSize:CGSizeMake(rect.size.width, self.font.lineHeight)];
            }else{
                [self setFrame:CGRectMake(0, 0, rect.size.width, self.font.lineHeight)];
            } 
        } else if(rect.size.height==self.font.lineHeight+lineSpace){
            [self setAttributedText:[[NSAttributedString alloc] initWithString:self.text]];
            if(self.leAutoLayoutSettings){
                [self leSetSize:CGSizeMake(rect.size.width, self.font.lineHeight)];
            }else{
                [self setFrame:CGRectMake(0, 0, rect.size.width, self.font.lineHeight)];
            }
        }else if(self.numberOfLines!=0){
            int height=(self.numberOfLines>1?self.numberOfLines-1:0)*lineSpace+self.numberOfLines*self.font.lineHeight;
            height=(self.numberOfLines>1?self.numberOfLines-1:0)*lineSpace+self.numberOfLines*self.font.lineHeight;
            if(self.bounds.size.height>height){
                if(self.leAutoLayoutSettings){
                    [self leSetSize:CGSizeMake(rect.size.width, (self.numberOfLines>1?self.numberOfLines-1:0)*lineSpace+self.numberOfLines*self.font.lineHeight)];
                }else{
                    [self setFrame:CGRectMake(0, 0, rect.size.width, (self.numberOfLines>1?self.numberOfLines-1:0)*lineSpace+self.numberOfLines*self.font.lineHeight)];
                }
                [self setLineBreakMode:NSLineBreakByTruncatingTail];
            }
        }
    }
}
//=======================Copy

static void * UILabelSupportCopyKey = (void *) @"UILabelSupportCopyKey";
- (NSNumber *) leIsSupportCopy {
    return objc_getAssociatedObject(self, UILabelSupportCopyKey);
}
- (void) setLeIsSupportCopy:(NSNumber *)leIsSupportCopy{
    objc_setAssociatedObject(self, UILabelSupportCopyKey, leIsSupportCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)canBecomeFirstResponder{
    if([self.leIsSupportCopy boolValue]){
        return YES;
    }
    return [super canBecomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    if([self.leIsSupportCopy boolValue]){
        [self setBackgroundColor:LEColorClear];
        return YES;
    }else{
        return [super resignFirstResponder];
    }
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(leCopy:));
}
-(void) leHandleLongPress:(UILongPressGestureRecognizer *) recognizer{
    [self setBackgroundColor:LEColorMask2];
    [self becomeFirstResponder];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
-(void)leCopy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string =self.text;
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    [self setBackgroundColor:LEColorClear];
    [self resignFirstResponder];
}
-(void) leAddLongPressGestureWithSel:(SEL) sel Target:(id) target{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:target action:sel];
    [self addGestureRecognizer:longPress];
    [self setUserInteractionEnabled:YES];
}

-(void) leAddCopyGesture{
    self.leIsSupportCopy=[NSNumber numberWithBool:YES];
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leHandleLongPress:)];
    [self addGestureRecognizer:longPress];
    [self setUserInteractionEnabled:YES];
}
@end

@implementation UIImageView (LEExtension)
-(void) leSetImage:(UIImage *) image{
    if(self.leAutoLayoutSettings){
        self.leAutoLayoutSettings.leSize=image.size;
        [self leSetSize:image.size];
    }
    [self setImage:image];
}
-(void) leSetImage:(UIImage *) image WithSize:(CGSize) size{
    if(self.leAutoLayoutSettings){
        self.leAutoLayoutSettings.leSize=size;
        [self leSetSize:size];
    }
    [self setImage:image];
}
@end

@implementation UIButton (LEExtension)
static void * LEAutoLayoutButtonSettingsKey = (void *) @"LEAutoLayoutButtonSettings";
- (LEAutoLayoutUIButtonSettings *) leAutoLayoutButtonSettings {
    return objc_getAssociatedObject(self, LEAutoLayoutButtonSettingsKey);
}
- (void) setLeAutoLayoutButtonSettings:(LEAutoLayoutUIButtonSettings *)leAutoLayoutButtonSettings{
    objc_setAssociatedObject(self, LEAutoLayoutButtonSettingsKey, leAutoLayoutButtonSettings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void) leSetText:(NSString *) text{
    [self setTitle:text forState:UIControlStateNormal];
    //
    CGSize finalSize=self.leAutoLayoutSettings.leSize;
    while (YES) {
        CGSize textSize=[self.titleLabel leGetLabelTextSize];
        if(textSize.width+self.leAutoLayoutButtonSettings.leSpace*2>finalSize.width){
            finalSize.width = textSize.width+self.leAutoLayoutButtonSettings.leSpace*2;
        }
        if(textSize.height+LEDefaultButtonVerticalSpace*2>finalSize.height){
            finalSize.height = textSize.height+LEDefaultButtonVerticalSpace*2;
        }
        if(self.leAutoLayoutButtonSettings.leMaxWidth>0 && finalSize.width>self.leAutoLayoutButtonSettings.leMaxWidth){
            finalSize.width=self.leAutoLayoutButtonSettings.leMaxWidth;
            self.titleLabel.font=[self.titleLabel.font fontWithSize:self.titleLabel.font.pointSize-0.2];
        }else{
            break;
        }
    }
    self.leAutoLayoutSettings.leSize=finalSize;
    [self leExecAutoLayout];
}
-(void) leVerticallyLayoutButton{
    UIButton *button=self;
    button.imageView.backgroundColor=[UIColor clearColor];
    [button.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height/2+titleSize.height , -imageSize.width, 0, 0);
    titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height-titleSize.height/2, 0, 0, -titleSize.width);
    [button.titleLabel setBackgroundColor:[UIColor clearColor]];
}
@end

@implementation LEAutoLayoutSettings
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size {
    return [self initWithSuperView:superView Anchor:anchor RelativeView:superView Offset:offset CGSize:size];
}
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size {
    self=[super init];
    self.leSuperView=superView;
    self.leAnchor=anchor;
    self.leRelativeView=relativeView;
    self.leSize=size;
    self.leOffset=offset;
    
    return self;
}

-(id) initWithSuperView:(UIView *)superView EdgeInsects:(UIEdgeInsets) edge{
    CGSize relativeSize=superView.frame.size;
    edge.left=-fabs(edge.left);
    edge.right=-fabs(edge.right);
    edge.top=-fabs(edge.top);
    edge.bottom=-fabs(edge.bottom);
    self=[self initWithSuperView:superView Anchor:LEAnchorInsideTopLeft Offset:CGPointMake(-edge.left, -edge.top) CGSize:CGSizeMake(relativeSize.width+edge.left+edge.right, relativeSize.height+edge.top+edge.bottom)];
    [self leSetRelativeChangeView:superView EdgeInsects:edge];
    return self;
}

-(void) leSetRelativeChangeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge{
    self.leRelativeChangeView=changeView;
    self.leEdgeInsets=edge;
    //
    if(!changeView.leAutoResizeObservers){
        changeView.leAutoResizeObservers=[[NSMutableArray alloc] init];
    }
}

@end

static void * LEAutoLayoutSettingsKey = (void *) @"LEAutoLayoutSettings";
static void * LEAutoLayoutObserversKey = (void *) @"LEAutoLayoutObservers";
static void * LEAutoResizeObserversKey = (void *) @"LEAutoResizeObservers";


@implementation UIView (LEUIViewFrameWorks)
+ (CGRect) leGetFrameWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings{
    LEAnchors anchor=settings.leAnchor;
    UIView *relativeView=settings.leRelativeView;
    CGPoint offset=settings.leOffset;
    CGSize size=settings.leSize;
    //
    CGRect frame;
    if((int)anchor>=9){
        frame=relativeView.frame;
        frame.origin.x+=offset.x;
        frame.origin.y+=offset.y;
        frame.size=size;
    }else{
        frame=CGRectMake(offset.x, offset.y, size.width, size.height);
    }
    CGRect relativeFrame=relativeView.frame;
    switch (anchor) {
            //Inside
        case LEAnchorInsideTopLeft:
            break;
        case LEAnchorInsideTopCenter:
            frame.origin.x+=relativeFrame.size.width/2-size.width/2;
            break;
        case LEAnchorInsideTopRight:
            frame.origin.x+=relativeFrame.size.width-size.width;
            break;
            //
        case LEAnchorInsideLeftCenter:
            frame.origin.y+=relativeFrame.size.height/2-size.height/2;
            break;
        case LEAnchorInsideCenter:
            frame.origin.x+=relativeFrame.size.width/2-size.width/2;
            frame.origin.y+=relativeFrame.size.height/2-size.height/2;
            break;
        case LEAnchorInsideRightCenter:
            frame.origin.x+=relativeFrame.size.width-size.width;
            frame.origin.y+=relativeFrame.size.height/2-size.height/2;
            break;
            //
        case LEAnchorInsideBottomLeft:
            frame.origin.y+=relativeFrame.size.height-size.height;
            break;
        case LEAnchorInsideBottomCenter:
            frame.origin.x+=relativeFrame.size.width/2-size.width/2;
            frame.origin.y+=relativeFrame.size.height-size.height;
            break;
        case LEAnchorInsideBottomRight:
            frame.origin.x+=relativeFrame.size.width-size.width;
            frame.origin.y+=relativeFrame.size.height-size.height;
            break;
            //OutSide
        case LEAnchorOutside1:
            frame.origin.x+=-size.width;
            frame.origin.y+=-size.height;
            break;
        case LEAnchorOutside2:
            frame.origin.x+=relativeFrame.size.width;
            frame.origin.y+=-size.height;
            break;
        case LEAnchorOutside3:
            frame.origin.x+=-size.width;
            frame.origin.y+=relativeFrame.size.height;
            break;
        case LEAnchorOutside4:
            frame.origin.x+=relativeFrame.size.width;
            frame.origin.y+=relativeFrame.size.height;
            break;
            //
        case LEAnchorOutsideTopLeft:
            frame.origin.y+=-size.height;
            break;
        case LEAnchorOutsideTopCenter:
            frame.origin.x+=relativeFrame.size.width/2-size.width/2;
            frame.origin.y+=-size.height;
            break;
        case LEAnchorOutsideTopRight:
            frame.origin.x+=relativeFrame.size.width-size.width;
            frame.origin.y+=-size.height;
            break;
            //
        case LEAnchorOutsideLeftTop:
            frame.origin.x+=-size.width;
            break;
        case LEAnchorOutsideLeftCenter:
            frame.origin.x+=-size.width;
            frame.origin.y+=relativeFrame.size.height/2-size.height/2;
            break;
        case LEAnchorOutsideLeftBottom:
            frame.origin.x+=-size.width;
            frame.origin.y+=relativeFrame.size.height-size.height;
            break;
            //
        case LEAnchorOutsideRightTop:
            frame.origin.x+=relativeFrame.size.width;
            break;
        case LEAnchorOutsideRightCenter:
            frame.origin.x+=relativeFrame.size.width;
            frame.origin.y+=relativeFrame.size.height/2-size.height/2;
            break;
        case LEAnchorOutsideRightBottom:
            frame.origin.x+=relativeFrame.size.width;
            frame.origin.y+=relativeFrame.size.height-size.height;
            break;
            //
        case LEAnchorOutsideBottomLeft:
            frame.origin.y+=relativeFrame.size.height;
            break;
        case LEAnchorOutsideBottomCenter:
            frame.origin.x+=relativeFrame.size.width/2-size.width/2;
            frame.origin.y+=relativeFrame.size.height;
            break;
        case LEAnchorOutsideBottomRight:
            frame.origin.x+=relativeFrame.size.width-size.width;
            frame.origin.y+=relativeFrame.size.height;
            break;
        default:
            break;
    }
    return frame;
}
//
- (LEAutoLayoutSettings *) leAutoLayoutSettings {
    return objc_getAssociatedObject(self, LEAutoLayoutSettingsKey);
}
- (void) setLeAutoLayoutSettings:(LEAutoLayoutSettings *)leAutoLayoutSettings {
    objc_setAssociatedObject(self, LEAutoLayoutSettingsKey, leAutoLayoutSettings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *) leAutoLayoutObservers {
    return objc_getAssociatedObject(self, LEAutoLayoutObserversKey);
}
- (void) setLeAutoLayoutObservers:(NSMutableArray *)leAutoLayoutObservers {
    objc_setAssociatedObject(self, LEAutoLayoutObserversKey, leAutoLayoutObservers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *) leAutoResizeObservers {
    return objc_getAssociatedObject(self, LEAutoResizeObserversKey);
}
- (void) setLeAutoResizeObservers:(NSMutableArray *)leAutoResizeObservers {
    objc_setAssociatedObject(self, LEAutoResizeObserversKey, leAutoResizeObservers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//
-(instancetype) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings{
    self=[self initWithFrame:[UIView leGetFrameWithAutoLayoutSettings:settings]];
    //
    self.leAutoLayoutSettings=settings;
    self.leAutoLayoutObservers=[[NSMutableArray alloc] init];
    self.leAutoResizeObservers=[[NSMutableArray alloc] init];
    [settings.leSuperView addSubview:self];
    if(settings.leRelativeView){
        if(!settings.leRelativeView.leAutoLayoutObservers){
            settings.leRelativeView.leAutoLayoutObservers=[[NSMutableArray alloc] init];
        }
        if(![self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers containsObject:self]){
            [settings.leRelativeView.leAutoLayoutObservers addObject:self];
        }
    }
    if(settings.leRelativeChangeView){
        if(![settings.leRelativeChangeView.leAutoResizeObservers containsObject:self]){
            [settings.leRelativeChangeView.leAutoResizeObservers addObject:self];
        }
    }
    [self leExtraInits];
    return self;
}
-(void) leAddAutoResizeRelativeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge{
    if(!self.leAutoLayoutSettings){
        self.leAutoLayoutSettings=[[LEAutoLayoutSettings alloc] init];
    }
    self.leAutoLayoutSettings.leRelativeChangeView=changeView;
    if(changeView==self.leAutoLayoutSettings.leSuperView){
        edge.left=-fabs(edge.left);
        edge.right=-fabs(edge.right);
        edge.top=-fabs(edge.top);
        edge.bottom=-fabs(edge.bottom);
    }
    self.leAutoLayoutSettings.leEdgeInsets=edge;
    if(!changeView.leAutoResizeObservers){
        changeView.leAutoResizeObservers=[[NSMutableArray alloc] init];
    }
    [changeView.leAutoResizeObservers addObject:self];
}

-(void) leSetFrame:(CGRect) rect {
    if(self.leAutoLayoutSettings){
        self.leAutoLayoutSettings.leOffset=rect.origin;
        self.leAutoLayoutSettings.leSize=rect.size;
        [self leExecAutoLayout];
    }else{
        if(!CGRectEqualToRect(rect, self.frame)){
            [self setFrame:rect];
            [self leExecAutoLayoutSubviews];
        }
    }
}
-(void) leSetOffset:(CGPoint) offset{
    if(self.leAutoLayoutSettings){
        self.leAutoLayoutSettings.leOffset=offset;
        [self leExecAutoLayout];
    }else {
        CGRect frame=self.frame;
        frame.origin=offset;
        if(!CGRectEqualToRect(frame, self.frame)){
            [self setFrame:frame];
            [self leExecAutoLayoutSubviews];
        }
    }
}
-(void) leSetSize:(CGSize) size{
    if(self.leAutoLayoutSettings){
        self.leAutoLayoutSettings.leSize=size;
        [self leExecAutoLayout];
    }else{
        CGRect frame=self.frame;
        frame.size=size;
        if(!CGRectEqualToRect(frame, self.frame)){
            [self setFrame:frame];
            [self leExecAutoLayoutSubviews];
        }
    }
}
-(void) leSetLeAutoLayoutSettings:(LEAutoLayoutSettings *) settings{
    self.leAutoLayoutSettings=settings;
    [self leExecAutoLayout];
}
-(void) leExecAutoLayout{
    if(self.leAutoLayoutSettings){
        if(self.leAutoLayoutSettings.leRelativeView){
            if(!self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers){
                self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers=[[NSMutableArray alloc] init];
            }
            if(![self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers containsObject:self]){
                [self.leAutoLayoutSettings.leRelativeView.leAutoLayoutObservers addObject:self];
            }
        } 
        if(self.leAutoLayoutSettings.leSuperView&&self.leAutoLayoutSettings.leRelativeView){
            if(![self.superview isEqual:self.leAutoLayoutSettings.leSuperView]){
                [self.leAutoLayoutSettings.leSuperView addSubview:self];
            }
            CGRect frame=[UIView leGetFrameWithAutoLayoutSettings:self.leAutoLayoutSettings];
            if(!CGRectEqualToRect(frame, self.frame)){
                [self setFrame:frame];
                [self leExecAutoLayoutSubviews];
            }
        }
    }
}
-(void) leExecAutoResizeWithEdgeInsets:(UIEdgeInsets) edge{
    if(self.leAutoLayoutSettings.leRelativeChangeView==self.leAutoLayoutSettings.leSuperView){
        edge.left=-fabs(edge.left);
        edge.right=-fabs(edge.right);
        edge.top=-fabs(edge.top);
        edge.bottom=-fabs(edge.bottom);
    }
    self.leAutoLayoutSettings.leEdgeInsets=edge;
    [self leExecAutoResize];
}
-(void) leExecAutoResize{
    CGSize relativeSize=self.leAutoLayoutSettings.leRelativeChangeView.bounds.size;
    UIEdgeInsets edge=self.leAutoLayoutSettings.leEdgeInsets;
    CGSize size=CGSizeMake(relativeSize.width+edge.left+edge.right, relativeSize.height+edge.top+edge.bottom);
    if(!CGSizeEqualToSize(size, self.frame.size)){
        [self leSetSize:size];
    }
}
-(void) leExecAutoLayoutSubviews{
    for (UIView *view in self.leAutoResizeObservers) {
        if(view){
            [view leExecAutoResize];
        }
    }
    for (UIView *view in self.leAutoLayoutObservers) {
        if(view){
            [view leExecAutoLayout];
        }
    }
}
@end

@implementation LEAutoLayoutLabelSettings

-(id) initWithText:(NSString *) text FontSize:(int) fontSize Font:(UIFont *) font Width:(int) width Height:(int) height Color:(UIColor *) color Line:(int) line Alignment:(NSTextAlignment) alignment{
    self=[super init];
    if(self){
        self.leText=text;
        self.leFontSize=fontSize;
        self.leFont=font;
        self.leWidth=width;
        self.leHeight=height;
        self.leColor=color;
        self.leLine=line;
        self.leAlignment=alignment;
        if(self.leFontSize>0) {
            self.leFont=[UIFont systemFontOfSize:self.leFontSize];
        }
    }
    return self;
}
@end 
@implementation LEAutoLayoutUIButtonSettings
-(id) initWithImage:(UIImage *) image SEL:(SEL) sel Target:(id) target{
    return [self initWithTitle:nil FontSize:0 Font:nil Image:image BackgroundImage:nil Color:nil SelectedColor:nil MaxWidth:0 SEL:sel Target:target];
}
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected MaxWidth:(int) width SEL:(SEL) sel Target:(id) target{
    return [self initWithTitle:title FontSize:fontSize Font:font Image:image BackgroundImage:background Color:color SelectedColor:colorSelected MaxWidth:width SEL:sel Target:target HorizontalSpace:LEDefaultButtonHorizontalSpace];
}
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected  MaxWidth:(int) width SEL:(SEL) sel Target:(id) target HorizontalSpace:(int)space{
    self=[super init];
    if(self){
        self.leSpace=space;
        self.leTitle=title;
        self.leTitleFontSize=fontSize;
        self.leTitleFont=font;
        self.leImage=image;
        self.leBackgroundImage=background;
        self.leColorNormal=color;
        self.leColorSelected=colorSelected;
        self.leSEL=sel;
        self.leMaxWidth=width;
        if(self.leTitleFontSize>0) {
            self.leTitleFont=[UIFont systemFontOfSize:self.leTitleFontSize];
        }
        self.leTarget=target;
    }
    return self;
}
@end

@interface LEUIFramework ()
@property (nonatomic,readwrite) int leNavigationButtonFontsize;
@property (nonatomic,readwrite) UIImage *leImageNavigationBack;
@property (nonatomic,readwrite) UIImage *leImageNavigationBar;
@property (nonatomic,readwrite) UIColor *leColorNavigationBar;
@property (nonatomic,readwrite) UIColor *leColorNavigationContent;
@property (nonatomic,readwrite) UIColor *leColorViewContainer;
@property (nonatomic,readwrite) NSBundle *leFrameworksBundle;
@property (nonatomic,readwrite) NSDateFormatter *leDateFormatter;
@end
@implementation LEUIFramework{
    BOOL canItBeTappedVariable;
}

#pragma Singleton 
LESingleton_implementation(LEUIFramework)
//
-(BOOL) leCanItBeTapped{
    if(canItBeTappedVariable){
        return NO;
    }else{
        canItBeTappedVariable=YES;
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leTapVariableLogic) userInfo:nil repeats:NO];
        return YES;
    }
}
-(void) leTapVariableLogic{
    canItBeTappedVariable=NO;
}
-(void) leExtraInits{
    self.leNavigationButtonFontsize=LELayoutFontSize16;
    self.leImageNavigationBar=[LEColorClear leImageStrechedFromSizeOne];
    self.leColorNavigationBar=LEColorWhite;
    self.leColorNavigationContent=LEColorBlack;
    self.leColorViewContainer=[UIColor colorWithRed:0.9647 green:0.9647 blue:0.9686 alpha:1.0];
    self.leDateFormatter=[[NSDateFormatter alloc]init];
    [self.leDateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    self.leFrameworksBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LEFrameworks" ofType:@"bundle"]];
    self.leImageNavigationBack=[self leGetImageFromLEFrameworksWithName:@"LE_web_icon_backward_off"];
}
-(void) leSetNavigationButtonFontsize:(int) fontsize{
    self.leNavigationButtonFontsize=fontsize;
}
-(void) leSetImageNavigationBack:(UIImage *) image{
    self.leImageNavigationBack=image;
}
-(void) leSetImageNavigationBar:(UIImage *) image{
    self.leImageNavigationBar=image;
}
-(void) leSetColorNavigationBar:(UIColor *) color{
    self.leColorNavigationBar=color;
}
-(void) leSetColorNavigationContent:(UIColor *) color{
    self.leColorNavigationContent=color;
}
-(void) leSetColorViewContainer:(UIColor *) color{
    self.leColorViewContainer=color;
}
-(void) leSetDateFormatter:(NSDateFormatter *) formatter{
    self.leDateFormatter=formatter;
}
#pragma  Common
+(NSString *) leIntToString:(int) i{
    return [NSString stringWithFormat:@"%d",i];
}
+(NSString *) leNumberToString:(NSNumber *) num{
    //    return [NSString stringWithFormat:@"%@",num];
    return [[[NSNumberFormatter alloc] init] stringFromNumber:num];
}
+(UIFont *) leGetSystemFontWithSize:(int)size{
    return [UIFont systemFontOfSize:size];
}
+(UIView *) getTransparentCircleLayerForView:(UIView *) view Diameter:(float) diameter MaskColor:(UIColor *) maskColor{
    UIView *layerView=[[UIView alloc] initWithFrame:view.bounds];
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.fillColor=maskColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    [path moveToPoint:CGPointMake(CGRectGetWidth(view.bounds) / 2, (CGRectGetHeight(view.bounds) -diameter) / 2)];
    [path addArcWithCenter:view.center radius:diameter / 2 startAngle:-M_PI / 2 endAngle:M_PI *3.0/2.0 clockwise:YES];
    layer.path=path.CGPath;
    layer.fillRule=kCAFillRuleEvenOdd;
    layerView.layer.cornerRadius=layer.cornerRadius;
    layerView.layer.masksToBounds=layer.masksToBounds;
    [layerView.layer addSublayer:layer];
    layerView.layer.masksToBounds=YES;
    [view addSubview:layerView];
    return layerView;
}
#pragma UIImage
+ (UIImage *) leGetMiddleStrechedImage:(UIImage *) image{
    CGSize size=[LEUIFramework leGetMiddleStrechedSize:image.size];
    return [image stretchableImageWithLeftCapWidth:size.width topCapHeight:size.height];
}
+ (CGSize) leGetMiddleStrechedSize:(CGSize) size{
    return CGSizeMake(size.width/2, size.height/2);
}
+ (UIImage *) leGetUIImage:(NSString *) name{
    UIImage *img= [UIImage imageNamed:name];
    name=nil;
    return img;
}
+ (UIImage *) leGetUIImage:(NSString *) name Streched:(BOOL) isStreched {
    UIImage *img=[LEUIFramework leGetUIImage:name];
    if(isStreched){
        img=[LEUIFramework leGetMiddleStrechedImage:img];
    }
    return img;
}
+ (CGSize) leGetSizeWithValue:(int) value{
    return CGSizeMake(value, value);
}

#pragma UIImageView
+(UIImageView *) leGetImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(NSString *) image Streched:(BOOL) isStreched{
    return  [self leGetImageViewWithSettings:settings Image:[LEUIFramework leGetUIImage:image Streched:isStreched]];
}
+(UIImageView *) leGetImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image{
    if(CGSizeEqualToSize(settings.leSize, CGSizeZero)){
        settings.leSize=image.size;
    }
    UIImageView *view=[[UIImageView alloc] initWithAutoLayoutSettings:settings];
    [view setImage:image];
    return view;
}
#pragma UILabel
+(UITextField *) leGetTextFieldWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ReturnKeyType:(UIReturnKeyType) type Delegate:(id<UITextFieldDelegate>) delegate{
    UITextField *label=[[UITextField alloc] initWithAutoLayoutSettings:settings];
    [label setReturnKeyType:type];
    [label setTextAlignment:labelSettings.leAlignment];
    [label setTextColor:labelSettings.leColor];
    [label setFont:labelSettings.leFont];
    [label setPlaceholder:labelSettings.leText];
    [label setBackgroundColor:LEColorClear]; 
    [label setDelegate:delegate];
    return label;
}
+(UILabel *) leGetLabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings {
    int width=labelSettings.leWidth;
    int height=labelSettings.leHeight;
    if(width==0||width>LESCREEN_WIDTH){
        width=LESCREEN_WIDTH;
    }
    if(height==0){
        height=LELabelMaxSize.height;
    }
    CGSize size=CGSizeZero;
    if(labelSettings.leText){
        if(labelSettings.leLine==0){
            size=[labelSettings.leText leGetSizeWithFont:labelSettings.leFont MaxSize:CGSizeMake(width, height)];
        }else if(labelSettings.leLine>=1){
            size=[labelSettings.leText leGetSizeWithFont:labelSettings.leFont MaxSize:CGSizeMake(width, height)];
            if(labelSettings.leHeight!=0){
                size.height=labelSettings.leHeight;
            }
        }
    }else{
        size=CGSizeMake(labelSettings.leWidth, labelSettings.leHeight);
    }
    settings.leSize=size;
    UILabel *label=[[UILabel alloc] initWithAutoLayoutSettings:settings];
    label.leAutoLayoutLabelSettings=labelSettings;
    [label setTextAlignment:labelSettings.leAlignment];
    [label setTextColor:labelSettings.leColor];
    [label setFont:labelSettings.leFont];
    [label setNumberOfLines:labelSettings.leLine];
    [label setBackgroundColor:LEColorClear];
    label.leAutoLayoutLabelSettings.leWidth=labelSettings.leWidth==0?LESCREEN_WIDTH:labelSettings.leWidth;
    [label setText:labelSettings.leText];
    
    
    return label;
}

#pragma UIButton
+(UIButton *) leGetCoveredButtonWithSettings:(LEAutoLayoutSettings *) settings SEL:(SEL) sel Target:(id) target{
    if(!settings){
        return nil;
    }
    UIButton *button=[[UIButton alloc] initWithAutoLayoutSettings:settings];
    [button setBackgroundImage:[LEColorMask2 leImageStrechedFromSizeOne] forState:UIControlStateHighlighted];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [settings.leSuperView addSubview:button];
    return button;
}
+(UIButton *) leGetButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings {
    if(!settings||!buttonSettings){
        return nil;
    }
    UIButton *button=[[UIButton alloc] initWithAutoLayoutSettings:settings];
    button.leAutoLayoutButtonSettings=buttonSettings;
    [button setTitle:buttonSettings.leTitle forState:UIControlStateNormal];
    [button setTitleColor:buttonSettings.leColorNormal forState:UIControlStateNormal];
    [button setTitleColor:buttonSettings.leColorSelected forState:UIControlStateHighlighted];
    [button setImage:buttonSettings.leImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonSettings.leBackgroundImage forState:UIControlStateNormal];
    [button addTarget:buttonSettings.leTarget action:buttonSettings.leSEL forControlEvents:UIControlEventTouchUpInside];
    [settings.leSuperView addSubview:button];
    [button.titleLabel setFont:buttonSettings.leTitleFont]; 
    //
    int space=buttonSettings.leSpace;
    if(space==0){
        space=LEDefaultButtonHorizontalSpace;
        buttonSettings.leSpace=space;
    }
    CGSize finalSize=settings.leSize;
    while (YES) {
        CGSize textSize=[button.titleLabel leGetLabelTextSize];
        if(textSize.width+space*2>finalSize.width){
            finalSize.width = textSize.width+space*2;
        }
        if(textSize.height+LEDefaultButtonVerticalSpace*2>finalSize.height){
            finalSize.height = textSize.height+LEDefaultButtonVerticalSpace*2;
        }
        if(buttonSettings.leMaxWidth>0 && finalSize.width>buttonSettings.leMaxWidth){
            finalSize.width=button.leAutoLayoutButtonSettings.leMaxWidth;
            buttonSettings.leTitleFont=[buttonSettings.leTitleFont fontWithSize:buttonSettings.leTitleFont.pointSize-0.2];
        }else{
            break;
        }
    }
    settings.leSize=finalSize;
    [button leExecAutoLayout];
    return button;
}


+ (UIImage *)leCreateQRForString:(NSString *)qrString Size:(CGFloat) size {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return [LEUIFramework createNonInterpolatedUIImageFormCIImage:qrFilter.outputImage withSize:size];
}
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
+ (UIImage*)leImageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

+ (BOOL)leValidateMobile:(NSString *)mobileNum {
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1\\d{10}$"] evaluateWithObject:mobileNum]) {
        return YES;
    }  else {
        return NO;
    }
}
+(NSString *) leGetComboString:(id) string,...{
    NSString *comboString=string;
    va_list params;
    va_start(params,string);
    id arg;
    if (string) {
        while( (arg = va_arg(params,id)) ) {
            if ( arg ){
                comboString=[comboString stringByAppendingString:arg];
            }
        }
        va_end(params);
    }
    return comboString;
}


+ (NSString *)leTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return LEImageTypeAsJpeg;
        case 0x89:
            return LEImageTypeAsPng;
        case 0x47:
            return LEImageTypeAsGif;
        case 0x49:
        case 0x4D:
            return LEImageTypeAsTiff;
    }
    return nil;
}
- (NSString *) leGetImagePathFromLEFrameworksWithName:(NSString *) name{
    NSString *path= [NSString stringWithFormat:@"%@/%@.png",self.leFrameworksBundle.bundlePath,name];
    return path;
}
- (UIImage *) leGetImageFromLEFrameworksWithName:(NSString *) name{
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self leGetImagePathFromLEFrameworksWithName:name]];
    return image;
} 

@end
