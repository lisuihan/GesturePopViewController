//
//  ViewController.m
//  Demo
//
//  Created by 龙链 on 2018/6/1.
//  Copyright © 2018年 cn.com.lichong. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) CAGradientLayer *createLayer;
@property (nonatomic,strong) UIView *backView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 170, 170)];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}


-(CAGradientLayer *)createLayer{
    
    CAGradientLayer * _layer;
    _layer = [CAGradientLayer layer];
    _layer.startPoint = CGPointMake(0, 0);
    _layer.endPoint   = CGPointMake(0, 1);
    _layer.locations  = @[@(0), @(0.03), @(0.1),@(0.9),@(0.97),@(1.0)];
    _layer.colors = @[(__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor,
                      (__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
                      (__bridge id)[UIColor colorWithWhite:0 alpha:1].CGColor,
                      (__bridge id)[UIColor colorWithWhite:0 alpha:1].CGColor,
                      (__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
                      (__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    
    
    [_layer setFrame:CGRectMake(0, 0,170,170)];
    return _layer;
}

-(void)clickButton:(UIButton *)sender
{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
