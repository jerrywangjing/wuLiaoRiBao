//
//  WJEditUserInfoViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/10.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJEditUserInfoViewController.h"
#import "WJUserInfo.h"

@interface WJEditUserInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

// 头像
@property (nonatomic,weak)  UITextField * editTextField;
// 存储选择后的照片
@property (nonatomic,weak) UIImage * selectedImage;

@end

@implementation WJEditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑资料";
    self.view.backgroundColor = LCColorForTabBar(245, 245, 245);
    // 添加view
    [self addSubViews];
    [self addNavBarItems];
    
}
#pragma mark -- 添加子视图
-(void)addSubViews{

    CGFloat iconWH = 70;
    // 创建头像view
    UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -iconWH)/2, 30, iconWH, iconWH)];
    _iconImg = iconImg;
    iconImg.image = self.iconImg.image;
    // 给头像设置圆角
    _iconImg.layer.cornerRadius = 35;
    _iconImg.layer.masksToBounds = YES;
    _iconImg.userInteractionEnabled = YES;
    _iconImg.image = self.infoData.icon;
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
    [_iconImg addGestureRecognizer:gesture];
    
    // 创建根textFieldView
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(iconImg.frame) +20, SCREEN_WIDTH+2, 40)];
    bgView.layer.borderWidth = 1; // 边框线条宽度
    bgView.layer.borderColor = LCColorForTabBar(200, 200,200).CGColor;
    bgView.backgroundColor = [UIColor whiteColor];
    // 昵称标题
    CGFloat nameY = (bgView.frame.size.height - 20)/2;
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(15,nameY, 40, 20)];
    name = name;
    name.text = @"昵称";
    name.textColor = LCColorForTabBar(200, 200, 200);
    name.font = [UIFont systemFontOfSize:16];
    
    UITextField * textFiled = [[UITextField alloc] initWithFrame:CGRectMake(150, 0, SCREEN_WIDTH-170, 40)];
    _editTextField = textFiled;
    _editTextField.placeholder = @"请设置昵称";
    _editTextField.borderStyle = UITextBorderStyleNone;
    _editTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _editTextField.text = self.infoData.name;
    _editTextField.delegate = self;
    //_editTextField.textAlignment = NSTextAlignmentCenter;
    
    // 添加到父view中
    [bgView addSubview:name];
    [bgView addSubview:_editTextField];
    [self.view addSubview:iconImg];
    [self.view addSubview:bgView];
}


-(void)iconClick:(UIView *)icon{

    
    // 进去手机相册选择照片
        // 设置图片选择控制器资源类型
    // 创建照片选择控制器
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
    
    
    [self selectImageSourceType:picker];  // 设置资源类型并弹出照片选择视图
    
}

// 照片类型选择
-(void)selectImageSourceType:(UIImagePickerController *)picker{

    //给个选择提示
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * fromCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) { // 如果相机可用才跳出相机
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }else{
        
            UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVc addAction:cancel];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
        
       
    }];
    UIAlertAction * fromPhotoLibrary = [UIAlertAction actionWithTitle:@"从照片选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVc addAction:fromCamera];
    [alertVc addAction:fromPhotoLibrary];
    [alertVc addAction:cancel];
    [self presentViewController:alertVc animated:YES completion:nil];
}
-(void)addNavBarItems{

    UIBarButtonItem * cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick)];
    UIBarButtonItem * done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnClick)];
    
    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.rightBarButtonItem = done;
}

#pragma mar -- 照片选择代理方法
// 照片选择完毕后执行

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];//关闭选择视图
    //NSLog(@"info-%@",info);
    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(selectPic:) withObject:image afterDelay:0.1];
    NSLog(@"选择完毕");
}

-(void)selectPic:(UIImage *)image{
    NSLog(@"获取图片");
    // 更新图片
    self.iconImg.image = image;
}
// 选择器取消后执行
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消选择");
}
#pragma mark -- 按钮点击事件方法

-(void)cancelBtnClick{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)doneBtnClick{

    // 给代理发送通知,传递修改后的用户名
    if ([self.delegate respondsToSelector:@selector(changeUserNameValue:)]) {
        
        [self.delegate changeUserNameValue:self.editTextField.text];
        [self.delegate changeUserIconimage:self.iconImg.image];
    }
    [self.editTextField resignFirstResponder];//记得放弃第一响应者身份
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textField delegate 

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.view endEditing:YES];
    return YES;
}
@end
