//
//  SSfirstVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSfirstVC.h"
#import "ViewController.h"
#import "SSBtnsListView.h"
#import "SSwebBaseVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SSfirstVC ()<SSViewControllerDelegate>
@property(nonatomic,strong) SSBtnsListView* btnsListV;
@property(nonatomic,strong) UILabel* valueLab;
@end

@implementation SSfirstVC
- (SSBtnsListView *)btnsListV {
    if (!_btnsListV) {
        _btnsListV = [[SSBtnsListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ssscale(44))];
        _btnsListV.titleArray = @[@"123",@"234",@"345",@"456"];
        _btnsListV.sliderWidth = ssscale(30);
    }
    return _btnsListV;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.hidden == NO) {
//        self.navigationController.navigationBar.hidden = YES;
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.btnsListV];
    weakly(self);
    self.btnsListV.selectedBlock = ^(NSInteger index) {
        [weakSelf webVC];
    };
    NSDictionary* dic = @{@"age":@(20),@"name":@"zangsan",@"sex":@(1)};
    [SShelper SSautoPropertyWith:dic];
    
    self.valueLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btnsListV.frame), ScreenWidth, 40)];
    self.valueLab.backgroundColor = [UIColor lightGrayColor];
    self.valueLab.textAlignment = NSTextAlignmentCenter;
    self.valueLab.textColor = [UIColor redColor];
    self.valueLab.font = [UIFont SSCustomFont:18];
    [self.view addSubview:self.valueLab];
    
    UIButton* btn = [SShelper SSbutton:UIButtonTypeCustom title:@"1234" titleColor:[UIColor SSmoneyColor] font:[UIFont SSCustomFont16] bgImgStr:nil];
    btn.frame = CGRectMake(0, 200, 80, 40);
    [self.view addSubview:btn];
}

- (void)webVC {
//    SSwebBaseVC* web = [[SSwebBaseVC alloc]init];
//    web.urlString = @"https://www.baidu.com";
//    web.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:web animated:YES];
    
    ViewController* vc = [[ViewController alloc] init];
//    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getValueStr:(NSString *)str {
    self.valueLab.text = str;
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
