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

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *userName;
    UITextField *userPwd;
    NSString *nameStr;
    NSString *pwdStr;
    
    NSArray *arr;
    NSMutableDictionary *reData;
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
    
    for (int i = 0; i<2; i++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(160/2, 64+100 + 60*i, [UIScreen mainScreen].bounds.size.width-160, 40)];
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
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(120, 64+200+50, [UIScreen mainScreen].bounds.size.width-240, 40);
    loginButton.backgroundColor = [UIColor greenColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.tag = 20;
    
    [self.view addSubview:loginButton];
    
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
    
   
        if (userName) {
                if (pwdStr) {
                    [self loginRequestData];
                }else{
                   
                }
            }else{
                
            }
    
}

// 登录请求
- (void)loginRequestData{
    
    NSString *url = @"http://219.151.12.30:8081/admin/webapi/Handler.ashx?flag=denglu";
    
    NSDictionary *parmeters = @{@"phone":nameStr,@"user_password":pwdStr};
    
    [TheAFNetWorking postHttpsURL:url parameters:parmeters AndSuccess:^(NSArray *dic) {
        
    } orfailure:^{
        
    } showHUD:YES];
    
//    AFHTTPRequestOperationManager *httpmanager = [AFHTTPRequestOperationManager manager];
//    httpmanager.requestSerializer = [AFJSONRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer = [AFJSONResponseSerializer new];
//    httpmanager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    httpmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    httpmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [httpmanager POST:url parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//       
//        arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        reData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"reData%@",reData);
//        
//         NSLog(@"登录成功%@",arr);
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:reData[@"first_Invitation_code"] forKey:@"first_Invitation_code"];
//        [userDefaults setObject:reData[@"Second_Invitation_code"] forKey:@"Second_Invitation_code"];
//        [userDefaults setObject:reData[@"user_full_name"] forKey:@"user_full_name"];
//        [userDefaults setObject:reData[@"user_id"] forKey:@"user_id"];
//        [userDefaults setObject:reData[@"types"] forKey:@"types"];
//        
//        [userDefaults synchronize];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",nameStr);
//        NSLog(@"%@",pwdStr);
//        NSLog(@"登录失败%@",error);
//        
//    }];
    
//    [httpmanager GET:url parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"登录成功%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"登录失败%@",error);
//    }];
    
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
