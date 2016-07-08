//
//  WJLoginViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/5.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJLoginViewController.h"
#import "WJNavigationController.h"
#import "WJRegistViewController.h"
#import "WJForgetPwdViewController.h"

@interface WJLoginViewController ()<registAccountDelegate>

@property (nonatomic,strong) UITextField * phoneNumber;
@property (nonatomic,strong) UITextField * password;
@property (nonatomic,strong) UIButton * loginBtn;
// 用户账户信息
@property (nonatomic,strong) NSMutableDictionary * userInfo;
@property (nonatomic,strong) WJRegistViewController * registVc;


@end

@implementation WJLoginViewController

-(NSMutableDictionary *)userInfo{

    if (!_userInfo) {
        _userInfo = [NSMutableDictionary dictionary];
    }
    return _userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    [self addNavBtns];//添加导航条按钮
    [self addTextfield];// 添加登录框
    [self addLoginBtn];// 添加登录按钮
    [self addShareBtn]; // 添加分享按钮
    // 监听文本输入框值的变化
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"password"]) {
        self.loginBtn.enabled = YES;
    }else{
        
        [self.phoneNumber addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
        [self.password addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
//    // 注册通知中心
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:@"registInfo" object:nil];
    // 设置用户信息默认值  **注意要在此要设置默认值*
    self.phoneNumber.text = [defaults objectForKey:@"phoneNum"];
    self.password.text = [defaults objectForKey:@"password"];
    
}
#pragma mark -- view视图
-(void)valueChanged:(NSNotification *) noti{

     self.userInfo = (NSMutableDictionary *)noti.userInfo;
    
    self.phoneNumber.text = self.userInfo[@"phoneNum"];
}
-(void)addNavBtns{
    // 取消btn
    UIBarButtonItem * cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.leftBarButtonItem = cancel;
    // 注册btn
    UIBarButtonItem * regist = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registClick)];
    self.navigationItem.rightBarButtonItem = regist;
}

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
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneNumber.frame), SCREEN_WIDTH-20, 40)];
    _password.placeholder = @"密码";
    _password.borderStyle = UITextBorderStyleNone;
    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password.secureTextEntry = YES;
    
    [bgView addSubview:_phoneNumber];
    [bgView addSubview:_password];
    [self.view addSubview: bgView];
}

-(void)addLoginBtn{

    UIColor * colorGray = LCColorForTabBar(150, 150, 150);
    // 登陆按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(10, 160, SCREEN_WIDTH-20, 30);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.enabled = NO;// 禁用登陆按钮
    // 忘记密码btn
    UIButton * forgotPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgotPwdBtn.frame = CGRectMake(SCREEN_WIDTH-60, CGRectGetMaxY(_loginBtn.frame)+20, 50, 20);
    [forgotPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgotPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forgotPwdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgotPwdBtn addTarget:self action:@selector(forgtPwdClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 社交登录label
    UILabel * accountNum = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, CGRectGetMaxY(forgotPwdBtn.frame)+20, 100, 20)];
    accountNum.text = @"使用社交账号登录";
    accountNum.textColor = colorGray;
    accountNum.font = [UIFont systemFontOfSize:12];
        // 添加左右线条
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, accountNum.frame.origin.y + 10, accountNum.frame.origin.x-20, 1)];
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountNum.frame)+10, line.frame.origin.y, line.frame.size.width, 1)];
    line1.backgroundColor = LCColorForTabBar(210, 210, 210);
    line.backgroundColor = LCColorForTabBar(210, 210, 210);
    [self.view addSubview:line];
    [self.view addSubview:line1];
    [self.view addSubview:accountNum];
    [self.view addSubview:forgotPwdBtn];
    [self.view addSubview:_loginBtn];
}
// 添加分享按钮
-(void)addShareBtn{

    CGFloat btnY = 300;
    CGFloat margin = (SCREEN_WIDTH- 50 *3)/4 ;
    CGFloat btnW = 50;
    CGFloat btnH = 50;
    
    UIButton * weibo = [UIButton buttonWithType:UIButtonTypeCustom];
    weibo.frame = CGRectMake(margin, btnY, btnW, btnH);
    [weibo setImage:[UIImage imageNamed:@"Share_WeiboIcon~iphone"] forState:UIControlStateNormal];
    
    UIButton * weixin = [UIButton buttonWithType:UIButtonTypeCustom];
    weixin.frame = CGRectMake(CGRectGetMaxX(weibo.frame)+margin, btnY, btnW, btnH);
    [weixin setImage:[UIImage imageNamed:@"Share_WeChatSessionIcon~iphone"] forState:UIControlStateNormal];
    
    UIButton * QQ = [UIButton buttonWithType:UIButtonTypeCustom];
    QQ.frame = CGRectMake(CGRectGetMaxX(weixin.frame) +margin, btnY, btnW, btnH);
    [QQ setImage:[UIImage imageNamed:@"Share_QQIcon~iphone"] forState:UIControlStateNormal];
    [self.view addSubview:weixin];
    [self.view addSubview:QQ];
    [self.view addSubview: weibo];
}

#pragma mark --  事件响应方法
// 监听text文本输入框变化
-(void)textValueChanged{

    NSString * phoneNumValue = self.phoneNumber.text;
    NSString * passwordValue = self.password.text;

    if (phoneNumValue.length && passwordValue.length) {
        self.loginBtn.enabled = YES;
        
    }else{
    
        self.loginBtn.enabled = NO;
    }
}

-(void)loginBtnClick{
    
    NSString * phoneNumValue = self.phoneNumber.text;
    NSString * passwordValue = self.password.text;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [MBProgressHUD showMessage:@"正在登陆..."];
        //模拟延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
          [MBProgressHUD hideHUD]; // 隐藏提示
        if ([phoneNumValue isEqualToString:self.userInfo[@"phoneNum"]] && [passwordValue isEqualToString:self.userInfo[@"password"]]) {
            [MBProgressHUD showSuccess:@"登录成功"];
            // 保存登录信息
           
            [defaults setObject:phoneNumValue forKey:@"phoneNum"];
            [defaults setObject:passwordValue forKey:@"password"];
            
            //通知代理->更新用户头像，姓名，下面切换为tableview
            if ([self.delegate respondsToSelector:@selector(changeUserInfoWithImg:addName:)]) {
                [self.delegate changeUserInfoWithImg:[UIImage imageNamed:@"me_avatar_boy~iphone"] addName:@"未设置用户名"];
            }
        
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if([defaults objectForKey:@"password"]){
            
            [MBProgressHUD showSuccess:@"登录成功"];
            //通知代理->更新用户头像，姓名，下面切换为tableview
            if ([self.delegate respondsToSelector:@selector(changeUserInfoWithImg:addName:)]) {
                
                NSString * name;
                UIImage * image;
                
                NSString * path = [defaults objectForKey:@"imagePath"];
                
                NSData * imgData = [NSData dataWithContentsOfFile:path];
                image = [UIImage imageWithData:imgData];
                
                if ([defaults objectForKey:@"userName"]) {
                    name = [defaults objectForKey:@"userName"];
                }else{
                
                    name = @"未设置昵称";
                }
                if (!image) {
                    NSLog(@"未找到图像");
                    image = [UIImage imageNamed:@"me_avatar_boy~iphone"]; //默认头像
                }
                [self.delegate changeUserInfoWithImg:image addName:name];
            }
                //切换为tableView视图（代理通知MeVc）
            [self.delegate presentViewToTabelView];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }else{
        
             [MBProgressHUD showLabel:@"手机号或密码错误"];
        }
    });
    
}
// 注册 点击
-(void)registClick{
    
    WJRegistViewController * registVc = [[WJRegistViewController alloc] init];
    registVc.delegate = self;//这里特别注意：要在跳转到注册页面的点击方法(也就是此方法)中给委托对象指定自己(self)为其代理。
    [self.navigationController pushViewController: registVc animated: YES];
}
// 取消 点击
-(void)cancelClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
// 忘记密码 点击
-(void)forgtPwdClick{

    WJForgetPwdViewController * viewVc = [[WJForgetPwdViewController alloc] init];

    [self.navigationController pushViewController: viewVc animated:YES];
    
}

#pragma mark -- 代理方法

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
/** 使用storyboard 创建的页面代理传值需要用到这个方法*/

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//
//    id destVc = segue.destinationViewController;
//    if ([destVc isKindOfClass:[WJRegistViewController class]]) {
//        WJRegistViewController * registVc = destVc;
//        registVc.delegate = self;
//    }
//}
// 注册页面代理方法
-(void)saveAccountWithPhoneNum:(NSString *)phoneNum addPwd:(NSString *)pwd{

    self.phoneNumber.text = phoneNum;
    [self.userInfo setValue:phoneNum forKey:@"phoneNum"];
    [self.userInfo setValue:pwd forKey:@"password"];

}

@end
