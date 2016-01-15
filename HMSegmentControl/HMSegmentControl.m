//
//  HMSegmentControl.m
//  HMSegmentControl
//
//  Created by mac on 16/1/15.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import "HMSegmentControl.h"

#define BOTTOM_LABEL_TAG   1000000
#define MASK_LABEL_TAG     2000000

@interface HMSegmentControl ()

@property (nonatomic, strong) NSArray <NSString *>*dataArray;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, copy) CompletionReturnValue tempCompletion;

@end

@implementation HMSegmentControl

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSArray arrayWithArray:dataArray];
    }
    return self;
}

- (void)dealloc {
    self.tempCompletion = nil;
}

- (void)buildUI {
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake([self marginLeft], [self marginTop], self.maskWidth, self.maskHeight)];
    _maskView.backgroundColor = self.maskColor;
    _maskView.clipsToBounds = YES;
    _maskView.layer.cornerRadius = self.cornerRadius;
    _maskView.userInteractionEnabled = NO;
    
    __weak __typeof(self) weakSelf = self;
    
    [self.dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *bottoMLabel = [[UILabel alloc] initWithFrame:CGRectMake(idx * [weakSelf labelWidth], 0, [weakSelf labelWidth], [weakSelf commonHeight])];
        bottoMLabel.textColor = weakSelf.textColor;
        bottoMLabel.font = weakSelf.font;
        bottoMLabel.backgroundColor = [UIColor clearColor];
        bottoMLabel.text = obj;
        bottoMLabel.textAlignment = NSTextAlignmentCenter;
        bottoMLabel.userInteractionEnabled = YES;
        bottoMLabel.tag = BOTTOM_LABEL_TAG + idx;
        [self addSubview:bottoMLabel];
        
        UILabel *masKLabel = [[UILabel alloc] initWithFrame:CGRectMake(-[weakSelf marginLeft] + idx * [weakSelf labelWidth], -[weakSelf marginTop], [weakSelf labelWidth], [weakSelf commonHeight])];
        masKLabel.textColor = weakSelf.selectTextColor;
        masKLabel.font = weakSelf.font;
        masKLabel.backgroundColor = [UIColor clearColor];
        masKLabel.text = obj;
        masKLabel.textAlignment = NSTextAlignmentCenter;
        masKLabel.tag = MASK_LABEL_TAG + idx;
        [weakSelf.maskView addSubview:masKLabel];
        
        UITapGestureRecognizer *bottomLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickedLabelAction:)];
        bottomLabelTap.numberOfTapsRequired = 1;
        [bottoMLabel addGestureRecognizer:bottomLabelTap];

        UITapGestureRecognizer *maskLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickedLabelAction:)];
        maskLabelTap.numberOfTapsRequired = 1;
        [masKLabel addGestureRecognizer:maskLabelTap];
    }];
    [self addSubview:_maskView];
}

- (void)ClickedLabelAction:(UITapGestureRecognizer *)Sender {
    UILabel *label = (UILabel *)Sender.view;
    if (self.tempCompletion) {
        self.tempCompletion((label.tag - BOTTOM_LABEL_TAG), label.text);
    }
    [self maskViewAnimation:(label.tag - BOTTOM_LABEL_TAG)];
}

- (void)HMSegmentControlClickedCompletion:(CompletionReturnValue)returnValue {
    self.tempCompletion = returnValue;
}

- (void)maskViewAnimation:(NSInteger)index {
    
    [UIView animateWithDuration:self.duration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        /// 移动maskView
        self.maskView.frame = CGRectMake([self marginLeft] + index * [self labelWidth], [self marginTop], self.maskWidth, self.maskHeight);
        
        /// 移动maskView上的子视图
        [self.maskView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *selectLabel = (UILabel *)obj;
            NSInteger selectLabelIndex = selectLabel.tag - MASK_LABEL_TAG;
            selectLabel.frame = CGRectMake(-[self marginLeft] + (selectLabelIndex - index) * [self labelWidth], -[self marginTop], [self labelWidth], [self commonHeight]);
        }];
        
    } completion:nil];
}

- (CGFloat)marginLeft {
    return ([self labelWidth] - self.maskWidth) / 2;
}

- (CGFloat)marginTop {
    return ([self commonHeight] - self.maskHeight) / 2;
}

- (CGFloat)labelWidth {
    return CGRectGetWidth(self.frame) / self.dataArray.count;
}

- (CGFloat)commonHeight {
    return CGRectGetHeight(self.frame);
}

- (UIColor *)textColor {
    return _textColor ? _textColor : [UIColor darkTextColor];
}

- (UIColor *)selectTextColor {
    return _selectTextColor ? _selectTextColor : [UIColor whiteColor];
}

- (UIFont *)font {
    return _font ? _font : [UIFont systemFontOfSize:14];
}

- (UIColor *)maskColor {
    return _maskColor ? _maskColor : [UIColor redColor];
}

- (NSTimeInterval)duration {
    return (_duration != 0) ? _duration : 0.5;
}

- (CGFloat)cornerRadius {
    return (_cornerRadius != 0) ? _cornerRadius : 5;
}

- (CGFloat)maskWidth {
    return (_maskWidth != 0) ? _maskWidth : ([self labelWidth] - 20);
}

- (CGFloat)maskHeight {
    return (_maskHeight != 0) ? _maskHeight : ([self commonHeight] - 15);
}

- (void)reloadData {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self buildUI];
}

@end
