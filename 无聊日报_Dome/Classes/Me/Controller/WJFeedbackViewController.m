//
//  WJFeedbackViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/13.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJFeedbackViewController.h"

@interface WJFeedbackViewController ()

@property (nonatomic,strong) UITextView * content;
@property (nonatomic,strong) UITextField * contactWays;
@property (nonatomic,strong) UIBarButtonItem * doneBtn;


@end

@implementation WJFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    [self addSubViews];
    [self addDoneBtn];
    // 监听文本变化
    [self.contactWays addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    
    /*/Users/JerryWang/Desktop/实习项目/无聊日报_Dome/无聊日报_Dome/Classes/Me/Controller/WJFeedbackViewController.m:30:23: No visible @interface for 'UITextField' declares the selector 'addTarget:action:forControlEvents:'*/
    
}

-(void)addSubViews{

    UILabel * feedContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 50, 20)];
    feedContent.text = @"反馈内容";
    feedContent.textColor = [UIColor grayColor];
    feedContent.font = [UIFont systemFontOfSize:12];
    
    UIView * rootView = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(feedContent.frame)+5, SCREEN_WIDTH+2, 120)];
    rootView.backgroundColor = [UIColor whiteColor];
    rootView.layer.borderWidth = 1;
    rootView.layer.borderColor = LCColorForTabBar(200, 200, 200).CGColor;
    CGFloat marginX = feedContent.frame.origin.x;
    
    _content = [[UITextView alloc] initWithFrame:CGRectMake(marginX, 10, SCREEN_WIDTH-30, rootView.frame.size.height -20)];
    //_content.placeholder = @"我们很需要你的意见和建议~";
    _content.font = [UIFont systemFontOfSize:15];
    [_content becomeFirstResponder];
    [rootView addSubview:_content];
    
    UILabel * contactWay = [[UILabel alloc] initWithFrame:CGRectMake(marginX, CGRectGetMaxY(rootView.frame)+30, 50, 20)];
    contactWay.text = @"联系方式";
    contactWay.textColor = [UIColor grayColor];
    contactWay.font = [UIFont systemFontOfSize:12];
    
    UIView * rootView2 = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(contactWay.frame)+5, SCREEN_WIDTH+2, 40)];
    rootView2.backgroundColor = [UIColor whiteColor];
    rootView2.layer.borderColor = LCColorForTabBar(200, 200, 200).CGColor;
    rootView2.layer.borderWidth = 1;
    
    _contactWays = [[UITextField alloc] initWithFrame:CGRectMake(marginX, 10, SCREEN_WIDTH-20, 20)];
    _contactWays.placeholder = @"电话/邮箱/QQ";
    _contactWays.font = [UIFont systemFontOfSize:15];
    [rootView2 addSubview:_contactWays];
    
    [self.view addSubview:feedContent];
    [self.view addSubview:rootView];
    [self.view addSubview:rootView2];
    [self.view addSubview:contactWay];
    
}

-(void)addDoneBtn{

    _doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnClick)];
    _doneBtn.enabled = NO; // 未输入内容是禁用
    self.navigationItem.rightBarButtonItem = _doneBtn;
}
-(void)doneBtnClick{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)valueChanged{

    NSString * content = self.content.text;
    NSString * number = self.contactWays.text;

    if (content.length && number.length) {
        self.doneBtn.enabled = YES;
    }else{
    
        self.doneBtn.enabled = NO;
    }
}
@end
