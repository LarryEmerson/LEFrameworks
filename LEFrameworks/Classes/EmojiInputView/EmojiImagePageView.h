//
//  wiEmojiImagePageView.h
//  wiIos
//
//  Created by qq on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_MAINSCREEN_HEIGHT            (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT)
#define UI_MAINSCREEN_HEIGHT_ROTATE     (UI_SCREEN_WIDTH - UI_STATUS_BAR_HEIGHT)

#define EMOJI_WIDTH     42
#define EMOJI_HEIGHT    42
#define EMOJI_TOPGAP    5
#define EMOJI_LEFTGAP   13

#define EMOJI_LINE              3
#define EMOJI_ONELINE_COUNT     7
#define EMOJI_ONEPAGE_COUNT     (EMOJI_ONELINE_COUNT*EMOJI_LINE)
#define EMOJI_VIEW_HEIGHT       (EMOJI_HEIGHT*EMOJI_LINE+2*EMOJI_TOPGAP)


@protocol EmojiImagePageViewDelegate;

@interface EmojiImagePageView : UIView
{
    NSArray *m_EmojiCodeArray;
}

@property (nonatomic, unsafe_unretained) id <EmojiImagePageViewDelegate> delegate;

@property (nonatomic, strong) NSArray *m_EmojiCodeArray;

- (id)initWithEmojiArray:(NSArray *)array;

- (void)drawPageAtIndex:(NSInteger)index;

@end


@protocol EmojiImagePageViewDelegate
- (void)selectedEmojiatIndex:(NSInteger)index;

@end