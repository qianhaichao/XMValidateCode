//
//  ViewController.m
//  XMValidateCode
//
//  Created by 钱海超 on 2018/6/19.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "XMValidateCodeButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //样式设置一
    [self setupValidateCode1];

    //样式设置二
    [self setupValidateCode2];



}

- (void)setupValidateCode1
{
    XMValidateCodeButton *validateCodeBtn = [XMValidateCodeButton buttonWithType:UIButtonTypeCustom];
    [validateCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    validateCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    validateCodeBtn.backgroundColor = [UIColor lightGrayColor];
    validateCodeBtn.frame = CGRectMake(80, 100, 100, 32);
    [self.view addSubview:validateCodeBtn];

    [validateCodeBtn validateCodeTouchDownHandler:^(XMValidateCodeButton *validateButton) {
        [validateCodeBtn startValidateCodeWithSecond:60];
    }];
}

- (void)setupValidateCode2
{
    XMValidateCodeButton *validateCodeBtn = [XMValidateCodeButton buttonWithType:UIButtonTypeCustom];
    [validateCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    validateCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    validateCodeBtn.backgroundColor = [UIColor grayColor];
    validateCodeBtn.frame = CGRectMake(80, 180, 100, 32);
    [self.view addSubview:validateCodeBtn];

    [validateCodeBtn validateCodeTouchDownHandler:^(XMValidateCodeButton *validateButton) {
        [validateCodeBtn startValidateCodeWithSecond:60];
        [validateCodeBtn validateCodeChanging:^NSString *(XMValidateCodeButton *validateButton, NSUInteger second) {
            return [NSString stringWithFormat:@"剩余%zds",second];
        }];
        [validateCodeBtn validateCodeFinished:^NSString *(XMValidateCodeButton *validateButton, NSUInteger second) {
            return @"重新获取";
        }];
    }];
}


@end
