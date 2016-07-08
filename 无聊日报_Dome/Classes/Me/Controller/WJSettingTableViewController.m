//
//  WJSettingTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/7.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJSettingTableViewController.h"
#import "WJSettingData.h"
#import "WJFeedbackViewController.h"
#import "WJAboutViewController.h"
#import "WJMyInfoTableViewController.h"
#import "NSString+WJExtension.h"

#define CELL_HEIGHT 40
#define CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface WJSettingTableViewController ()// 类扩展，为类添加私有属性
/**
 * 文档注释： cell 数据
 */
@property (nonatomic,strong) NSArray * cellDataArr;

@property (nonatomic,weak) UILabel * myMsg;


/**
 *  缓存
 */
@property (nonatomic,strong) UILabel * totleCache;
@property (nonatomic,assign) double  totleCacheSize;

@end

@implementation WJSettingTableViewController

-(UILabel *)totleCache{

    if (!_totleCache) {
        _totleCache = [[UILabel alloc] init];
    }
    return _totleCache;
}
-(NSArray *)cellDataArr{

    NSString * path = [[NSBundle mainBundle] pathForResource:@"settingData" ofType:@"plist"];
    NSArray * sectionArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * tempArr = [NSMutableArray array];
    for (NSArray * arr in sectionArr) {
        
        NSMutableArray * dicArr = [NSMutableArray array];//存放根字典数组
        for (NSDictionary * dic in arr) {
            WJSettingData * data = [WJSettingData settingDataWithDic:dic];
            [dicArr addObject:data];
        }
        
        [tempArr addObject:dicArr];
    }
    return tempArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    /**注意：设置section的footer高度执行此方法有效*/
    self.tableView.sectionFooterHeight = 0;
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:@"role" object:nil];
    // 显示缓存大小

    self.totleCache.text =  [self calculateCacheSize];
    NSLog(@"%@,%s",_totleCache.text,__func__);
    
    // 写plist 文件
    [self plistCreat];
    
}
/**
 *  计算缓存大小
 */
-(NSString *)calculateCacheSize{

    // 计算缓存大小
    
    //        // 获取沙盒路径
    //    NSString * homePath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
//    int bytesCache =(int)[SDImageCache sharedImageCache].getSize;
    
    // 获取缓存文件夹路径
    //NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 计算缓存大小
    NSInteger cacheSizeByte = [CACHE_PATH calculateFileSize];//使用分类
    // 转换为M单位
    double cacheSize = cacheSizeByte/1000.0/1000.0;//这里注意精度 精确到.1f
    _totleCacheSize = cacheSize;  // 给缓存大小属性赋值
    NSString * cacheStr = [NSString stringWithFormat:@"%.1fM",cacheSize];

    return cacheStr;
}

-(void)valueChanged:(NSNotification *)noti{

    [self.tableView reloadData];// 数据已存储到偏好设置中，这里只需要更新数据
    
}
-(void)plistCreat{

    NSMutableArray * arr = [NSMutableArray array];
    
    NSMutableArray * dicArr = [NSMutableArray array];
    NSMutableDictionary * dic01 = [NSMutableDictionary dictionary];
    
    [dic01 setObject:@"more_icon_share~iphone" forKey:@"image"];
    [dic01 setObject:@"邀请好友使用无聊日报" forKey:@"title"];
    NSMutableDictionary * dic02 = [NSMutableDictionary dictionary];
    [dic02 setObject:@"more_icon_score~iphone" forKey:@"image"];
    [dic02 setObject:@"给我们评分吧" forKey:@"title"];
    NSMutableDictionary * dic03 = [NSMutableDictionary dictionary];
    [dic03 setObject:@"more_icon_feedback~iphone" forKey:@"image"];
    [dic03 setObject:@"意见反馈" forKey:@"title"];
    [dicArr addObject:dic01];
    [dicArr addObject:dic02];
    [dicArr addObject:dic03];
    
    NSMutableArray * dicArr1 = [NSMutableArray array];
    
    NSMutableDictionary * dic11 = [NSMutableDictionary dictionary];
    
    [dic11 setObject:@"checkUserType_icon_identity~iphone" forKey:@"image"];
    [dic11 setObject:@"我的身份" forKey:@"title"];
    NSMutableDictionary * dic12 = [NSMutableDictionary dictionary];
    [dic12 setObject:@"more_icon_notification~iphone" forKey:@"image"];
    [dic12 setObject:@"接收消息提醒" forKey:@"title"];
    NSMutableDictionary * dic13 = [NSMutableDictionary dictionary];
    [dic13 setObject:@"more_icon_clear~iphone" forKey:@"image"];
    [dic13 setObject:@"清除缓存" forKey:@"title"];
    [dicArr1 addObject:dic11];
    [dicArr1 addObject:dic12];
    [dicArr1 addObject:dic13];
    
    NSMutableArray * dicArr2 = [NSMutableArray array];
    NSMutableDictionary * dic20 = [NSMutableDictionary dictionary];
    
    [dic20 setObject:@"more_icon_about~iphone" forKey:@"image"];
    [dic20 setObject:@"关于无聊日报" forKey:@"title"];
    [dicArr2 addObject:dic20];
    
    [arr addObject:dicArr];
    [arr addObject:dicArr1];
    [arr addObject:dicArr2];
    
    //写入plist文件
    NSString * path = @"/Users/JerryWang/Desktop";
    NSString * filePath = [path stringByAppendingPathComponent:@"settingData.plist"];
    
    [arr writeToFile:filePath atomically:YES];
    
}
//**注意：由于主视图隐藏了导航栏，push出来的子视图也将会会隐藏，所以需要在子视图中关闭隐藏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cellDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cellDataArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * ID = @"cell";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            // 创建label
            
            CGFloat labelW = 110;
            CGFloat labelH = 20;
            CGFloat labelX = SCREEN_WIDTH - (labelW +30);
            CGFloat labelY = (CELL_HEIGHT - labelH)/2;
            
            UILabel * myMsg = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
            myMsg.font = [UIFont systemFontOfSize:13];
            myMsg.textColor = LCColorForTabBar(150, 150, 150);
            myMsg.textAlignment = NSTextAlignmentRight;
            
            _myMsg = myMsg;
            [cell addSubview:_myMsg];
            
            
        }else if(indexPath.section == 1 && indexPath.row == 2){
        
            // 添加缓存数据大小label
            CGFloat margin = 20;
            CGFloat cacheW = 50;
            CGFloat cacheH = 20;
            CGFloat cacheX = SCREEN_WIDTH - (margin +cacheW);
            CGFloat cacheY = (CELL_HEIGHT - cacheH)/2;

            self.totleCache.frame = CGRectMake(cacheX, cacheY, cacheW, cacheH);
            self.totleCache.font = [UIFont systemFontOfSize:14];
            self.totleCache.textAlignment = NSTextAlignmentRight;
            [cell addSubview:self.totleCache];
            NSLog(@"cell = %@",_totleCache);
        }
        
    }
    // 转为模型
    NSArray * rowArr = self.cellDataArr[indexPath.section];
    
    WJSettingData * data = rowArr[indexPath.row];

    cell.imageView.image = [UIImage imageNamed:data.imgStr];
    cell.textLabel.text = data.title;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
   
    if ([data.title isEqualToString:@"意见反馈"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if ([data.title isEqualToString:@"我的身份"]){
        NSString * currentRole = [defaults objectForKey:@"currentRole"];
        NSString * currentSex = [defaults objectForKey:@"currentSex"];

        self.myMsg.text = [NSString stringWithFormat:@"%@ %@",currentSex,currentRole];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if ([data.title isEqualToString:@"接收消息提醒"]){
    
        UISwitch * swh = [[UISwitch alloc] init];

        [swh addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
        swh.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"接收消息提醒"]; // 获取开关状态
        cell.accessoryView = swh;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if([data.title isEqualToString:@"关于无聊日报"]){
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

// 创建我的身份cell上的label标签
-(UILabel *)creatCellLabels:(NSString *)name{

    CGFloat labelW = 70;
    CGFloat labelH = 20;
    CGFloat labelX;
    if ([name isEqualToString:@"sex"]) {
        labelX = SCREEN_WIDTH - (labelW *2 +40);
    }else{
    
        labelX = SCREEN_WIDTH - (labelW +30);
    }
    
    CGFloat labelY = (CELL_HEIGHT - labelH)/2;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = LCColorForTabBar(120, 120, 120);
    label.textAlignment = NSTextAlignmentRight;
    
    return label;
}
-(void)switchValueChange:(UISwitch *)swh{

    // 监听switch 变化 保存到用户偏好设置中
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:swh.isOn forKey:@"接收消息提醒"];
    [defaults synchronize];
    
}
#pragma mark - 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return CELL_HEIGHT;
}
// 设置组间距
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{/**注意：设置section的header高度需要用此方法*/

    return 20;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{/**注意：此方法对设置section的footer高度无效*/
//
//    return 0;
//}
// cell 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {// 第一组
        if (indexPath.row == 0) {
            //邀请好友分享
        }else if (indexPath.row == 1){
        
            //评分
            NSString * path = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=xxxxxx"];// 需要app id
                // 跳转到应用对应的AppStore
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        }else{
        
            // 意见反馈
            WJFeedbackViewController * feedback = [[WJFeedbackViewController alloc] init];
            [self.navigationController pushViewController: feedback animated:YES];
        }
    
    }else if (indexPath.section == 1){ // 第二组
    
        if (indexPath.row == 0) {
            // 我的身份
            WJMyInfoTableViewController * myInfo = [[WJMyInfoTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:myInfo animated:YES];
        }else if (indexPath.row == 2){
        
            if (self.totleCacheSize != 0.0f) {
                //清除缓存
                [MBProgressHUD showMessage:@"正在清除"];
                // 清理
                NSFileManager * mgr = [NSFileManager defaultManager];
                NSError * error = [[NSError alloc] init];
                BOOL didRemove = [mgr removeItemAtPath:CACHE_PATH error:&error];// 删除cache文件下的所有文件
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                    if (didRemove) {
                        [MBProgressHUD showSuccess:@"清除完成"];
                        // 更新缓存数据
                        self.totleCache.text = [self calculateCacheSize];
                    }else{
                        NSLog(@"error-%@",error);
                        [MBProgressHUD showError:@"清除失败"];
                    }
                    
                });

            }else{
            
                [MBProgressHUD showLabel:@"缓存已清空"];
            }
        }
    }else{// 第三组
    
        // 关于无聊日报
        WJAboutViewController * about = [[WJAboutViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }

}

@end
