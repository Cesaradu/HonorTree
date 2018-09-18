//
//  ViewController.m
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import "ViewController.h"
#import "Tree.h"
#import "Reward.h"

@interface ViewController () <TreeDelegate>

@property (nonatomic, strong) Tree *tree;
@property (nonatomic, strong) Reward *reward;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view addSubview:self.tree];
}

#pragma mark - TreeViewDelegate
//点击果实，弹出弹窗
- (void)didSelectFruitAtFruit:(Fruit *)fruit {
    [self.reward show];
    self.reward.fruit = fruit;
}

- (Reward *)reward {
    if (!_reward) {
        _reward = [[Reward alloc] init];
    }
    return _reward;
}

- (Tree *)tree {
    if (!_tree) {
        _tree = [[Tree alloc] initWithFrame:CGRectMake([self Suit:5], (ScreenHeight - [self Suit:450])/2, ScreenWidth - [self Suit:10], [self Suit:450])];
        _tree.delegate = self;
        _tree.fruitCount = 8;
    }
    return _tree;
}

- (float)Suit:(float)MySuit {
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
