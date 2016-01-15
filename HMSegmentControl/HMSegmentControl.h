//
//  HMSegmentControl.h
//  HMSegmentControl
//
//  Created by mac on 16/1/15.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionReturnValue)(NSInteger index, id returnValue);

@interface HMSegmentControl : UIView

/// 默认字体颜色
@property (nonatomic, strong) UIColor *textColor;
/// 选中字体颜色
@property (nonatomic, strong) UIColor *selectTextColor;
/// 字体大小
@property (nonatomic, strong) UIFont *font;
/// 滚动视图颜色
@property (nonatomic, strong) UIColor *maskColor;
/// 动画时间
@property (nonatomic, assign) NSTimeInterval duration;
/// maskview size
@property (nonatomic, assign) CGFloat maskWidth;
@property (nonatomic, assign) CGFloat maskHeight;
/// maskview radius
@property (nonatomic, assign) CGFloat cornerRadius;

/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

/// 刷新设置, 设置相关属性之后调取此方法
- (void)reloadData;

/// 点击回调
- (void)HMSegmentControlClickedCompletion:(CompletionReturnValue)returnValue;

@end
