//
//  LEUIFramework.m
//  LEUIFramework
//
//  Created by Larry Emerson on 15/2/19.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEUIFramework.h"



#define IntToString(__int) [NSString stringWithFormat:@"%d",(int)__int]
#define NSIntegerToInt(__int) (int)__int





@implementation UIViewController (Extension)
-(void) setLeftBarButtonWithImage:(UIImage *)img SEL:(SEL)sel{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:sel] animated:YES];
}
-(void) setRightBarButtonWithImage:(UIImage *)img SEL:(SEL)sel{
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:sel] animated:YES];
}
-(void) setLeftBarButtonAsBackWith:(UIImage *) back{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:back style:UIBarButtonItemStylePlain target:self action:@selector(onVCBack)] animated:YES];
}
-(void) setNavigationTitle:(NSString *) title{
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
@implementation NSObject (Extension)
-(NSString *) StringValue{
    return [NSString stringWithFormat:@"%@",self];
}
@end

@implementation UIView (Extension) 
-(UIView *) getSuperView:(UIView *) view{
    return view.superview?[self getSuperView:view.superview]:view;
}
-(void) addLocalNotification:(NSString *) notification{
    if(notification&&notification.length>0){
        LELocalNotification *noti=[[LELocalNotification alloc] init];
        [noti setText:notification WithEnterTime:0.3 AndPauseTime:0.8 ReleaseWhenFinished:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:noti];
    }
}
//
-(void) endEdit{
    [self endEditing:YES];
}
-(void) addTapEventWithSEL:(SEL) sel{ 
    [self addTapEventWithSEL:sel Target:self ];
}
-(void) addTapEventWithSEL:(SEL)sel Target:(id) target{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:sel]];
}
-(UIImageView *) addTopSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width{
    UIImageView *img=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:offset CGSize:CGSizeMake(width, 0.5)] Image:[color imageStrechedFromSizeOne]];
    return img;
}
-(UIImageView *) addBottomSplitWithColor:(UIColor *) color Offset:(CGPoint) offset Width:(int) width{
    UIImageView *img= [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:offset CGSize:CGSizeMake(width, 0.5)] Image:[color imageStrechedFromSizeOne]];
    return img;
}

@end

@implementation UITableView (Extension)
-(BOOL) touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}
@end

@implementation UIImage (Extension)
-(UIImage *)middleStrechedImage{
    return [self stretchableImageWithLeftCapWidth:self.size.width/2 topCapHeight:self.size.height/2];
}
@end

@implementation UIColor (Extension)
-(UIImage *)imageStrechedFromSizeOne{
    UIImage *img=[self imageWithSize:CGSizeMake(1, 1)];
    return [img middleStrechedImage];
}
-(UIImage *)imageWithSize:(CGSize)size {
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

@implementation NSString (Extension)
-(int) asciiLength{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return (int)[da length];
    //    int strlength = 0;
    //    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    //    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
    //        if (*p) {
    //            p++;
    //            strlength++;
    //        }
    //        else {
    //            p++;
    //        }
    //    }
    //    return strlength;
}
-(NSString *) getTrimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
} 
-(NSObject *) getInstanceFromClassName{
    NSObject *obj=[NSClassFromString(self) alloc];
    NSAssert(obj!=nil,([NSString stringWithFormat:@"请检查类名是否正确：%@",self]));
    return obj;
}
//返回字符串所占用的尺寸.
-(CGSize) getSizeWithFont:(UIFont *)font MaxSize:(CGSize) size{
    if(!self){
        return CGSizeZero;
    }
    //    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font}  context:nil];
    rect.size.height=(int)rect.size.height+2;
    return rect.size;
    //    } else{
    //        CGSize strSize= [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    //        strSize.width=size.width;
    //        strSize.height=(int)strSize.height+2;
    //        return strSize;
    //    }
}
@end

@implementation UILabel (Extension)
//- (void)alignTop {
//    CGSize fontSize = [self.text sizeWithFont:self.font];
//    double finalHeight = fontSize.height * self.numberOfLines;
//    double finalWidth = self.frame.size.width;    //expected width of label
//    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
//    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
//    for(int i=0; i<newLinesToPad; i++)
//        self.text = [self.text stringByAppendingString:@"\n "];
//}

//- (void)alignBottom {
//    CGSize fontSize = [self.text sizeWithFont:self.font];
//    double finalHeight = fontSize.height * self.numberOfLines;
//    double finalWidth = self.frame.size.width;    //expected width of label
//    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
//    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
//    for(int i=0; i<newLinesToPad; i++)
//        self.text = [NSString stringWithFormat:@" \n%@",self.text];
//}
-(void) leSetText:(NSString *) text{
    if(self.leAutoLayoutSettings){
        int width=self.leAutoLayoutSettings.leLabelMaxWidth;
        int height=self.leAutoLayoutSettings.leLabelMaxHeight;
        if(width==0||width>[LEUIFramework sharedInstance].ScreenWidth){
            width=[LEUIFramework sharedInstance].ScreenWidth;
        }
        CGSize size=CGSizeZero;
        if(text){
            if(self.leAutoLayoutSettings.leLabelNumberOfLines==0){
                size=[text getSizeWithFont:self.font MaxSize:CGSizeMake(width, height)];
            }else if(self.leAutoLayoutSettings.leLabelNumberOfLines>=1){
                size=[text getSizeWithFont:self.font MaxSize:CGSizeMake(width, height)];
                if(self.leAutoLayoutSettings.leLabelNumberOfLines==1&&self.leAutoLayoutSettings.leLabelMaxHeight==0){
                    size.height=self.font.lineHeight;
                }
                if(self.leAutoLayoutSettings.leLabelMaxHeight!=0){
                    size.height=self.leAutoLayoutSettings.leLabelMaxHeight;
                } 
            }
        }else{
            size=CGSizeMake(self.leAutoLayoutSettings.leLabelMaxWidth, self.leAutoLayoutSettings.leLabelMaxHeight);
        }
        self.leAutoLayoutSettings.leSize=size;
        [self leSetSize:size];
    }
    [self setText:text];
    //    [self alignTop];
}
-(CGSize) getLabelTextSize{
    return [self.text getSizeWithFont:self.font MaxSize:LELabelMaxSize];
}
-(CGSize) getLabelTextSizeWithMaxWidth:(int) width{
    return [self.text getSizeWithFont:self.font MaxSize:CGSizeMake(width, LELabelMaxSize.height)];
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
        int width=self.leAutoLayoutSettings.leLabelMaxWidth;
        if(width==0||width>[LEUIFramework sharedInstance].ScreenWidth){
            width=[LEUIFramework sharedInstance].ScreenWidth;
        }
        CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, LELabelMaxSize.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        [self leSetSize:CGSizeMake(rect.size.width, rect.size.height)]; 
        [self redrawAttributedStringWithRect:rect LineSpace:space];
        //        if(color &&rect.size.height<=self.font.lineHeight+space){
        //            [attributedString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithInt: -space/2+1] range:NSMakeRange(0, self.text.length)];
        //            [self setAttributedText:attributedString];
        //            [self leSetSize:rect.size];
        //        } else if(rect.size.height==self.font.lineHeight+space){
        //            attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        //            [self setAttributedText:attributedString];
        //            [self leSetSize:CGSizeMake(rect.size.width, self.font.lineHeight)];
        //        }
    }
}
-(void) redrawAttributedStringWithRect:(CGRect) rect LineSpace:(int) lineSpace{
    //    if(YES)return;
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
                //                [self setBackgroundColor:ColorMask];
            }
        }
    }
}
//=======================Copy

static void * UILabelSupportCopyKey = (void *) @"UILabelSupportCopyKey";
- (NSNumber *) isSupportCopy {
    return objc_getAssociatedObject(self, UILabelSupportCopyKey);
}
- (void) setIsSupportCopy:(NSNumber *)isSupportCopy  {
    objc_setAssociatedObject(self, UILabelSupportCopyKey, isSupportCopy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)canBecomeFirstResponder{
    if([self.isSupportCopy boolValue]){
        return YES;
    }
    return [super canBecomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    if([self.isSupportCopy boolValue]){
        [self setBackgroundColor:ColorClear];
        return YES;
    }else{
        return [super resignFirstResponder];
    }
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:));
}
-(void) handleLongPress:(UILongPressGestureRecognizer *) recognizer{
    [self setBackgroundColor:ColorMask2];
    [self becomeFirstResponder];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string =self.text;
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    [self setBackgroundColor:ColorClear];
    [self resignFirstResponder];
}
-(void) addLongPressGestureWithSel:(SEL) sel Target:(id) target{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:target action:sel];
    [self addGestureRecognizer:longPress];
    [self setUserInteractionEnabled:YES];
}

-(void) addCopyGesture{
    self.isSupportCopy=[NSNumber numberWithBool:YES];
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:longPress];
    [self setUserInteractionEnabled:YES];
}
@end

@implementation UIImageView (Extension)
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

@implementation UIButton (Extension)
-(void) leSetText:(NSString *) text{
    [self setTitle:text forState:UIControlStateNormal];
    //
    CGSize finalSize=self.leAutoLayoutSettings.leSize;
    while (YES) {
        CGSize textSize=[self.titleLabel getLabelTextSize];
        if(textSize.width+DefaultButtonHorizontalSpace*2>finalSize.width){
            finalSize.width = textSize.width+DefaultButtonHorizontalSpace*2;
        }
        if(textSize.height+DefaultButtonVerticalSpace*2>finalSize.height){
            finalSize.height = textSize.height+DefaultButtonVerticalSpace*2;
        }
        if(self.leAutoLayoutSettings.leButtonMaxWidth>0 && finalSize.width>self.leAutoLayoutSettings.leButtonMaxWidth){
            finalSize.width=self.leAutoLayoutSettings.leButtonMaxWidth;
            self.titleLabel.font=[self.titleLabel.font fontWithSize:self.titleLabel.font.pointSize-0.2];
        }else{
            break;
        }
    }
    self.leAutoLayoutSettings.leSize=finalSize;
    [self leExecAutoLayout];
}
-(void) verticallyLayoutButton{
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
    [self setRelativeChangeView:superView EdgeInsects:edge];
    return self;
}

-(void) setRelativeChangeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge{
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

+ (CGRect) getFrameWithAutoLayoutSettings:(LEAutoLayoutSettings *) settings{
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
    self=[self initWithFrame:[UIView getFrameWithAutoLayoutSettings:settings]];
    //
    self.leAutoLayoutSettings=settings;
    self.leAutoLayoutObservers=[[NSMutableArray alloc] init];
    self.leAutoResizeObservers=[[NSMutableArray alloc] init];
    [settings.leSuperView addSubview:self];
    if(settings.leRelativeView){
        if(!settings.leRelativeView.leAutoLayoutObservers){
            settings.leRelativeView.leAutoLayoutObservers=[[NSMutableArray alloc] init];
        }
        [settings.leRelativeView.leAutoLayoutObservers addObject:self];
    }
    if(settings.leRelativeChangeView){
        [settings.leRelativeChangeView.leAutoResizeObservers addObject:self];
    }
    return self;
}
-(void) addAutoResizeRelativeView:(UIView *) changeView EdgeInsects:(UIEdgeInsets) edge{
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
        CGRect frame=[UIView getFrameWithAutoLayoutSettings:self.leAutoLayoutSettings];
        if(!CGRectEqualToRect(frame, self.frame)){
            [self setFrame:frame];
            [self leExecAutoLayoutSubviews];
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
-(id) initWithImage:(UIImage *) image SEL:(SEL) sel Target:(UIView *) view{
    return [self initWithTitle:nil FontSize:0 Font:nil Image:image BackgroundImage:nil Color:nil SelectedColor:nil MaxWidth:0 SEL:sel Target:view];
}
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected MaxWidth:(int) width SEL:(SEL) sel Target:(UIView *) view{
    return [self initWithTitle:title FontSize:fontSize Font:font Image:image BackgroundImage:background Color:color SelectedColor:colorSelected MaxWidth:width SEL:sel Target:view HorizontalSpace:DefaultButtonHorizontalSpace];
}
-(id) initWithTitle:(NSString *) title FontSize:(int) fontSize Font:(UIFont *) font Image:(UIImage *) image BackgroundImage:(UIImage *) background Color:(UIColor *) color SelectedColor:(UIColor *) colorSelected  MaxWidth:(int) width SEL:(SEL) sel Target:(UIView *) view HorizontalSpace:(int)space{
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
        self.leTargetView=view;
    }
    return self;
}
@end

@implementation LEUIFramework{
    NSMutableDictionary *relativeViews;
    int viewTagIncrement;
}

#pragma Singleton 
static LEUIFramework *theSharedInstance = nil;
+ (instancetype) sharedInstance { @synchronized(self) { if (theSharedInstance == nil) { theSharedInstance = [[self alloc] init];
    theSharedInstance.colorNavigationBar=[UIColor colorWithRed:0.1686 green:0.1922 blue:0.2392 alpha:1.0];
    theSharedInstance.colorNavigationContent=[UIColor whiteColor];
    theSharedInstance.colorViewContainer=[UIColor colorWithRed:0.9647 green:0.9647 blue:0.9686 alpha:1.0];
} } return theSharedInstance; }
+ (id) allocWithZone:(NSZone *)zone { @synchronized(self) { if (theSharedInstance == nil) { theSharedInstance = [super allocWithZone:zone]; return theSharedInstance; } } return nil; }
+ (id) copyWithZone:(NSZone *)zone { return self; }
+ (id) mutableCopyWithZone:(NSZone *)zone { return self; }
//

-(BOOL) canItBeTapped{
    if(self->canItBeTappedVariable){
        return NO;
    }else{
        self->canItBeTappedVariable=YES;
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(tapVariableLogic) userInfo:nil repeats:NO];
        return YES;
    }
}
-(void) tapVariableLogic{
    self->canItBeTappedVariable=NO;
}
-(id) init{
    self=[super init];
    if(self){ 
        self.ScreenBounds=[LEUIFramework ScreenBounds];
        self.ScreenWidth=self.ScreenBounds.size.width;
        self.ScreenHeight=self.ScreenBounds.size.height;
        self.SystemVersion=[LEUIFramework SystemVersion];
        self.IsIOS7=[self.SystemVersion floatValue]==7;
        self.IsIOS8=[self.SystemVersion floatValue]==8;
        self.IsIOS8OrLater=[self.SystemVersion floatValue]>=8;
        //        self.IsStatusBarNotCovered=[self.SystemVersion floatValue]>=7;
        //
        self.curScreen=[UIScreen mainScreen];
        self.curScreenScale=(int)self.curScreen.scale;
        self.leFrameworksBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LEFrameworks" ofType:@"bundle"]];
        [self extraInits];
    }
    return self;
}
//--------------------Init
-(void) extraInits{
    self.dateFormatter=[[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
}
#pragma System
+ (NSString *)SystemVersion {
    return [UIDevice currentDevice].systemVersion;
}
+ (CGRect)ScreenBounds{
    return [UIScreen mainScreen].bounds;
}
#pragma  Common
+(NSString *) intToString:(int) i{
    return [NSString stringWithFormat:@"%d",i];
}
+(NSString *) numberToString:(NSNumber *) num{
    return [NSString stringWithFormat:@"%@",num];
}
+(UIFont *) getSystemFontWithSize:(int)size{
    return [UIFont systemFontOfSize:size];
}
#pragma UIImage
+ (UIImage *) getMiddleStrechedImage:(UIImage *) image{
    CGSize size=[LEUIFramework getMiddleStrechedSize:image.size];
    return [image stretchableImageWithLeftCapWidth:size.width topCapHeight:size.height];
}
+ (CGSize) getMiddleStrechedSize:(CGSize) size{
    return CGSizeMake(size.width/2, size.height/2);
}
+ (UIImage *) getUIImage:(NSString *) name{
    return [UIImage imageNamed:name];
}
+ (UIImage *) getUIImage:(NSString *) name Streched:(BOOL) isStreched {
    UIImage *img=[LEUIFramework getUIImage:name];
    if(isStreched){
        img=[LEUIFramework getMiddleStrechedImage:img];
    }
    return img;
}
+ (CGSize) getSizeWithValue:(int) value{
    return CGSizeMake(value, value);
}

#pragma UIImageView
+(UIImageView *) getUIImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(NSString *) image Streched:(BOOL) isStreched{
    return  [self getUIImageViewWithSettings:settings Image:[LEUIFramework getUIImage:image Streched:isStreched]];
}
+(UIImageView *) getUIImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image{
    if(CGSizeEqualToSize(settings.leSize, CGSizeZero)){
        settings.leSize=image.size;
    }
    UIImageView *view=[[UIImageView alloc] initWithAutoLayoutSettings:settings];
    [view setImage:image];
    return view;
}
#pragma UILabel
+(UITextField *) getUITextFieldWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ReturnKeyType:(UIReturnKeyType) type Delegate:(id<UITextFieldDelegate>) delegate{
    UITextField *label=[[UITextField alloc] initWithAutoLayoutSettings:settings];
    [label setReturnKeyType:type];
    [label setTextAlignment:labelSettings.leAlignment];
    [label setTextColor:labelSettings.leColor];
    [label setFont:labelSettings.leFont];
    [label setPlaceholder:labelSettings.leText];
    [label setBackgroundColor:ColorClear]; 
    [label setDelegate:delegate];
    return label;
}
+(UILabel *) getUILabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings {
    CGSize size=CGSizeZero;
    int width=labelSettings.leWidth;
    int height=labelSettings.leHeight;
    if(width==0||width>[LEUIFramework sharedInstance].ScreenWidth){
        width=[LEUIFramework sharedInstance].ScreenWidth;
    }
    if(height==0){
        height=LELabelMaxSize.height;
    }
    if(labelSettings.leText){
        if(labelSettings.leLine==0){
            size=[labelSettings.leText getSizeWithFont:labelSettings.leFont MaxSize:CGSizeMake(width, height)];
        }else if(labelSettings.leLine>=1){
            size=[labelSettings.leText getSizeWithFont:labelSettings.leFont MaxSize:CGSizeMake(width, height)];
            if(labelSettings.leHeight!=0){
                size.height=labelSettings.leHeight;
            }
        }
    }else{
        size=CGSizeMake(labelSettings.leWidth, labelSettings.leHeight);
    }
    settings.leSize=size;
    UILabel *label=[[UILabel alloc] initWithAutoLayoutSettings:settings];  
    [label setTextAlignment:labelSettings.leAlignment];
    [label setTextColor:labelSettings.leColor];
    [label setFont:labelSettings.leFont];
    [label setNumberOfLines:labelSettings.leLine];
    [label setBackgroundColor:ColorClear];
    //    [label setLineBreakMode:NSLineBreakByWordWrapping];
    label.leAutoLayoutSettings.leLabelMaxWidth=labelSettings.leWidth==0?[LEUIFramework sharedInstance].ScreenWidth:labelSettings.leWidth;
    //    label.leAutoLayoutSettings.leLabelMaxHeight=height;
    label.leAutoLayoutSettings.leLabelNumberOfLines=labelSettings.leLine;
    [label setText:labelSettings.leText];
    
    
    return label;
}

#pragma UIButton
+(UIButton *) getCoveredButtonWithSettings:(LEAutoLayoutSettings *) settings SEL:(SEL) sel Target:(id) target{
    if(!settings){
        return nil;
    }
    UIButton *button=[[UIButton alloc] initWithAutoLayoutSettings:settings];
    [button setBackgroundImage:[ColorMask2 imageStrechedFromSizeOne] forState:UIControlStateHighlighted];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [settings.leSuperView addSubview:button];
    return button;
}
+(UIButton *) getUIButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings {
    if(!settings||!buttonSettings){
        return nil;
    }
    UIButton *button=[[UIButton alloc] initWithAutoLayoutSettings:settings];
    [button setTitle:buttonSettings.leTitle forState:UIControlStateNormal];
    [button setTitleColor:buttonSettings.leColorNormal forState:UIControlStateNormal];
    [button setTitleColor:buttonSettings.leColorSelected forState:UIControlStateHighlighted];
    [button setImage:buttonSettings.leImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonSettings.leBackgroundImage forState:UIControlStateNormal];
    [button addTarget:buttonSettings.leTargetView action:buttonSettings.leSEL forControlEvents:UIControlEventTouchUpInside];
    [settings.leSuperView addSubview:button];
    [button.titleLabel setFont:buttonSettings.leTitleFont];
    settings.leButtonMaxWidth=buttonSettings.leMaxWidth;
    //
    int space=buttonSettings.leSpace;
    if(space==0){
        space=DefaultButtonHorizontalSpace;
    }
    CGSize finalSize=settings.leSize;
    while (YES) {
        CGSize textSize=[button.titleLabel getLabelTextSize];
        if(textSize.width+space*2>finalSize.width){
            finalSize.width = textSize.width+space*2;
        }
        if(textSize.height+DefaultButtonVerticalSpace*2>finalSize.height){
            finalSize.height = textSize.height+DefaultButtonVerticalSpace*2;
        }
        if(buttonSettings.leMaxWidth>0 && finalSize.width>buttonSettings.leMaxWidth){
            buttonSettings.leTitleFont=[buttonSettings.leTitleFont fontWithSize:buttonSettings.leTitleFont.pointSize-0.2];
        }else{
            break;
        }
    }
    settings.leSize=finalSize;
    [button leExecAutoLayout];
    return button;
}


+ (UIImage *)createQRForString:(NSString *)qrString Size:(CGFloat) size {
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
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
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

+ (BOOL)validateMobile:(NSString *)mobileNum {
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1\\d{10}$"] evaluateWithObject:mobileNum]) {
        return YES;
    }  else {
        return NO;
    }
}
+(NSString *) getComboString:(id) string,...{
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


+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return ImageTypeAsJpeg;
        case 0x89:
            return ImageTypeAsPng;
        case 0x47:
            return ImageTypeAsGif;
        case 0x49:
        case 0x4D:
            return ImageTypeAsTiff;
    }
    return nil;
}
- (NSString *) getImagePathFromLEFrameworksWithName:(NSString *) name{
    NSString *path= [NSString stringWithFormat:@"%@/%@.png",self.leFrameworksBundle.bundlePath,name];
    return path;
}
- (UIImage *) getImageFromLEFrameworksWithName:(NSString *) name{
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self getImagePathFromLEFrameworksWithName:name]];
    return image;
}








@end