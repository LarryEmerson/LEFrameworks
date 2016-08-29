//
//  LE_EmojiToolBar.m
//  LE_EmojiInput
//
//  Created by Larry Emerson on 14-5-7.
//  Copyright (c) 2014年 LarryEmerson. All rights reserved.
//

#import "LE_EmojiToolBar.h"
@interface LE_EmojiToolBar()
@property (nonatomic) id <EmojiTextDelegate> delegate;
@end
@implementation LE_EmojiToolBar{
    LEUIFramework *globalVar;
    UITextView *inputTextView;
    UIImageView *inputTextViewBackgroundView;
    UIButton *sendButton;
    EmojiInputView *emojiInputView;
    UILabel *placeHolder;
    UIButton *switcherOfKeyboard;
    //
    BOOL isInEmojiState;
    //
    BOOL isNeedToSendMsgToSomebody;
    NSString *msgForSomebody;
    BOOL isMeantToSentToSomebody;
    //
    int heightOfToolBar;
    UIColor *toolbarBackgroundColor;
    UIImage *toolbarBackgroundImage;
    UIImage *emojiFaceIcon;
    UIImage *keyboardIcon;
    UIImage *inputViewBackground;
    UIColor *inputViewBackgroundColor;
    UIColor *inputViewTextColor;
    UIColor *placeHolderColor;
    UIColor *buttonBackgroundColor;
    UIColor *buttonNormalColor;
    UIColor *buttonPressedColor;
    UIImage *buttonNormalImage;
    UIImage *buttonPressedImage;
    
    int iconWidth;
    int spaceBetweenIconAndInput;
    int inputViewWidth;
    int spaceBetweenInputViewAndButton;
    int sendButtonWidth;
    int topSpace;
    int bottomSpace;
    int placeholderOffsetX;
    
    NSString *placeholderText;
    NSString *sendButtonText;
    
    int InputTextFontSize;
    
    
    CGRect oriFrameOfInputView;
    
    BOOL isKeyboardShowing;
    NSString *lastText;
    
    BOOL isEmojiEnabled;
    
    BOOL isNotClearMessage;
    
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        [self leExtraInits];
    }
    return self;
}

-(void) leCustomizeInputbarWithBackgroundColor:(UIColor *)bgColor BackgroundImage:(UIImage *)bgImage EmojiFaceIcon:(UIImage *)eIcon KeyboardIcon:(UIImage *)kIcon InputViewBackgroundColor:(UIColor *)ivBGColor InputViewBackground:(UIImage *) ivBGImage InputViewTextColor:(UIColor *) ivTextColor PlaceholderColor:(UIColor *)holderColor SendButtonBackgroundColor:(UIColor *) buttonBGColor SendButtonBackgroundNormalColor:(UIColor *) normalColor SendButtonBackgroundPressedColor:(UIColor *) pressedColor SendButtonNormalImage:(UIImage *) normalImage SendButtonPressedImage:(UIImage *) pressedImage IconWidth:(int) iconW SpaceBetweenIconAndInputView:(int) spaceIcon InputViewWidth:(int) inputViewW SpaceBetweenInputViewAndButton:(int) spaceButton SendButtonWidth:(int) buttonWidth TopSpaceForInputViewAndButton:(int) tSpace BottomSpaceForInputViewAndButton:(int) bSpace ToolbarHeight:(int) height PlaceholderOffsetX:(int) offsetx PlaceholderString:(NSString *) placeholderString SendButtonText:(NSString *) buttonText InputViewTextFontSize:(int) fontsize EnableEmoji:(BOOL) isEmoji{
    globalVar=[LEUIFramework sharedInstance];
    isEmojiEnabled=isEmoji;
    heightOfToolBar=height;
    toolbarBackgroundColor=bgColor;
    toolbarBackgroundImage=bgImage;
    if(eIcon){
        emojiFaceIcon=eIcon;
    }
    if(kIcon){
        keyboardIcon=kIcon;
    }
    inputViewBackground=ivBGImage;
    inputViewBackgroundColor=ivBGColor;
    inputViewTextColor=ivTextColor;
    placeHolderColor=holderColor;
    buttonBackgroundColor=buttonBGColor;
    buttonNormalColor=normalColor;
    buttonPressedColor=pressedColor;
    buttonNormalImage=normalImage;
    buttonPressedImage=pressedImage;
    iconWidth=iconW;
    spaceBetweenIconAndInput=spaceIcon;
    inputViewWidth=inputViewW;
    spaceBetweenInputViewAndButton=spaceButton;
    sendButtonWidth=buttonWidth;
    topSpace=tSpace;
    bottomSpace=bSpace;
    placeholderOffsetX=offsetx;
    
    placeholderText=placeholderString;
    sendButtonText=buttonText;
    //
    [self setFrame:CGRectMake(0, LESCREEN_HEIGHT-heightOfToolBar, LESCREEN_WIDTH, heightOfToolBar)];
    if(toolbarBackgroundImage){
        [self setImage:toolbarBackgroundImage];
        [self setBackgroundColor:LEColorClear];
    }else{
        if(toolbarBackgroundColor){
            [self setBackgroundColor:toolbarBackgroundColor];
        }
    }
    [self leAddTopSplitWithColor:LEColorSplit Offset:CGPointZero Width:LESCREEN_WIDTH];
    //    [self leAddBottomSplitWithColor:LEColorSplit Offset:CGPointZero Width:LESCREEN_WIDTH];
    if(!isEmojiEnabled){
        iconWidth=0;
    }
    [inputTextView setFrame:CGRectMake(iconWidth+spaceBetweenIconAndInput, topSpace, inputViewWidth, heightOfToolBar-topSpace-bottomSpace)];
    [inputTextViewBackgroundView setFrame:inputTextView.frame];
    [inputTextViewBackgroundView setImage:inputViewBackground];
    [placeHolder setFrame:CGRectMake(iconWidth+spaceBetweenIconAndInput+placeholderOffsetX, topSpace, inputViewWidth-placeholderOffsetX*2, heightOfToolBar-topSpace-bottomSpace)];
    if(placeholderText){
        [placeHolder setText:placeholderText];
    }
    if(placeHolderColor){
        [placeHolder setTextColor:placeHolderColor];
    }
    if(inputViewBackground){
        [inputTextViewBackgroundView setImage:inputViewBackground];
        [inputTextView setBackgroundColor:LEColorClear];
    }else{
        if(inputViewBackgroundColor){
            [inputTextView setBackgroundColor:inputViewBackgroundColor];
        }
    }
    if(inputViewTextColor){
        [inputTextView setTextColor:inputViewTextColor];
    }
    
    [sendButton setFrame:CGRectMake( LESCREEN_WIDTH-sendButtonWidth-spaceBetweenInputViewAndButton, topSpace, sendButtonWidth, heightOfToolBar-topSpace-bottomSpace)];
    if(buttonNormalImage||buttonPressedColor){
        if(buttonNormalImage){
            [sendButton setBackgroundImage:buttonNormalImage forState:UIControlStateNormal];
        }
        if(buttonPressedImage){
            [sendButton setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
        }
        [sendButton setBackgroundColor:LEColorClear];
        [self AlignTextAndImageOfButton:sendButton];
    }else{
        if(buttonBackgroundColor){
            [sendButton setBackgroundColor:buttonBackgroundColor];
        }
    }
    if(buttonNormalColor){
        [sendButton setTitleColor:buttonNormalColor forState:UIControlStateNormal];
    }
    if(buttonPressedColor){
        [sendButton setTitleColor:buttonPressedColor forState:UIControlStateHighlighted];
    }
    if(sendButtonText){
        [sendButton setTitle:sendButtonText forState:UIControlStateNormal];
    }
    
    [switcherOfKeyboard setFrame:CGRectMake(0, (topSpace-bottomSpace)/2, iconWidth, heightOfToolBar)];
    [switcherOfKeyboard setImage:emojiFaceIcon forState:UIControlStateNormal];
    InputTextFontSize=fontsize;
    [inputTextView setFont:[UIFont systemFontOfSize:InputTextFontSize]];
    oriFrameOfInputView=inputTextView.frame;
    //
    [self setFrame:CGRectMake(0,  LESCREEN_HEIGHT,  LESCREEN_WIDTH, heightOfToolBar)];
    //    [self setHidden:YES];
}

-(void) leCustomizeInputbarWithBackgroundColor:(UIColor *)bgColor BackgroundImage:(UIImage *)bgImage EmojiFaceIcon:(UIImage *)eIcon KeyboardIcon:(UIImage *)kIcon InputViewBackgroundColor:(UIColor *)ivBGColor InputViewBackground:(UIImage *) ivBGImage InputViewTextColor:(UIColor *) ivTextColor PlaceholderColor:(UIColor *)holderColor SendButtonBackgroundColor:(UIColor *) buttonBGColor SendButtonBackgroundNormalColor:(UIColor *) normalColor SendButtonBackgroundPressedColor:(UIColor *) pressedColor SendButtonNormalImage:(UIImage *) normalImage SendButtonPressedImage:(UIImage *) pressedImage IconWidth:(int) iconW SpaceBetweenIconAndInputView:(int) spaceIcon InputViewWidth:(int) inputViewW SpaceBetweenInputViewAndButton:(int) spaceButton SendButtonWidth:(int) buttonWidth TopSpaceForInputViewAndButton:(int) tSpace BottomSpaceForInputViewAndButton:(int) bSpace ToolbarHeight:(int) height PlaceholderOffsetX:(int) offsetx PlaceholderString:(NSString *) placeholderString SendButtonText:(NSString *) buttonText InputViewTextFontSize:(int) fontsize{
    isEmojiEnabled=NO;
    [self leCustomizeInputbarWithBackgroundColor:bgColor BackgroundImage:bgImage EmojiFaceIcon:eIcon KeyboardIcon:kIcon InputViewBackgroundColor:ivBGColor InputViewBackground:ivBGImage InputViewTextColor:ivTextColor PlaceholderColor:holderColor SendButtonBackgroundColor:buttonBGColor SendButtonBackgroundNormalColor:normalColor SendButtonBackgroundPressedColor:pressedColor SendButtonNormalImage:normalImage SendButtonPressedImage:pressedImage IconWidth:iconW SpaceBetweenIconAndInputView:spaceIcon InputViewWidth:inputViewW SpaceBetweenInputViewAndButton:spaceButton SendButtonWidth:buttonWidth TopSpaceForInputViewAndButton:tSpace BottomSpaceForInputViewAndButton:bSpace ToolbarHeight:height PlaceholderOffsetX:offsetx PlaceholderString:placeholderString SendButtonText:buttonText InputViewTextFontSize:fontsize];
}

- (void) leSetBecomeFirstResponder:(BOOL) isResponder{
    if(isResponder){
        [inputTextView becomeFirstResponder];
    }else{
        [inputTextView resignFirstResponder];
    }
}

- (void) leSetShowOrHideToolBar:(BOOL) isShow{
    globalVar=[LEUIFramework sharedInstance];
    if(isShow){
        [self setHidden:NO];
    }
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
        if(isKeyboardShowing==NO){
            [self setFrame:CGRectMake(0,  LESCREEN_HEIGHT-(isShow?heightOfToolBar:0),  LESCREEN_WIDTH, heightOfToolBar)];
        }
    } completion:^(BOOL isDone){
        if(!isShow){
            [self setHidden:YES];
        }
    }];
}
-(void) AlignTextAndImageOfButton:(UIButton *)button {
    button.imageView.backgroundColor=[UIColor clearColor];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, 0);
    titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -titleSize.width);
}

-(void) initDefaultUI{
    globalVar=[LEUIFramework sharedInstance];
    lastText=@"";
    heightOfToolBar=LEBottomTabbarHeight;
    toolbarBackgroundColor=[[UIColor alloc]initWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1];
    toolbarBackgroundImage=nil;
    emojiFaceIcon=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_emoji_smileface"];
    keyboardIcon=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_emoji_keyboardface"]; 
    inputViewBackground=nil;
    inputViewBackgroundColor=[UIColor whiteColor];
    inputViewTextColor=[UIColor blackColor];
    placeHolderColor=[UIColor darkGrayColor];
    //
    buttonBackgroundColor=[[UIColor alloc]initWithRed:0.3 green:0.8 blue:0.6 alpha:1];
    buttonNormalColor=[UIColor whiteColor];
    buttonPressedColor=[UIColor darkGrayColor];
    buttonNormalImage=nil;
    buttonPressedImage=nil;
    //
    iconWidth=40;
    spaceBetweenIconAndInput=10;
    sendButtonWidth=60;
    spaceBetweenInputViewAndButton=10;
    inputViewWidth= LESCREEN_WIDTH-iconWidth-spaceBetweenIconAndInput-sendButtonWidth-spaceBetweenInputViewAndButton*2;
    topSpace=8;
    bottomSpace=8;
    placeholderOffsetX=5;
    
    placeholderText=@"我也说两句";
    sendButtonText=@"发送";
    InputTextFontSize=15;
}
-(void) leExtraInits{
    [self initDefaultUI];
    
    [self setFrame:CGRectMake(0,  LESCREEN_HEIGHT-heightOfToolBar,  LESCREEN_WIDTH, heightOfToolBar)];
    [self setBackgroundColor:toolbarBackgroundColor];
    inputTextView=[[UITextView alloc]initWithFrame:CGRectMake(iconWidth+spaceBetweenIconAndInput, topSpace, inputViewWidth, heightOfToolBar-topSpace-bottomSpace)];
    inputTextViewBackgroundView=[[UIImageView alloc]initWithFrame:inputTextView.frame];
    [self addSubview:inputTextViewBackgroundView];
    placeHolder=[[UILabel alloc]initWithFrame:CGRectMake(iconWidth+spaceBetweenIconAndInput+placeholderOffsetX, topSpace, inputViewWidth-placeholderOffsetX*2, heightOfToolBar-topSpace-bottomSpace)];
    [placeHolder setText:placeholderText];
    [placeHolder setTextColor:placeHolderColor];
    [placeHolder setBackgroundColor:[UIColor clearColor]];
    [inputTextView setFont:[UIFont systemFontOfSize:InputTextFontSize]];
    [inputTextView setDelegate:self];
    [inputTextView setBackgroundColor:inputViewBackgroundColor];
    [inputTextView setTextColor:inputViewTextColor];
    [self addSubview:inputTextView];
    [self addSubview:placeHolder];
    emojiInputView = [[EmojiInputView alloc] init];
    [emojiInputView changeEmojiCategoryByIndex:EMOJI_CATEGORY_MOOD];
    emojiInputView.delegate = self;
    inputTextView.inputView = nil;
    isInEmojiState=NO;
    sendButton=[[UIButton alloc]initWithFrame:CGRectMake( LESCREEN_WIDTH-sendButtonWidth-spaceBetweenInputViewAndButton, topSpace, sendButtonWidth, heightOfToolBar-topSpace-bottomSpace)];
    [sendButton setBackgroundColor:buttonBackgroundColor];
    [sendButton setTitle:sendButtonText forState:UIControlStateNormal];
    [sendButton setTitleColor:buttonNormalColor forState:UIControlStateNormal];
    [sendButton setTitleColor:buttonPressedColor forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
    
    switcherOfKeyboard=[[UIButton alloc]initWithFrame:CGRectMake(0, (topSpace-bottomSpace)/2, iconWidth, heightOfToolBar)];
    [switcherOfKeyboard setImage:emojiFaceIcon forState:UIControlStateNormal];
    [switcherOfKeyboard addTarget:self action:@selector(switchInput) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switcherOfKeyboard];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    oriFrameOfInputView=inputTextView.frame;
}


-(void) leSetDelegate:(id<EmojiTextDelegate>) delegate{
    self.delegate=delegate;
}
-(void) leMessageSomebody:(NSString *) somebody{
    if(somebody&&![somebody isEqualToString:@""]){
        isNeedToSendMsgToSomebody=YES;
        isMeantToSentToSomebody=YES;
        msgForSomebody=somebody;
        inputTextView.text=somebody;
        
        [placeHolder setHidden:YES];
    }else{
        isNeedToSendMsgToSomebody=NO;
        isMeantToSentToSomebody=NO;
        msgForSomebody=nil;
        inputTextView.text=@"";
        [placeHolder setHidden:NO];
    }
    lastText=inputTextView.text;
}
-(void) setPlaceHolderString:(NSString *)text{
    [placeHolder setText:text];
}
-(void) setSendButtonString:(NSString*)text{
    [sendButton setTitle:text forState:UIControlStateNormal];
}
-(void) leReset{
    [self setAllToDefault];
    [placeHolder setHidden:YES];
}
-(void) setAllToDefault{
    inputTextView.text=@"";
    [placeHolder setHidden:NO];
    isNeedToSendMsgToSomebody=NO;
    isMeantToSentToSomebody=NO;
    msgForSomebody=@"";
}
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    isKeyboardShowing=YES;
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.frame = CGRectMake(self.frame.origin.x, keyboardRect.origin.y-self.frame.size.height,self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished){ }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    isKeyboardShowing=NO;
    NSDictionary* userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.frame = CGRectMake(self.frame.origin.x, keyboardRect.origin.y-self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished){ }];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    if(textView == inputTextView){
        [placeHolder setHidden:YES];
    }
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(textView == inputTextView){
        [placeHolder setHidden:![inputTextView.text isEqualToString:@""]];
    }
    return YES;
}


//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    NSLog(@"textViewDidBeginEditing %@ ",TextView.text);
//}
//- (void)textViewDidEndEditing:(UITextView *)textView{
//    NSLog(@"textViewDidEndEditing %@ ",TextView.text);
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //    NSLog(@"shouldChangeTextInRange %@ %@ %d %d",textView.text,text,textView.selectedRange.length,msgForSomebody.length);
    if ([text isEqualToString:@""]) {
        //        NSLog(@"BackSpace Detected");
        if(isNeedToSendMsgToSomebody&&![inputTextView.text isEqualToString:@""]&&[inputTextView.text isEqualToString:msgForSomebody]){
            //            isNeedToSendMsgToSomebody=NO;
            //            msgForSomebody=@"";
            //            inputTextView.text=@"";
        }else{
            //            NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
            //            if ([lang isEqualToString:@"zh-Hans"]) {
            //                return YES;
            //            }else{
            [inputTextView deleteBackward];
            //            }
            
        }
        return NO;
    }
    return YES;
}

//- (void)textViewDidChangeSelection:(UITextView *)textView{
//    if(isNeedToSendMsgToSomebody&&![msgForSomebody isEqualToString:@""]&&![inputTextView.text isEqualToString:@""]){
//        if (textView.selectedRange.length<msgForSomebody.length) {
//            [textView setSelectedRange:NSMakeRange(msgForSomebody.length,0)];
//        }
//    }
//}

- (void)textViewDidChange:(UITextView *)textView{
    if(textView==inputTextView){
        //        NSLog(@"textViewDidChange %@ ",textView.text);
        if(isMeantToSentToSomebody&&![msgForSomebody isEqualToString:@""]&&![inputTextView.text isEqualToString:@""]&&![inputTextView.text hasPrefix:msgForSomebody]){
            inputTextView.text=lastText;
            return;
        }
        CGSize size = textView.contentSize;
        if (size.height >= InputTextFontSize*3 ) {
            size.height = InputTextFontSize*3;
        } else if ( size.height <= heightOfToolBar-topSpace-bottomSpace ) {
            size.height = heightOfToolBar-topSpace-bottomSpace;
        }
        [self resetToolbarFrame:size TextView:textView];
        lastText=inputTextView.text;
    }
}

-(void) resetToolbarFrame:(CGSize)size TextView:(UITextView *)textView{
    if (size.height != textView.frame.size.height ) {
        CGFloat span = size.height - textView.frame.size.height;
        CGRect frame = self.frame;
        frame.origin.y -= span;
        frame.size.height += span;
        self.frame = frame;
        CGFloat centerY = frame.size.height / 2+(topSpace-bottomSpace)/4;
        frame = textView.frame;
        frame.size = size;
        textView.frame = frame;
        [inputTextViewBackgroundView setFrame:frame];
        CGPoint center = textView.center;
        center.y = centerY+(topSpace-bottomSpace)/4;
        textView.center = center;
        center = switcherOfKeyboard.center;
        center.y = centerY+(topSpace-bottomSpace)/4;
        switcherOfKeyboard.center = center;
        center = sendButton.center;
        center.y = centerY+(topSpace-bottomSpace)/4;
        sendButton.center = center;
    }
}

//- (void)textViewDidChangeSelection:(UITextView *)textView{
//    NSLog(@"textViewDidChangeSelection %@ ",TextView.text);
//}
- (void) leSetNotClearMessage:(BOOL) isNotClear{
    isNotClearMessage=isNotClear;
}

-(void) sendText{
    //    NSLog(@"%@",TextView.text);
    if(self.delegate){
        //        if(isMeantToSentToSomebody){
        //            if([self.delegate respondsToSelector:@selector(leOnInputFinishedWithText:IsStillToTheOne:)]){
        //                [self.delegate leOnInputFinishedWithText:inputTextView.text IsStillToTheOne:isNeedToSendMsgToSomebody];
        //            }
        //        }else{
        if([self.delegate respondsToSelector:@selector(leOnInputFinishedWithText:)]){
            [self.delegate leOnInputFinishedWithText:isMeantToSentToSomebody?[inputTextView.text substringFromIndex:msgForSomebody.length]:inputTextView.text];
        }
        //        }
    }
    if(isNotClearMessage){
        [inputTextView resignFirstResponder];
        [self setAllToDefault];
        
        CGSize size = inputTextView.contentSize;
        size.height = heightOfToolBar-topSpace-bottomSpace;
        [self resetToolbarFrame:size TextView:inputTextView];
    }
}

-(void) switchInput{
    //    NSLog(@"switchInput");
    if(isInEmojiState){
        [self switchEmojiInputView];
    }else{
        isInEmojiState=YES;
        [switcherOfKeyboard setImage:keyboardIcon forState:UIControlStateNormal];
        [inputTextView resignFirstResponder];
        inputTextView.inputView = emojiInputView;
        [inputTextView becomeFirstResponder];
    }
}
//
- (void)switchEmojiInputView
{
    //    NSLog(@"switchEmojiInputView");
    isInEmojiState=NO;
    [switcherOfKeyboard setImage:emojiFaceIcon forState:UIControlStateNormal];
    inputTextView.inputView = nil;
    [inputTextView reloadInputViews];
}

- (void)setEmojiFromEmojiInputView:(NSString *)emojiStr
{
    //    NSLog(@"setEmojiFromEmojiInputView %@",emojiStr);
    [inputTextView insertText:emojiStr];
}

- (void)deleteEmoji
{
    //    NSLog(@"deleteEmoji %d %@ %@",isNeedToSendMsgToSomebody,inputTextView.text,msgForSomebody);
    if(isNeedToSendMsgToSomebody&&![inputTextView.text isEqualToString:@""]&&[inputTextView.text isEqualToString:msgForSomebody]){
        inputTextView.text=@"";
        isNeedToSendMsgToSomebody=NO;
        msgForSomebody=@"";
    }else{
        [inputTextView deleteBackward];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
