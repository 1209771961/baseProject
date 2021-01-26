//
//  SSthirdVC.m
//  baseProject
//
//  Created by F S on 2017/1/16.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "SSthirdVC.h"
#import "SSwindowView.h"
#import "SSshowContentView.h"

@interface SSthirdVC ()
@property(nonatomic,strong) UILabel* lab;
@end

@implementation SSthirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 140)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"十分劳务费射流风机\n射流风机违法是";
    self.lab = lab;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 88, 100, 50)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
//    SSshowContentView* show = [[SSshowContentView alloc] init];
//    show.loadingText = @"加载中...";
//    [show SSshowLoadingSSHUD];
    
}

- (void)clickBtn {
    SSshowContentView* show = [[SSshowContentView alloc] init];
    show.backGroundColor = [UIColor whiteColor];
//    show.circleColor = [UIColor greenColor];
    [show SSshowLoadingSSHUD];
    
//    [NSThread sleepForTimeInterval:3];
//    [show SShiddenLoadingSSHUD];
//    [show SShiddenAllLoading];;
    
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
