//
//  RegisterViewController.m
//  com.xjlx520.www
//
//  Created by 勇 舒 on 16/8/11.
//  Copyright © 2016年 勇 舒. All rights reserved.
//

#import "RegisterViewController.h"
#import "TheAFNetWorking.h"
#import "YXPMBProgressView.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *tellText;
@property(nonatomic,strong)UITextField *passWorldText;
@property(nonatomic,strong)UITextField *passWorldText2;
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
            _passWorldText = textField;
        }else if (textField.tag == 12) {
            textField.secureTextEntry = YES;
            _passWorldText2 = textField;
        }else{
            _tellText = textField;
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
-(BOOL)isCanRegister{

    if (_tellText.text.length==11&&[_passWorldText.text isEqual:_passWorldText2.text]) {
        return YES;
    }
    
    if (_tellText.text.length!=11) {
        [YXPMBProgressView ProgressHUDText:@"手机号输入错误" andShowTime:2];
        return NO;
    }
    
    if (![_passWorldText.text isEqualToString:_passWorldText2.text]) {
              [YXPMBProgressView ProgressHUDText:@"两次输入的密码不一致" andShowTime:2];
        return NO;
    }
    return NO;
}

- (void)action:(UIButton *)sender{
//    NSString *url =   [TheAFNetWorking  httpURLStr:@"admin/webapi/lx_users.ashx?flag=users_add"];
    if ([self isCanRegister]==YES) {
        [self postRegister];
    }else{
        
    }
    
  }
-(void)postRegister{
    NSString *url = @"http://219.151.12.30:8081/admin/webapi/lx_users.ashx?flag=users_add";
    NSDictionary *dic1 = @{@"user_full_name":_tellText.text,@"user_password":_passWorldText.text,@"user_Age":@"0",@"user_sex":@"0",@"user_Income_range":@"0",@"education":@"0",@"Advertising_interest":@"0",@"phone":@"0",@"user_Invitation_code":@"0",@"lx_region":@"0",@"lx_city":@"0",@"Types":@"0",@"user_address":@"0",@"lx_picture":@"0"};
    NSLog(@"%@",url);
    
    
    [TheAFNetWorking postHttpsURL:url parameters:dic1 AndSuccess:^(NSArray *dic) {
        NSLog(@"%@",dic);
    } orfailure:^{
        
    } showHUD:YES];
}

//监听点击空白收回键盘
-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_tellText resignFirstResponder];
    [_passWorldText resignFirstResponder];
    [_passWorldText2 resignFirstResponder];
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
