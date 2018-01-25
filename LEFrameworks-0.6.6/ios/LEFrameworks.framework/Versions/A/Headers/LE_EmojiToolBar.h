//
//  LE_EmojiToolBar.h
//  LE_EmojiInput
//
//  Created by Larry Emerson on 14-5-7.
//  Copyright (c) 2014年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiInputView.h"
#import "LEUIFramework.h"
 
@protocol EmojiTextDelegate;

@interface LE_EmojiToolBar : UIImageView<EmojiInputViewDelegate,UITextViewDelegate>
-(void) leSetDelegate:(id<EmojiTextDelegate>) delegate;
-(void) leMessageSomebody:(NSString *) somebody;
-(void) leCustomizeInputbarWithBackgroundColor:(UIColor *)bgColor BackgroundImage:(UIImage *)bgImage EmojiFaceIcon:(UIImage *)eIcon KeyboardIcon:(UIImage *)kIcon InputViewBackgroundColor:(UIColor *)ivBGColor InputViewBackground:(UIImage *) ivBGImage InputViewTextColor:(UIColor *) ivTextColor PlaceholderColor:(UIColor *)holderColor SendButtonBackgroundColor:(UIColor *) buttonBGColor SendButtonBackgroundNormalColor:(UIColor *) normalColor SendButtonBackgroundPressedColor:(UIColor *) pressedColor SendButtonNormalImage:(UIImage *) normalImage SendButtonPressedImage:(UIImage *) pressedImage IconWidth:(int) iconW SpaceBetweenIconAndInputView:(int) spaceIcon InputViewWidth:(int) inputViewW SpaceBetweenInputViewAndButton:(int) spaceButton SendButtonWidth:(int) buttonWidth TopSpaceForInputViewAndButton:(int) tSpace BottomSpaceForInputViewAndButton:(int) bSpace ToolbarHeight:(int) height PlaceholderOffsetX:(int) offsetx PlaceholderString:(NSString *) placeholderString SendButtonText:(NSString *) buttonText InputViewTextFontSize:(int) fontsize;
-(void) leCustomizeInputbarWithBackgroundColor:(UIColor *)bgColor BackgroundImage:(UIImage *)bgImage EmojiFaceIcon:(UIImage *)eIcon KeyboardIcon:(UIImage *)kIcon InputViewBackgroundColor:(UIColor *)ivBGColor InputViewBackground:(UIImage *) ivBGImage InputViewTextColor:(UIColor *) ivTextColor PlaceholderColor:(UIColor *)holderColor SendButtonBackgroundColor:(UIColor *) buttonBGColor SendButtonBackgroundNormalColor:(UIColor *) normalColor SendButtonBackgroundPressedColor:(UIColor *) pressedColor SendButtonNormalImage:(UIImage *) normalImage SendButtonPressedImage:(UIImage *) pressedImage IconWidth:(int) iconW SpaceBetweenIconAndInputView:(int) spaceIcon InputViewWidth:(int) inputViewW SpaceBetweenInputViewAndButton:(int) spaceButton SendButtonWidth:(int) buttonWidth TopSpaceForInputViewAndButton:(int) tSpace BottomSpaceForInputViewAndButton:(int) bSpace ToolbarHeight:(int) height PlaceholderOffsetX:(int) offsetx PlaceholderString:(NSString *) placeholderString SendButtonText:(NSString *) buttonText InputViewTextFontSize:(int) fontsize EnableEmoji:(BOOL) isEmoji;
- (void) leSetShowOrHideToolBar:(BOOL) isShow;
- (void) leSetBecomeFirstResponder:(BOOL) isResponder;
- (void) leSetNotClearMessage:(BOOL) isNotClear;
- (void) leReset;
@end

@protocol EmojiTextDelegate<NSObject>
@required
- (void) leOnInputFinishedWithText:(NSString *)text;
//- (void) leOnInputFinishedWithText:(NSString *)text IsStillToTheOne:(BOOL) isToSB;

@end