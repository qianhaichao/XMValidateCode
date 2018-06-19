//
//  XMValidateCode.h
//  XMValidateCode
//
//  Created by 钱海超 on 2018/6/19.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMValidateCodeButton;

typedef NSString *(^ValidateCodeChangingBlock)(XMValidateCodeButton *validateButton,NSUInteger second);
typedef NSString *(^ValidateCodeFinshedBlock)(XMValidateCodeButton *validateButton,NSUInteger second);
typedef void(^ValidateCodeTouchDownHandlerBlock)(XMValidateCodeButton *validateButton);

@interface XMValidateCodeButton : UIButton
/**
 验证码按钮点击回调
 */
- (void)validateCodeTouchDownHandler:(ValidateCodeTouchDownHandlerBlock)touchDownHandlerBlock;

/**
 验证码时间改变回调
 */
- (void)validateCodeChanging:(ValidateCodeChangingBlock)changingBlock;

/**
 验证码倒计时结束回调
 */
- (void)validateCodeFinished:(ValidateCodeFinshedBlock)finishedBlock;


/**
 开启验证码
 */
- (void)startValidateCodeWithSecond:(NSUInteger)second;


/**
 关闭验证码
 */
- (void)stopValidateCode;

@end
