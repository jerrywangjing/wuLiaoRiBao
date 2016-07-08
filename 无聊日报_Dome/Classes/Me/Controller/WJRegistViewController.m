//
//  WJRegistViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/7.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJRegistViewController.h"

@interface WJRegistViewController ()
@property (nonatomic,strong) UITextField * phoneNumber;
@property (nonatomic,strong) UITextField * password;
@property (nonatomic,strong) UIButton * registBtn;
// 用于存放注册信息
@property (nonatomic,strong) NSMutableDictionary * registInfo;

@end

@implementation WJRegistViewController

-(NSMutableDictionary *)registInfo{

    if (!_registInfo) {
        _registInfo = [NSMutableDictionary dictionary];
    }
    return _registInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    // 添加view
    [self addTextfield];
    [self addRegistBtn];
    // 监听textfield 变化
    [self.phoneNumber addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.password addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    

    
}

#pragma mark -- 添加view控件
-(void)addTextfield{
    
    // 创建根view
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(-1, 50, SCREEN_WIDTH+2, 80)];
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = LCColorForTabBar(200, 200,200).CGColor;
    bgView.backgroundColor = [UIColor whiteColor];
    UIView * centreLine = [[UIView alloc] initWithFrame:CGRectMake(10, bgView.frame.size.height/2, SCREEN_WIDTH-10, 1)];
    centreLine.backgroundColor = LCColorForTabBar(200, 200, 200);
    [bgView addSubview:centreLine];
    
    _phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];
    _phoneNumber.placeholder = @"手机号";
    _phoneNumber.borderStyle = UITextBorderStyleNone;
    _phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_phoneNumber becomeFirstResponder];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneNumber.frame), SCREEN_WIDTH-20, 40)];
    _password.placeholder = @"密码";
    _password.borderStyle = UITextBorderStyleNone;
    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password.secureTextEntry = YES;
    
    // 添加提示label
    UILabel * sign = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-10, 20)];
    sign.text = @"请确保手机畅通，已接受验证码短信";
    sign.textColor = LCColorForTabBar(150, 150, 150);
    sign.font = [UIFont systemFontOfSize:12];
    
    [bgView addSubview:_phoneNumber];
    [bgView addSubview:_password];
    [self.view addSubview:sign];
    [self.view addSubview: bgView];
}

-(void)addRegistBtn{
    
    //UIColor * colorGray = LCColorForTabBar(150, 150, 150);
    // 登陆按钮
    _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame = CGRectMake(20, 200, SCREEN_WIDTH-40, 30);
    [_registBtn setTitle:@"确认注册" forState:UIControlStateNormal];
    [_registBtn setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forState:UIControlStateNormal];
    _registBtn.layer.cornerRadius = 5;
    _registBtn.layer.masksToBounds = YES;
    _registBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _registBtn.enabled = NO;// 禁用登陆按钮
    [self.view addSubview:_registBtn];
}
// 点击注册按钮
-(void)registBtnClick{
    
    NSString * phoneNumValue = self.phoneNumber.text;
    NSString * passwordValue = self.password.text;
    
    // 判断输入合法性
    if (phoneNumValue.length == 11 && passwordValue.length >=6){
        //存储账户信息，并回传到登录界面
        [MBProgressHUD showSuccess:@"注册成功"];
        // 通知代理更新数据（**注意：首先要做响应判断）
        if ([self.delegate respondsToSelector:@selector(saveAccountWithPhoneNum:addPwd:)]) {
              [self.delegate saveAccountWithPhoneNum:phoneNumValue addPwd:passwordValue];
        }else{
        
            NSLog(@"未响应代理方法");
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(self.phoneNumber.text.length !=11){
    
        [MBProgressHUD showLabel:@"手机号不存在"];
        
    }else{
    
        [MBProgressHUD showLabel:@"密码不能少于6个字符"];
    }
    
    [self.phoneNumber resignFirstResponder];// 放弃第一响应者
}
//// 去除通知
//-(void)dealloc{
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
// 监听text文本输入框变化
-(void)textValueChanged{
    
    NSString * phoneNumValue = self.phoneNumber.text;
    NSString * passwordValue = self.password.text;
    
    if (phoneNumValue.length && passwordValue.length) {
        self.registBtn.enabled = YES;
    }else{
        
        self.registBtn.enabled = NO;
    }
}
@end
