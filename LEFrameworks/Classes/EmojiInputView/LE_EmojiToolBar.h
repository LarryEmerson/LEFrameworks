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
@property (nonatomic) id <EmojiTextDelegate> delegate;
-(void) messageSomebody:(NSString *) somebody;
-(void) setCustomToolbarSkinWithToolbarBackgroundColorAs:(UIColor *)bgColor BackgroundImage:(UIImage *)bgImage EmojiFaceIcon:(UIImage *)eIcon KeyboardIcon:(UIImage *)kIcon InputViewBackgroundColor:(UIColor *)ivBGColor InputViewBackground:(UIImage *) ivBGImage InputViewTextColor:(UIColor *) ivTextColor PlaceholderColor:(UIColor *)holderColor SendButtonBackgroundColor:(UIColor *) buttonBGColor SendButtonBackgroundNormalColor:(UIColor *) normalColor SendButtonBackgroundPressedColor:(UIColor *) pressedColor SendButtonNormalImage:(UIImage *) normalImage SendButtonPressedImage:(UIImage *) pressedImage IconWidth:(int) iconW SpaceBetweenIconAndInputView:(int) spaceIcon InputViewWidth:(int) inputViewW SpaceBetweenInputViewAndButton:(int) spaceButton SendButtonWidth:(int) buttonWidth TopSpaceForInputViewAndButton:(int) tSpace BottomSpaceForInputViewAndButton:(int) bSpace ToolbarHeight:(int) height PlaceholderOffsetX:(int) offsetx PlaceholderString:(NSString *) placeholderString SendButtonText:(NSString *) buttonText InputViewTextFontSize:(int) fontsize;
-(void) setCustomToolbarSkinWithToolbarBackgroundColorAs:(UIColor *)bgColor BackgroundImage:(UIImage *)bgImage EmojiFaceIcon:(UIImage *)eIcon KeyboardIcon:(UIImage *)kIcon InputViewBackgroundColor:(UIColor *)ivBGColor InputViewBackground:(UIImage *) ivBGImage InputViewTextColor:(UIColor *) ivTextColor PlaceholderColor:(UIColor *)holderColor SendButtonBackgroundColor:(UIColor *) buttonBGColor SendButtonBackgroundNormalColor:(UIColor *) normalColor SendButtonBackgroundPressedColor:(UIColor *) pressedColor SendButtonNormalImage:(UIImage *) normalImage SendButtonPressedImage:(UIImage *) pressedImage IconWidth:(int) iconW SpaceBetweenIconAndInputView:(int) spaceIcon InputViewWidth:(int) inputViewW SpaceBetweenInputViewAndButton:(int) spaceButton SendButtonWidth:(int) buttonWidth TopSpaceForInputViewAndButton:(int) tSpace BottomSpaceForInputViewAndButton:(int) bSpace ToolbarHeight:(int) height PlaceholderOffsetX:(int) offsetx PlaceholderString:(NSString *) placeholderString SendButtonText:(NSString *) buttonText InputViewTextFontSize:(int) fontsize EnableEmoji:(BOOL) isEmoji;
- (void) setShowOrHideToolBar:(BOOL) isShow;
- (void) setBecomeFirstResponder:(BOOL) isResponder;
- (void) setNotClearMessage:(BOOL) isNotClear;
- (void) reset;
@end

@protocol EmojiTextDelegate<NSObject>
@required
- (void) setFinishedText:(NSString *)text;
//- (void) setFinishedText:(NSString *)text IsStillToTheOne:(BOOL) isToSB;

@end