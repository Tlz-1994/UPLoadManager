//
//  ViewController2.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "ViewController2.h"

#import "ViewController3.h"

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"页面2";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController3 *vc = [[ViewController3 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
