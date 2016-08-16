//
//  LoginViewController.m
//  享见1.0
//
//  Created by 勇 舒 on 16/7/27.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "LoginViewController.h"
//#import "AFNetworking.h"
#import "TheAFNetWorking.h"
#import <SDAutoLayout.h>
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *userName;
    UITextField *userPwd;
    NSString *nameStr;
    NSString *pwdStr;
    
    NSArray *arr;
    NSMutableDictionary *reData;
    
    UITextField *textField1;
    UITextField *textField2;
    
    UIButton *button1;
    UIButton *button2;
    
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createView];
}

- (void)createView{

    NSArray *textArray1 = @[@"请输入账号",@"请输入密码"];
    NSArray *labelArray = @[@"账号:",@"密码:"];
    NSArray *buttonArray = @[@"登录",@"注册"];
    for (int i = 0; i<2; i++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/5, kScteenHeight/10+kScteenHeight/6 + kScteenHeight/9.6*i, [UIScreen mainScreen].bounds.size.width-kScreenWidth/5*2, kScteenHeight/15)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.tag = 10+i;
        textField.delegate = self;
        textField.layer.cornerRadius = 2;
        textField.layer.masksToBounds = YES;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, 60)];
        label.textColor = [UIColor blackColor];
        label.text = labelArray[i];
        textField.leftView = label;
        textField.placeholder = textArray1[i];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.keyboardType = UIKeyModifierCommand;
        if (textField.tag == 11) {
            textField.secureTextEntry = YES;
        }
        [self.view addSubview:textField];
        
    }
    
    
    for (int i = 0; i < 2; i++) {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame = CGRectMake(kScreenWidth/3, kScteenHeight/2.1 + kScteenHeight/10*i, [UIScreen mainScreen].bounds.size.width-kScreenWidth/3*2, kScteenHeight/15);
        loginButton.backgroundColor = [UIColor greenColor];
        [loginButton setTitle:buttonArray[i] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        loginButton.tag = 20+i;
        
        [self.view addSubview:loginButton];
    }
//    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginButton.frame = CGRectMake(kScreenWidth/3, kScteenHeight/2.1, [UIScreen mainScreen].bounds.size.width-kScreenWidth/3*2, kScteenHeight/15);
//    loginButton.backgroundColor = [UIColor greenColor];
//    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    [loginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//    loginButton.tag = 20;
//    
//    [self.view addSubview:loginButton];
    
//    保存用户输入的 用户名和密码
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    userName = [self.view viewWithTag:10];
    userPwd = [self.view viewWithTag:11];
    
    userName.text = [UserDefaults objectForKey:@"user_name"];
    userPwd.text = [UserDefaults objectForKey:@"user_pwd"];
    
    
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 10) {
        nameStr = textField.text;
    }if (textField.tag == 11) {
        pwdStr = textField.text;
    }
}

- (void)action:(UIButton *)sender{
    
   
    
    switch (sender.tag) {
        case 20:
            if (userName) {
                if (pwdStr) {
                    [self loginRequestData];
                }else{
                    
                }
            }else{
                
            }
            break;
        
        case 21:
        {
            RegisterViewController *registeView = [[RegisterViewController alloc]init];;
            [self.navigationController pushViewController:registeView animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

// 登录请求
- (void)loginRequestData{
    
    NSString *url = @"admin/webapi/Handler.ashx?flag=denglu";
    
    NSDictionary *parmeters = @{@"phone":nameStr,@"user_password":pwdStr};
    
    [TheAFNetWorking postHttpsURL:url parameters:parmeters AndSuccess:^(NSArray *dic) {
        
    } orfailure:^{
        
    } showHUD:YES];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
