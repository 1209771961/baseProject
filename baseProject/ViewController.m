//
//  ViewController.m
//  baseProject
//
//  Created by FL S on 2017/7/22.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "ViewController.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SSshowContentView.h"
#import <ReactiveCocoa/RACDynamicSignal.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) UITextField* textFD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textFD = [[UITextField alloc] initWithFrame:CGRectMake(30, 88, 100, 40)];
    self.textFD.placeholder = @"请输入";
    [self.view addSubview:self.textFD];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"确认传值" forState:UIControlStateNormal];
    btn.frame = CGRectMake(30, CGRectGetMaxY(self.textFD.frame)+15, ScreenWidth-2*30, 40);
    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"qwer1234"];
            
            [subscriber sendCompleted];
            return nil;
        }];
        
        return [RACSignal empty];
    }];
//    [btn.rac_command execute:@"1234"];
    
    [[btn.rac_command.executing skip:0] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");

        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
    }];
    
    [btn.rac_command.executionSignals subscribeNext:^(id x) {
//        RACSignal* signa = (RACSignal*)x;
//        RACDynamicSignal* signal = (RACDynamicSignal*)x;
        NSLog(@"------ 信号 = %@",x);
//        NSLog(@"------ 信号 = %@",signal.name);
    }];
    [btn.rac_command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"------ 信号 = %@",x);
    }];
}

- (void)clickBtn {
    [self presentMessageTips:@"qwer1234"];
    SSshowContentView* showMsg = [[SSshowContentView alloc] init];
    [showMsg SSshowMsg:@"qwer1234" FinishBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    if (self.textFD.text.length<=0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(getValueStr:)]) {
        [self.delegate getValueStr:self.textFD.text];
    }
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:self.textFD.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setsubv {
    self.view.backgroundColor = [UIColor whiteColor];
    ///
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 800) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld---- %ld",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

///分区背景色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor redColor];
}
///蛋疼：ios11后更改section颜色必须加上这个方法
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)dealloc {
    NSLog(@"---------销毁------- %s",__func__);
}


@end
