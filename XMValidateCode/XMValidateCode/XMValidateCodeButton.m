//
//  XMValidateCode.m
//  XMValidateCode
//
//  Created by 钱海超 on 2018/6/19.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "XMValidateCodeButton.h"

@interface XMValidateCodeButton()
@property (nonatomic,copy)   ValidateCodeFinshedBlock       finishedBlock;
@property (nonatomic,copy)   ValidateCodeChangingBlock      changingBlock;
@property (nonatomic,copy)   ValidateCodeTouchDownHandlerBlock      touchDownHandlerBlock;
@property (nonatomic,strong) NSTimer       *timer;
@property (nonatomic,assign) NSInteger       second;
@property (nonatomic,assign) NSUInteger       totalSecond;
@property (nonatomic,strong) NSDate       *startDate;
@end

@implementation XMValidateCodeButton

/**
 验证码按钮点击回调
 */
- (void)validateCodeTouchDownHandler:(ValidateCodeTouchDownHandlerBlock)touchDownHandlerBlock
{
    _touchDownHandlerBlock = [touchDownHandlerBlock copy];

    //添加时间
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 验证码时间改变回调
 */
- (void)validateCodeChanging:(ValidateCodeChangingBlock)changingBlock
{
    self.changingBlock = [changingBlock copy];
}

/**
 验证码倒计时结束回调
 */
- (void)validateCodeFinished:(ValidateCodeFinshedBlock)finishedBlock
{
    self.finishedBlock = [finishedBlock copy];

}


/**
 开启验证码
 */
- (void)startValidateCodeWithSecond:(NSUInteger)second
{
    self.totalSecond = second;
    self.second = second;

    //关闭交互
    self.enabled = NO;

    _timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


/**
 关闭验证码
 */
- (void)stopValidateCode
{
    if(self.timer){
        if([self.timer respondsToSelector:@selector(isValid)]){
            if([self.timer isValid]){
                [self.timer invalidate];
                self.second = self.totalSecond;
                if(self.finishedBlock){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = self.finishedBlock(self,self.totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }else{
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                }
            }
        }
    }
    self.enabled = YES;
}

#pragma mark - 事件监听
//倒计时按钮按下
- (void)touchDown:(XMValidateCodeButton *)sender
{
    if(self.touchDownHandlerBlock){
        self.touchDownHandlerBlock(sender);
    }
}
//启动倒计时
- (void)timerStart:(NSTimer *)timer
{
    double deltatime = [[NSDate date] timeIntervalSinceDate:self.startDate];
    self.second = self.totalSecond - (NSInteger)(deltatime + 0.5);
    if(self.second <= 0.0){
        [self stopValidateCode];
    }else{

        if(self.changingBlock){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = self.changingBlock(self, self.second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }else{
            NSString *title = [NSString stringWithFormat:@"%zds",self.second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
    }
}

@end
