//
//  RegisterViewController.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/11.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "RegisterViewController.h"
#import "TheAFNetWorking.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createView];
   
}

- (void)createView{
    NSArray *labelArray = @[@"账号：",@"密码：",@"确认密码："];
    NSArray *textArray1 = @[@"请输入账号",@"请输入密码",@"再次输入密码"];
    for (int i = 0; i < 3; i++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/5, kScteenHeight/10+kScteenHeight/6 + kScteenHeight/9.6*i, [UIScreen mainScreen].bounds.size.width-kScreenWidth/5*2, kScteenHeight/15)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.tag = 10+i;
        textField.delegate = self;
        textField.layer.cornerRadius = 2;
        textField.layer.masksToBounds = YES;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 60)];
        label.textColor = [UIColor blackColor];
        label.text = labelArray[i];
        label.font = [UIFont boldSystemFontOfSize:15.f];
        textField.leftView = label;
        textField.placeholder = textArray1[i];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.keyboardType = UIKeyModifierCommand;
        if (textField.tag == 11) {
            textField.secureTextEntry = YES;
        }if (textField.tag == 12) {
            textField.secureTextEntry = YES;
        }
        [self.view addSubview:textField];
        
    }
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(kScreenWidth/3, kScteenHeight/1.7, [UIScreen mainScreen].bounds.size.width-kScreenWidth/3*2, kScteenHeight/15);
    loginButton.backgroundColor = [UIColor greenColor];
    [loginButton setTitle:@"确定" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.tag = 20;
    
    [self.view addSubview:loginButton];
    
}


- (void)action:(UIButton *)sender{
    NSString *url = @"admin/webapi/Handler.ashx?flag=denglu";
    
    NSDictionary *parmeters = @{@"phone":@"",@"user_password":@""};
    
    [TheAFNetWorking postHttpsURL:url parameters:parmeters AndSuccess:^(NSArray *dic) {
        
    } orfailure:^{
        
    } showHUD:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
