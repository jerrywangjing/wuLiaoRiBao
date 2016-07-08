//
//  AppDelegate.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/22.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "LCTabBarController.h"
#import "WJHomeViewController.h"
#import "WJGiftCollectionViewController.h"
#import "WJCategoryCollectionViewController.h"
#import "WJMeViewController.h"
#import "WJNavigationController.h"
// 社会化分享相关
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建一个window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 显示屏幕
    [self.window makeKeyAndVisible];
    
    //Home表视图控制器
    WJHomeViewController * homeVC = [[WJHomeViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor whiteColor];
    //homeVC.tabBarItem.badgeValue = @"10";
    homeVC.title = @"无聊日报";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"TabBar_home~iphone"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar_home_selected~iphone"];
    
    // gift 视图控制器
    WJGiftCollectionViewController * giftVC = [[WJGiftCollectionViewController alloc] init];
    giftVC.view.backgroundColor = [UIColor whiteColor];
    giftVC.title = @"单品";
    giftVC.tabBarItem.image = [UIImage imageNamed:@"TabBar_gift~iphone"];
    giftVC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar_gift_selected~iphone"];
    
    // category 视图控制器
    WJCategoryCollectionViewController * categoryVC = [[WJCategoryCollectionViewController alloc] init];
    categoryVC.view.backgroundColor = [UIColor whiteColor];
    //gift.tabBarItem.badgeValue = @"10";
    categoryVC.title = @"分类";
    categoryVC.tabBarItem.image = [UIImage imageNamed:@"TabBar_category~iphone"];
    categoryVC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar_category_Selected~iphone"];
    
    // me 视图控制器
    WJMeViewController * meVC = [[WJMeViewController alloc] init];
    meVC.view.backgroundColor = [UIColor whiteColor];
    meVC.title = @"我";
    meVC.tabBarItem.image = [UIImage imageNamed:@"TabBar_me_boy~iphone"];
    meVC.tabBarItem.selectedImage = [UIImage imageNamed:@"TabBar_me_boy_selected~iphone"];
    
    // 把以上视图初始化为nav导航控制器的根视图
    WJNavigationController * navVCHome = [[WJNavigationController alloc] initWithRootViewController:homeVC];
    WJNavigationController * navVCGift = [[WJNavigationController alloc] initWithRootViewController:giftVC];
    WJNavigationController * navVCCategory = [[WJNavigationController alloc] initWithRootViewController:categoryVC];
    WJNavigationController * navVCMe = [[WJNavigationController alloc] initWithRootViewController:meVC];
    
    // 创建TabBar控制器
    LCTabBarController * tabBarVC = [[LCTabBarController alloc] init];
    tabBarVC.viewControllers = @[navVCHome,navVCGift,navVCCategory,navVCMe];

    self.window.rootViewController = tabBarVC;
    

    
    /**
     *  友盟社会化分享注册
     */
    [UMSocialData setAppKey:@"571f7bcce0f55ad4a9003503"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
//    [UMSocialSinaSSOHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
////    //打开腾讯微博SSO开关，设置回调地址,需要 #import "UMSocialTencentWeiboHandler.h"
//    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    

    return YES;
}

// 接收到内存报警时处理方式
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{

    //整个程序内存警报时候
    SDWebImageManager *mgr = [SDWebImageManager sharedManager] ;
    //1,取消下载
    [mgr cancelAll];
    //2，清除内存中的所有图片
    [mgr.imageCache clearMemory];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
