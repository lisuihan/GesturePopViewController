//
//  ThireeViewController.m
//  Demo
//
//  Created by 龙链 on 2018/7/5.
//  Copyright © 2018年 cn.com.lichong. All rights reserved.
//

#import "ThireeViewController.h"
#import "ViewController.h"
#import "LCPOPAnimation.h"

@interface ThireeViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *tempArray;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation ThireeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationController.delegate = self;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 170, 170)];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    self.tempArray = [NSMutableArray array];
    [_tempArray addObjectsFromArray:self.navigationController.viewControllers];
    
    UIPanGestureRecognizer *pag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    [self.view addGestureRecognizer:pag];
    // Do any additional setup after loading the view.
}

-(void)clickButton:(UIButton *)sender
{
    
}

-(void)panClick:(UIPanGestureRecognizer *)recognizer
{
    
    if(self.navigationController.childViewControllers.count == 1)
    {
        return;
    }
    // _interactiveTransition就是代理方法2返回的交互对象，我们需要更新它的进度来控制POP动画的流程。（以手指在视图中的位置与屏幕宽度的比例作为进度）
    CGFloat process = [recognizer translationInView:self.view].x/self.view.bounds.size.width;
    process = MIN(1.0, MAX(0.0, process));
    
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        // 此时，创建一个UIPercentDrivenInteractiveTransition交互对象，来控制整个过程中动画的状态
            UIViewController *vc = nil;
            for (UIViewController *tempVC in self.navigationController.viewControllers) {
                if ([tempVC isKindOfClass:[ViewController class]]) {
                    vc = tempVC;
                    break;
                }
            }
        
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popToViewController:vc animated:YES];
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        [_interactiveTransition updateInteractiveTransition:process]; // 更新手势完成度
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded ||recognizer.state == UIGestureRecognizerStateCancelled)
    {
        // 手势结束时，若进度大于0.5就完成pop动画，否则取消
        if(process > 0.5)
        {
            [_interactiveTransition finishInteractiveTransition];
        }
        else
        {
            [_interactiveTransition cancelInteractiveTransition];
            
        }
        
        _interactiveTransition = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setViewControllers:_tempArray animated:NO];
    NSLog(@"%@",self.navigationController.viewControllers);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         NSLog(@"%@",self.navigationController.viewControllers);
    });
    
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[LCPOPAnimation alloc] init];
    }
    return nil;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[LCPOPAnimation class]]) {
        return _interactiveTransition;
    }
    return nil;
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
}

-(void)dealloc
{

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
