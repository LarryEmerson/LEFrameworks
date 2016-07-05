//
//  wiEmojiInputView.h
//  wiIos
//
//  Created by qq on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiImagePageView.h"
#import "HMPageControl.h"

//    mood 
//    natural
//    life 
//    traffic
//    symbol
typedef enum
{
    EMOJI_CATEGORY_MOOD = 0,     //笑脸
    EMOJI_CATEGORY_NATURAL ,     //自然(花)
    EMOJI_CATEGORY_LIFE,         //生活(铃铛)
    EMOJI_CATEGORY_TRAFFIC,      //汽车
    EMOJI_CATEGORY_SYMBOL        //符号
} EMOJI_TYPE;


@protocol EmojiInputViewDelegate;

@interface EmojiInputView : UIView
<
    UIScrollViewDelegate,
    EmojiImagePageViewDelegate
>
{
    __unsafe_unretained id <EmojiInputViewDelegate> _delegate;
    HMPageControl *s_PageControl;
    UIScrollView *s_ScrollView;
    UISegmentedControl *s_SegmentedControl;

    BOOL s_PageControlUsed;
    
    EMOJI_TYPE s_CurrentCategory;
}

@property (nonatomic, unsafe_unretained) id <EmojiInputViewDelegate> delegate;

@property (nonatomic, strong) NSDictionary *m_EmojiDic;

@property (nonatomic, strong) NSMutableArray *m_EmojiCodeArray;
@property (nonatomic, strong) NSMutableArray *m_EmojiViews;
@property (nonatomic, strong) NSMutableArray *m_BtnArray;

- (void)changeEmojiCategoryByIndex:(EMOJI_TYPE)emojiType;

@end

@protocol EmojiInputViewDelegate

- (void)switchEmojiInputView;
- (void)deleteEmoji;

- (void)setEmojiFromEmojiInputView:(NSString *)emojiStr;


@end
