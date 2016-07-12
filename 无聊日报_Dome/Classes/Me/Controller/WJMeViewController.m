//
//  WJMeViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/7.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMeViewController.h"
#import "WJLoginViewController.h"
#import "WJNavigationController.h"
#import "WJSettingTableViewController.h"
#import "WJMyMsgViewController.h"
#import "WJEditUserInfoViewController.h"
#import "WJTabelViewData.h"
#import "WJDetailViewController.h"
#import "WJGiftData.h"
#import "WJUserInfo.h"
#import "WJGiftDetailViewController.h"

@interface WJMeViewController ()<loginViewDelegate,editViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UIImageView * bgImg;
@property (nonatomic,strong) UIView * redLine;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * btnLeft;
@property (nonatomic,strong) UIImageView * iconImg;
@property (nonatomic,strong) UILabel * userName;
// 未登录状态底部视图
@property (nonatomic,strong) UIView * unloginView;
// 判断点击的是哪个标签
@property (nonatomic,assign) BOOL isLeftTbView;
// cell数据模型
@property (nonatomic,strong) NSMutableArray * rightCellDataArr;
@property (nonatomic,strong) NSMutableArray * leftCellDataArr;



@end

@implementation WJMeViewController

-(NSMutableArray *)rightCellDataArr{

    if (!_rightCellDataArr) {
        _rightCellDataArr = [NSMutableArray array];
    }
    return _rightCellDataArr;
}
-(NSMutableArray *)leftCellDataArr{

    if (!_leftCellDataArr) {
        _leftCellDataArr = [NSMutableArray array];
    }
    return _leftCellDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加头部视图
    [self headerViews];
    
    if (!self.isLogining) {
        [self unLoginView]; // 未登录状态视图
    }
    // 设置btnFlag的默认值
    //self.btnFlag = YES;
    //注册来自点击喜欢按钮的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedLikeNoti:) name:@"lickNoti" object:nil];
    //来自gift的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGiftNoti:) name:@"giftNoti" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 设置App状态栏样式为亮色
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
#pragma mark -- 接收通知中心发了的通知
-(void)receivedLikeNoti:(NSNotification *)noti{

    [self.rightCellDataArr addObject:noti.object];
    [self.tableView reloadData];// 刷新数据
}
-(void)receivedGiftNoti:(NSNotification *)noti{

    [self.leftCellDataArr addObject:noti.object];
    [self.tableView reloadData];
}
#pragma mark -- tableView代理方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
#pragma mark -- 需要添加的视图

-(void)headerViews{

    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    
    _bgImg = [[UIImageView alloc] init];
    UIImage * bgImg = [UIImage imageNamed:@"Me_headerBackground"];
    _bgImg.image = bgImg;
    _bgImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, _headerView.frame.size.height -50);
    //_bgImg.contentMode = UIViewContentModeScaleAspectFill;
    [_bgImg setUserInteractionEnabled:YES];//注意：设置用户交互后才能响应点击事件
    // 给bgImg添加tap手势触摸事件
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginViewClick)];
    [_bgImg addGestureRecognizer:gesture];
    // 间隔线
    UIView * marginView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 10)];
    marginView.backgroundColor = LCColorForTabBar(230, 230, 230);
    // 添加分页按钮
    _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLeft.frame = CGRectMake(0, 180, SCREEN_WIDTH/2, 40);
    _btnLeft.layer.borderWidth = 1;//设置按钮边框宽度
    _btnLeft.layer.borderColor = LCColorForTabBar(200, 200, 200).CGColor;//边框颜色
    [_btnLeft setTitle:@"喜欢的商品" forState:UIControlStateNormal];
    [_btnLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];// 注意：button颜色用这个方法设置
    _btnLeft.titleLabel.textAlignment = NSTextAlignmentCenter;
    _btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnLeft addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
    // 红色指示下划线
    _redLine = [[UIView alloc] initWithFrame:CGRectMake(0, _btnLeft.frame.size.height-3, SCREEN_WIDTH/2, 2)];
    _redLine.backgroundColor = [UIColor redColor];
    [_btnLeft addSubview:_redLine];
    
    UIButton * btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(CGRectGetMaxX(_btnLeft.frame)-1, 180, SCREEN_WIDTH/2+1, 40);
    btnRight.layer.borderWidth = 1;
    btnRight.layer.borderColor = LCColorForTabBar(200, 200, 200).CGColor;
    [btnRight setTitle:@"喜欢的专题" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnRight.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnRight addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 添加头像
    _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_avatar_boy"]];
    CGFloat iconW = 70;
    CGFloat iconH = 70;
    _iconImg.frame = CGRectMake((SCREEN_WIDTH - iconW)/2, 50, iconW, iconH);
        // 给头像设置圆角
    _iconImg.layer.cornerRadius = 35;
    _iconImg.layer.masksToBounds = YES;
    // 添加登录label
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImg.frame)+10, SCREEN_WIDTH, 20)];
    _userName.text = @"登录";
    _userName.textColor = [UIColor whiteColor];
    _userName.font = [UIFont systemFontOfSize:16];
    _userName.textAlignment = NSTextAlignmentCenter; // 文字居中
    // 添加消息按钮
    UIButton * msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnWH = 20;
    CGFloat btnY = 30;
    CGFloat btnX = 20;
    msgBtn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
    
    [msgBtn setImage:[UIImage imageNamed:@"Me_message~iphone"] forState:UIControlStateNormal];
    [msgBtn addTarget:self action:@selector(msgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 添加设置按钮
    UIButton * settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(SCREEN_WIDTH -(btnX+btnWH), btnY, btnWH, btnWH);
    [settingBtn setImage:[UIImage imageNamed:@"Me_settings~iphone"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgImg addSubview:settingBtn];
    [_bgImg addSubview:msgBtn];
    [_bgImg addSubview:_userName];
    [_bgImg addSubview:_iconImg];
    
    [_headerView addSubview:_btnLeft];
    [_headerView addSubview:btnRight];
    [_headerView addSubview:marginView];
    [_headerView addSubview:_bgImg];
    [self.view addSubview:_headerView];

}

// 未登陆状态提示视图
-(void)unLoginView{

    CGFloat viewH = CGRectGetMaxY(_btnLeft.frame);
    _unloginView = [[UIView alloc] initWithFrame:CGRectMake(0,viewH, SCREEN_WIDTH, SCREEN_HEIGHT-viewH)];
    
    //图片
    UIImageView * heart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Me_blank~iphone"]];
    CGFloat heartWH = 40;
    CGFloat heartX = (SCREEN_WIDTH - heartWH)/2;
    CGFloat heartY = 100;
    heart.frame = CGRectMake(heartX, heartY, heartWH, heartWH);
    // 文字
    CGFloat labelW = 120;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - labelW)/2, CGRectGetMaxY(heart.frame)+10, labelW, 20)];
    label.text = @"登陆以享受更多功能";
    label.textColor = LCColorForTabBar(200, 200, 200);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    
    [_unloginView addSubview:heart];
    [_unloginView addSubview:label];
    [self.view addSubview:_unloginView];
}
#pragma mark -- 点击事件方法
// 刷新tableview状态
-(void)reloadTableView:(NSInteger)dataCount{

    if (dataCount >0) {
        [self addUserTableView];
        [self.tableView reloadData];//重新刷新数据
    }else{
        
        // 首先要获取到现在父视图上的tableview子视图
        UIView * subView = [self.view viewWithTag:123];
        [subView removeFromSuperview];//从父视图移除tableview
    }

}
// 喜欢的商品按钮
-(void)btnRightClick{
    
    [UIView animateWithDuration:0 animations:^{
        _redLine.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH/2, 0);}];
    // 切换cell内容
    self.isLeftTbView = NO;
    [self reloadTableView:self.rightCellDataArr.count];
}
// 喜欢的专题按钮
-(void)btnLeftClick{
    
    [UIView animateWithDuration:0 animations:^{
        _redLine.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    // 切换cell 内容
    self.isLeftTbView = YES;
    [self reloadTableView:self.leftCellDataArr.count];
    
}
// 点击登录视图
-(void)loginViewClick{
    
    
    self.tableView.editing = !self.tableView.editing;
    
    if (!self.isLogining) {
        // 跳转登录页面
        WJLoginViewController * loginVc = [[WJLoginViewController alloc] init];
        loginVc.delegate = self;// 注意这里要给登录视图代理赋值
        WJNavigationController * nav = [[WJNavigationController alloc] initWithRootViewController:loginVc];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }else{ // 已经登录
    
        // 弹出退出登录alert 提示框
        UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * editAction = [UIAlertAction actionWithTitle:@"编辑资料" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 编辑资料点击事件
            [self editUserInfoActionSheetClick];
        }];
        UIAlertAction * quitAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                // 退出登录点击事件
            self.isLogining = NO;//设置登录状态
            // 切换tableview视图为未登录状态view
            [self addUserTableView]; // 移除tableview视图
                // 注销用户资料
            self.userName.text = @"登录";
            self.iconImg.image = [UIImage imageNamed:@"me_avatar_boy"];
            
            
        }];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 点击取消点击事件
        }];
        
        [alertVc addAction:editAction];
        [alertVc addAction: quitAction];
        [alertVc addAction:cancel];
        /**这句话不能忘记,以模态视图呈现出来*/
        [self presentViewController:alertVc animated:YES completion:nil];
        
    }
   
}
// 点击消息按钮
-(void)msgBtnClick{
    if (!self.isLogining) {
        // 提示登录
        [self loginViewClick];
    }else{
        // push 消息界面
        WJMyMsgViewController * msgVc = [[WJMyMsgViewController alloc] init];
        [self.navigationController pushViewController:msgVc animated:YES];
    }
}
// 点击设置按钮
-(void)settingBtnClick{
    
    WJSettingTableViewController * settingVc = [[WJSettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingVc animated:YES];

}
// 创建编辑视图
-(void)editUserInfoActionSheetClick{

    WJEditUserInfoViewController * editVc = [[WJEditUserInfoViewController alloc] init];
    // 设置代理
    editVc.delegate = self;
    
    WJNavigationController * nav = [[WJNavigationController alloc] initWithRootViewController:editVc];
    // 给编辑页面传值
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.iconImg.image forKey:@"icon"];
    [dic setObject:self.userName.text forKey:@"name"];
    
    WJUserInfo * infoData = [WJUserInfo infoWithDic:dic];
    
    editVc.infoData = infoData;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
// 添加tableview视图
-(void)addUserTableView{

    
    // 设置属性
    if (self.isLogining) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-self.headerView.frame.size.height-44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 123;
        
        [self.view addSubview:_tableView];
    }else{
    // 首先要获取到现在父视图上的tableview子视图
        UIView * subView = [self.view viewWithTag:123];
        [subView removeFromSuperview];//从父视图移除tableview
    }
   

}
#pragma mark -- 实现视图代理方法
// 登录视图代理
-(void)changeUserInfoWithImg:(UIImage *)iconImg addName:(NSString *)name{

    // 更新登录状态
    self.isLogining = YES;
    //更新用户信息
    self.iconImg.image = iconImg;
    self.userName.text = name;
    
    
//    // 首次判断有没有喜欢的数据
//    [self reloadTableView:self.leftCellDataArr.count];
//    [self reloadTableView:self.rightCellDataArr.count];
//    
}
// 编辑视图代理
-(void)changeUserNameValue:(NSString *)userName{

    self.userName.text = userName;
    UserDefaultsSet(userName, @"userName");
}
-(void)changeUserIconimage:(UIImage *)iconImage{

    self.iconImg.image = iconImage;// 注意：不能把自定义对象保存到userDefault中
    
    // 通过NSData来存储图片
    NSData * imageData = UIImagePNGRepresentation(iconImage); // 将图片对象转为图片数据
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString * imagePath = [path stringByAppendingPathComponent:@"iconImage.png"];
    UserDefaultsSet(imagePath, @"imagePath");// 存储图片路径
    [imageData writeToFile:imagePath atomically:YES]; // 写入文件
}
// 切换试题为tableView视图
-(void)presentViewToTabelView{
    //[self btnLeftClick];// 默认先显示喜欢的商品
}


#pragma  mark -- tableView 数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.isLeftTbView) {
        return self.leftCellDataArr.count;
    }else{
    
        return self.rightCellDataArr.count;
    }
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isLeftTbView) {// 喜欢的商品
           NSString * ID = @"cell";

        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        WJGiftData * giftData = self.leftCellDataArr[indexPath.row];
        cell.textLabel.text = giftData.name;
        cell.textLabel.numberOfLines = 0 ;
        NSURL * url = [NSURL URLWithString:giftData.imgStr];
        [cell.imageView sd_setImageWithURL:url];
        return cell;

    }else{// 喜欢的专题
    
        NSString * ID2 = @"cell2";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        }
        WJTabelViewData * cellData = self.rightCellDataArr[indexPath.row];
        cell.textLabel.text = cellData.title;
        cell.textLabel.numberOfLines = 0;// 自动换行
        
        NSURL * imgUrl = [NSURL URLWithString:cellData.imgUrl];
        [cell.imageView sd_setImageWithURL:imgUrl];
        return cell;
    }
    
    
}
#pragma  mark -- tableView 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isLeftTbView) {
        
        WJGiftDetailViewController * detailVc = [[WJGiftDetailViewController alloc] init];
        detailVc.giftData = self.leftCellDataArr[indexPath.row];
        [self.navigationController pushViewController:detailVc animated:YES];
        
    }else{

        WJDetailViewController * detailVc = [[WJDetailViewController alloc] init];
        
        detailVc.detailData = self.rightCellDataArr[indexPath.row];
        [self.navigationController pushViewController:detailVc animated:YES];

    }
}

// cell 滑动删除实现
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.isLeftTbView) {//1.先删除数组里的数据
            [self.leftCellDataArr removeObjectAtIndex:indexPath.row];
        }else{
        
            [self.rightCellDataArr removeObjectAtIndex:indexPath.row];
        }
        // 2.再删除cell的数据行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

// cell 实现长按排序

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    
    if (self.isLeftTbView) {
        // 1、取出要移动的数据
        id sourceData = self.leftCellDataArr[sourceIndexPath.row];
        // 2、先从数组中删除
        [self.leftCellDataArr removeObject:sourceData];
        // 3、 然后添加到新的位置
        [self.leftCellDataArr insertObject:sourceData atIndex:destinationIndexPath.row];
        
    }else{
    
        // 1、取出要移动的数据
        id sourceData = self.rightCellDataArr[sourceIndexPath.row];
        // 2、先从数组中删除
        [self.rightCellDataArr removeObject:sourceData];
        // 3、 然后添加到新的位置
        [self.rightCellDataArr insertObject:sourceData atIndex:destinationIndexPath.row];

    }
    
}
@end
