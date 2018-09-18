//
//  Tree.h
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fruit.h"

@protocol TreeDelegate <NSObject>

//点击果实，出现动画
- (void)didSelectFruitAtFruit:(Fruit *)fruit;

@end

@interface Tree : UIView

@property (nonatomic, assign) NSInteger fruitCount;//果实数量
@property (nonatomic, weak) id <TreeDelegate> delegate;

@end
