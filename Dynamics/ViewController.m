//
//  ViewController.m
//  Dynamics
//
//  Created by ZYJY on 16/11/30.
//  Copyright © 2016年 com.ZYJS. All rights reserved.
//

#import "ViewController.h"
#import "JXDynamics.h"

@interface ViewController ()
{
    UIDynamicAnimator    *_animator;      //物理仿真器
    UIGravityBehavior       *_gravity;         //重力行为
    UICollisionBehavior     *_collision;       //碰撞行为
    UIPushBehavior * _pushBehavior;
    UIView                        *_view;             //模拟运动的视图对象
}

@property (nonatomic,strong) UIView * aView;
@property (nonatomic,strong) UIView * squareView;
@property (nonatomic,strong) UIDynamicAnimator * animator;
@property (nonatomic,strong) UIAttachmentBehavior * attachmentBehavior;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*******动力学*******/
    _aView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    
    _aView.backgroundColor = [UIColor lightGrayColor];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleAttachmentGesture:)];
    [_aView addGestureRecognizer:pan];
    [self.view addSubview:_aView];
    
    UIDynamicAnimator * animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UICollisionBehavior * collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.aView]];
    
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    UIGravityBehavior *g = [[UIGravityBehavior alloc] initWithItems:@[self.aView]];
    [animator addBehavior:g];
    
    _aView.transform = CGAffineTransformRotate(_aView.transform, 45);
    self.animator = animator;
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_view];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_view]];    //让_view对象参与重力行为运动
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_view]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;         //边界检测
    [_animator addBehavior:_collision];
    
    JXDynamics *dy = [[JXDynamics alloc] initWithFrame:CGRectMake(110, 200, 50, 50)];
    [self.view addSubview:dy];
    [dy setUpWithAnchor:CGPointMake(100, 100) inView:self.view];
    
    //Change line property
    [dy setLineLength:30.f];
    [dy setLineColor:[UIColor purpleColor]];
    
    //Add some subview
    UILabel *label = [[UILabel alloc] initWithFrame:dy.bounds];
    label.text = @"Hello";
    label.textAlignment = NSTextAlignmentCenter;
    [dy addSubview:label];
    
    //click Block
    dy.tapBlock = ^{
        NSLog(@"tap!");
    };
    


}
-(void)handleAttachmentGesture:(UIPanGestureRecognizer*)gesture
{
    [_gravity addItem:_aView];
    
    //添加碰撞行为
    [_collision addItem:_aView];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取点击点的坐标
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //初始化一个视图参与运动，颜色随机
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //view.text = @"哈";
    view.center = point;
    CGFloat red = arc4random()% 200 + 55;
    CGFloat green = arc4random()% 200 + 55;
    CGFloat blue = arc4random()% 200 + 55;
    view.textColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    view.layer.cornerRadius = 10;
    
    [self.view addSubview:view];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[self arc4random]];
        view.userInteractionEnabled = YES;
    view.attributedText = text;
    
    //添加重力行为
    [_gravity addItem:view];
    
    //添加碰撞行为
    [_collision addItem:view];
    
    [_pushBehavior addItem:view];
    
}
- (NSString *)arc4random
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
    
    NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
    
    NSInteger number = (randomH<<8)+randomL;
    NSData *data = [NSData dataWithBytes:&number length:2];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    
    return string;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
