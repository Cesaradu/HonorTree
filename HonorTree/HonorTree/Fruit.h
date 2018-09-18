//
//  Fruit.h
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fruit : UIView

@property (nonatomic, copy) void (^clickFruitImageBlock) (void);//点击果实
@property (nonatomic, copy) void (^finishCollectFruitBlock) (NSInteger index);//收取完成

//果实消失
- (void)dismiss;

@end
