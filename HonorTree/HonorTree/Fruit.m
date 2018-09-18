//
//  Fruit.m
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import "Fruit.h"

@interface Fruit ()

@property (nonatomic, strong) UIImageView *fruitImage;

@end

@implementation Fruit

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.fruitImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"duihuanghua"]];
    self.fruitImage.contentMode = UIViewContentModeScaleAspectFill;
    self.fruitImage.userInteractionEnabled = YES;
    self.fruitImage.frame = CGRectMake(-FruitWidth*3/8, FruitHeight/4, FruitWidth, FruitHeight);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFruit)];
    [self.fruitImage addGestureRecognizer:tap];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"兑换";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self.fruitImage addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fruitImage.mas_top).offset([self Suit:37]);
        make.centerX.equalTo(self.fruitImage.mas_centerX);
    }];
    
    [self animate];
}

//超出父视图部分点击
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint newPoint = [self.fruitImage convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.fruitImage.bounds, newPoint)) {
            view = self.fruitImage;
        }
    }
    return view;
}

- (void)tapFruit {
    if (self.clickFruitImageBlock) {
        self.clickFruitImageBlock();
    }
}

- (void)animate {
    //添加
    [self addSubview:self.fruitImage];
    
    //缩放
    self.fruitImage.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    self.fruitImage.alpha = 0.0f;
    [UIView animateWithDuration:0.8 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.fruitImage.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.fruitImage.alpha = 1;
    } completion:^(BOOL finished) {
        //旋转
        double value = (double)arc4random()/0x100000000; //取0～1之间的小数
        value = value * 4 / 100 + 0.04; //0.04～0.08之间的小数
        CGFloat fromRotation = 0;
        CGFloat byRotation = value;
        CGFloat toRotation = -value;
        CAKeyframeAnimation *circleTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        circleTransform.duration = (arc4random() %(10 - 6 + 1)) + 6; //6-10之间的整数
        circleTransform.repeatCount = MAXFLOAT;
        circleTransform.autoreverses = NO;
        circleTransform.values = @[
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, fromRotation, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, byRotation, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, fromRotation, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, toRotation, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, fromRotation, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, byRotation/2, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, fromRotation, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, toRotation/2, 0.0, 0.0, 1.0)],
                                   [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, fromRotation, 0.0, 0.0, 1.0)]
                                   ];
        [self.layer addAnimation:circleTransform forKey:@"shakeAnimation"];
        
        //拉伸
        CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
        scaleY.values   = @[@1.0, @1.04, @1.01, @1.04, @1.01, @1.04, @1.02, @1.04, @1.01, @1.02, @1.0];
        scaleY.duration = 8;
        scaleY.repeatCount = MAXFLOAT;
        scaleY.autoreverses = NO;
        [self.layer addAnimation:scaleY forKey:@"scaleY"];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.6 animations:^{
        CGRect frame = self.fruitImage.frame;
        frame.origin.y += FruitHeight;
        self.fruitImage.frame = frame;
        self.fruitImage.transform = CGAffineTransformMakeScale(.3f, .3f);
        self.fruitImage.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.layer removeAllAnimations];
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
