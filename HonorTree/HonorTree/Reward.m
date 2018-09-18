//
//  Reward.m
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import "Reward.h"

@interface Reward ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *rewardView;

@end

@implementation Reward

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _backgroundView = [[UIView alloc] initWithFrame:window.bounds];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _backgroundView;
}

- (UIView *)rewardView {
    if (!_rewardView) {
        _rewardView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - [self Suit:316])/2, (ScreenHeight - [self Suit:429])/2, [self Suit:316], [self Suit:429])];
    }
    return _rewardView;
}

- (void)setFruit:(Fruit *)fruit {
    _fruit = fruit;
}

- (void)buildUI {
    UIImageView *rewardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reward"]];
    rewardImage.frame = CGRectMake(0, 0, [self Suit:316], [self Suit:429]);
    rewardImage.userInteractionEnabled = YES;
    [self.rewardView addSubview:rewardImage];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"close_reward"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [rewardImage addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rewardImage.mas_top).offset([self Suit:23]);
        make.right.equalTo(rewardImage.mas_right).offset([self Suit:-11]);
        make.width.height.mas_equalTo([self Suit:25]);
    }];
    
    UIButton *receiveBtn = [[UIButton alloc] init];
    [receiveBtn setTitle:@"立即领取" forState:UIControlStateNormal];
    [receiveBtn setTitleColor:[UIColor colorWithRed:234/255. green:48/255. blue:56/255. alpha:1.0] forState:UIControlStateNormal];
    receiveBtn.backgroundColor = [UIColor colorWithRed:243/255. green:235/255. blue:115/255. alpha:1.0];
    receiveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    receiveBtn.layer.cornerRadius = [self Suit:20];
    receiveBtn.clipsToBounds = YES;
    [receiveBtn addTarget:self action:@selector(clickReceiveButton) forControlEvents:UIControlEventTouchUpInside];
    [rewardImage addSubview:receiveBtn];
    [receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rewardImage.mas_centerX);
        make.bottom.equalTo(rewardImage.mas_bottom).offset([self Suit:-54]);
        make.width.mas_equalTo([self Suit:230]);
        make.height.mas_equalTo([self Suit:40]);
    }];
}

- (void)show {
    //添加
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.rewardView];
    
    //缩放效果
    self.rewardView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    self.rewardView.alpha = 0;
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.rewardView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.rewardView.alpha = 1;
    } completion:nil];
    
    //开始粒子效果
    CAEmitterLayer *emitterLayer = addEmitterLayer(self.backgroundView, self.rewardView);
    startAnimate(emitterLayer);
}

CAEmitterLayer *addEmitterLayer(UIView *view, UIView *window) {
    //粒子
    CAEmitterCell *subCell1 = subCell([UIImage imageNamed:@"yezi"]);
    subCell1.name = @"yezi";
    CAEmitterCell *subCell2 = subCell([UIImage imageNamed:@"yellow_flower"]);
    subCell2.name = @"yellow_flower";
    CAEmitterCell *subCell3 = subCell([UIImage imageNamed:@"siyecao"]);
    subCell3.name = @"siyecao";
    CAEmitterCell *subCell4 = subCell([UIImage imageNamed:@"red_flower"]);
    subCell4.name = @"red_flower";
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = window.center;
    emitterLayer.emitterPosition = window.center;
    emitterLayer.emitterSize = window.bounds.size;
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    emitterLayer.emitterCells = @[subCell1,subCell2,subCell3,subCell4];
    [view.layer addSublayer:emitterLayer];
    
    return emitterLayer;
    
}

void startAnimate(CAEmitterLayer *emitterLayer) {
    CABasicAnimation *redBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yezi.birthRate"];
    redBurst.fromValue        = [NSNumber numberWithFloat:30];
    redBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    redBurst.duration        = 0.5;
    redBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *yellowBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yellow_flower.birthRate"];
    yellowBurst.fromValue        = [NSNumber numberWithFloat:30];
    yellowBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    yellowBurst.duration        = 0.5;
    yellowBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *blueBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.siyecao.birthRate"];
    blueBurst.fromValue        = [NSNumber numberWithFloat:30];
    blueBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    blueBurst.duration        = 0.5;
    blueBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.red_flower.birthRate"];
    starBurst.fromValue        = [NSNumber numberWithFloat:30];
    starBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    starBurst.duration        = 0.5;
    starBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[redBurst,yellowBurst,blueBurst,starBurst];
    
    [emitterLayer addAnimation:group forKey:@"flowersBurst"];
}

CAEmitterCell *subCell(UIImage *image) {
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    //粒子的名字
    cell.name = @"flower";
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents = (__bridge id _Nullable)image.CGImage;
    // 缩放比例
    cell.scale = 0.6;
    //缩放比例范围
    cell.scaleRange = 0.6;
    //表示effectCell的生命周期，既在屏幕上的显示时间要多长
    cell.lifetime = 20;
    //速度
    cell.velocity = 200;
    //速度范围
    cell.velocityRange = 200;
    //粒子y方向的加速度分量
    cell.yAcceleration = 9.8;
    //粒子x方向的加速度分量
    cell.xAcceleration = 0;
    //周围发射角度
    cell.emissionRange = M_PI;
    //缩放比例速度
    cell.scaleSpeed = -0.05;
    //子旋转角度
    cell.spin = 2 * M_PI;
    //子旋转角度范围
    cell.spinRange = 2 * M_PI;
    
    return cell;
}

//点击收取按钮
- (void)clickReceiveButton {
    NSLog(@"tag = %ld", self.fruit.tag - 10000);
    [UIView animateWithDuration:0.4 animations:^{
        self.rewardView.transform = CGAffineTransformMakeScale(.3f, .3f);
        self.rewardView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.fruit dismiss];
        if (self.fruit.finishCollectFruitBlock) {
            self.fruit.finishCollectFruitBlock(self.fruit.tag - 10000);
        }
    }];
}

//点击关闭按钮
- (void)clickCloseButton {
    [UIView animateWithDuration:0.4 animations:^{
        self.rewardView.transform = CGAffineTransformMakeScale(.3f, .3f);
        self.rewardView.alpha = 0;
    }completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
    }];
}

- (float)Suit:(float)MySuit {
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
