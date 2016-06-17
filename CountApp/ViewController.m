//
//  ViewController.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "ViewController.h"

#import "ViewController2.h"

#import "JSClick.h"

#import "JSStatisticalDataManager.h"

#import "TableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation ViewController
{
    UITableView *_tabelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"页面1";
    [JSClick starLogService];
    [self initTableView];
}

- (void)initTableView {
    _tabelView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [_tabelView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    [self.view addSubview:_tabelView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
