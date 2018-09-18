//
//  Tree.m
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import "Tree.h"

#define DefaultFruitCount   6

@interface Tree ()

@property (nonatomic, strong) UIImageView *treeView;
//根据UI设计图，事先存好果实的frame
@property (nonatomic, strong) NSMutableArray *frameArray;

@property (nonatomic, assign) NSInteger leftFruitCount; //超过6个剩下的个数

@end

@implementation Tree

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)setFruitCount:(NSInteger)fruitCount {
    _fruitCount = fruitCount;
    [self addFruits];
}

- (void)addFruits {
    /*
     * 添加果实
     * 根据设计图来定，目前设计图最多显示6个，超过6个，在点击摘取后再显示
     */
    if (self.fruitCount > DefaultFruitCount) {
        self.leftFruitCount = self.fruitCount - DefaultFruitCount;
    }
    for (int i = 0; i < (self.fruitCount <= DefaultFruitCount ? self.fruitCount : 6); i ++) {
        [self buildFruitView:i];
    }
}

- (void)buildFruitView:(NSInteger) i {
    Fruit *fruit = [[Fruit alloc] initWithFrame:[self.frameArray[i] CGRectValue]];
    fruit.tag = i + 10000;
    __weak typeof(fruit) weakFruit = fruit;
    //点击果实
    fruit.clickFruitImageBlock = ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectFruitAtFruit:)]) {
            [self.delegate didSelectFruitAtFruit:weakFruit];
        }
    };
    
    //果实收取完毕
    fruit.finishCollectFruitBlock = ^(NSInteger index) {
        [self checkMoreFruits:index];
    };
    
    [self.treeView addSubview:fruit];
}

//检查是否还剩下更多果实
- (void)checkMoreFruits:(NSInteger) index {
    if (self.fruitCount > DefaultFruitCount && self.leftFruitCount != 0) {
        self.leftFruitCount --;
        [self buildFruitView:index];
    }
    NSLog(@"index: %ld, 剩余：%ld", index, self.leftFruitCount);
}

- (void)buildUI {
    self.backgroundColor = [UIColor colorWithRed:244/255. green:239/255. blue:226/255. alpha:1.0];
    self.layer.cornerRadius = 5;
    self.layer.shadowRadius = [self Suit:3];
    self.layer.shadowOffset = CGSizeMake([self Suit:3], [self Suit:3]);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor colorWithRed:154/255. green:154/255. blue:154/255. alpha:1.0].CGColor;
    
    //背景图
    self.treeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shu"]];
    self.treeView.userInteractionEnabled = YES;
    self.treeView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.treeView];
    [self.treeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo([self Suit:308]);
        make.height.mas_equalTo([self Suit:384]);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (NSMutableArray *)frameArray {
    if (!_frameArray) {
        _frameArray = [NSMutableArray arrayWithArray:@[
                                                       [NSValue valueWithCGRect:CGRectMake([self Suit:54] + FruitWidth*3/8, [self Suit:75] - FruitHeight/4, FruitWidth/4, FruitHeight/2)],
                                                       [NSValue valueWithCGRect:CGRectMake([self Suit:206] + FruitWidth*3/8, [self Suit:50] - FruitHeight/4, FruitWidth/4, FruitHeight/2)],
                                                       [NSValue valueWithCGRect:CGRectMake([self Suit:2] + FruitWidth*3/8, [self Suit:150] - FruitHeight/4, FruitWidth/4, FruitHeight/2)],
                                                       [NSValue valueWithCGRect:CGRectMake([self Suit:143] + FruitWidth*3/8, [self Suit:171] - FruitHeight/4, FruitWidth/4, FruitHeight/2)],
                                                       [NSValue valueWithCGRect:CGRectMake([self Suit:23] + FruitWidth*3/8, [self Suit:266] - FruitHeight/4, FruitWidth/4, FruitHeight/2)],
                                                       [NSValue valueWithCGRect:CGRectMake([self Suit:212] + FruitWidth*3/8, [self Suit:265] - FruitHeight/4, FruitWidth/4, FruitHeight/2)]
                                                       ]];
    }
    return _frameArray;
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
