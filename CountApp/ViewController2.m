//
//  ViewController2.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "ViewController2.h"

#import "ViewController3.h"

#import <LocalAuthentication/LocalAuthentication.h>

#import "ReactiveCocoa.h"

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"页面2";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onclickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    textField.backgroundColor = [UIColor blueColor];
    [self.view addSubview:textField];
    
    NSArray *arr = @[@"fuc", @"fuck", @"dd"];
    
    [[[textField.rac_textSignal
       map:^id(NSString *text) {
           return text;
       }]
      filter:^BOOL(NSString *text) {
          for (NSString *str in arr) {
              if ([text containsString:str]) {
                  text = [text stringByReplacingOccurrencesOfString:str withString:@"***"];
                  textField.text = text;
                  textField.backgroundColor = [UIColor redColor];
                  return NO;
              }
          }
          return YES;
      }]
     subscribeNext:^(NSString *text) {
         if (text.length < textField.text.length) {
             textField.backgroundColor = [UIColor redColor];
         }
     }];
    
}

- (IBAction)onclickButton:(id)sender {
    //新建LAContext实例
    LAContext  *authenticationContext= [[LAContext alloc]init];
    NSError *error;
    //1:检查Touch ID 是否可用
    if ([authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"touchId 可用");
        //2:执行认证策略
        [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"需要验证您的指纹来确认您的身份信息" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"通过了Touch Id指纹验证");
            }else{
                NSLog(@"error===%@",error);
                NSLog(@"code====%ld",error.code);
                NSLog(@"errorStr ======%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
                if (error.code == -2) {//点击了取消按钮
                    NSLog(@"点击了取消按钮");
                }else if (error.code == -3){//点输入密码按钮
                    NSLog(@"点输入密码按钮");
                }else if (error.code == -1){//连续三次指纹识别错误
                    NSLog(@"连续三次指纹识别错误");
                }else if (error.code == -4){//按下电源键
                    NSLog(@"按下电源键");
                }else if (error.code == -8){//Touch ID功能被锁定，下一次需要输入系统密码
                    NSLog(@"Touch ID功能被锁定，下一次需要输入系统密码");
                }
                NSLog(@"未通过Touch Id指纹验证");
            }
        }];
    }else{
        //todo goto 输入密码页面
        NSLog(@"error====%@",error);
        NSLog(@"抱歉，touchId 不可用");
    }
    
    ViewController3 *vc = [[ViewController3 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController3 *vc = [[ViewController3 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
