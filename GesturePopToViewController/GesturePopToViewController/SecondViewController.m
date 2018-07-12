//
//  SecondViewController.m
//  Demo
//
//  Created by 龙链 on 2018/6/11.
//  Copyright © 2018年 cn.com.lichong. All rights reserved.
//

#import "SecondViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ThireeViewController.h"

@interface SecondViewController ()<UINavigationControllerDelegate>


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;

    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 170, 170)];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


-(void)clickButton:(UIButton *)sender
{
    ThireeViewController *vc = [[ThireeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)dealloc{
    
    
    NSLog(@"====");
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
