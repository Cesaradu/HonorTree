//
//  Define.h
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 在release版本中关闭NSLog打印
#ifdef DEBUG
#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(format, ...)
#endif

//屏幕宽高
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define Width           self.view.frame.size.width
#define Height          self.view.frame.size.height

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 根据屏幕宽的比例
 5，se: 320, 4寸屏
 6,7,8,X: 375, 4.7寸屏
 plus: 414, 5.5寸屏
 */
#define Suit55Inch           1.104
#define Suit4Inch            1.171875

// 系统判定
#define IOS_VERSION    [[[UIDevice currentDevice]systemVersion]floatValue]
#define IS_IOS8        (IOS_VERSION>=8.0 && IOS_VERSION<9.0)
#define Is_IOS9        (IOS_VERSION>=9.0 && IOS_VERSION<10.0)
#define Is_IOS10       (IOS_VERSION>=10.0 && IOS_VERSION<11.0)
#define Is_IOS11       (IOS_VERSION>=11.0)

// 屏幕判定
#define IS_IPHONE35INCH  ([SDVersion deviceSize] == Screen3Dot5inch ? YES : NO)//4, 4S
#define IS_IPHONE4INCH  ([SDVersion deviceSize] == Screen4inch ? YES : NO)//5, 5C, 5S, SE
#define IS_IPHONE47INCH  ([SDVersion deviceSize] == Screen4Dot7inch ? YES : NO)//6, 6S, 7，8
#define IS_IPHONE55INCH ([SDVersion deviceSize] == Screen5Dot5inch ? YES : NO)//6P, 6SP, 7P，7SP，8P
#define IS_IPHONE58INCH ([SDVersion deviceSize] == Screen5Dot8inch ? YES : NO)//iPhonex

#define FruitWidth      [self Suit:82]
#define FruitHeight     [self Suit:91]


#endif /* Define_h */
