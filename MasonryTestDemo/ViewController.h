//
//  ViewController.h
//  MasonryTestDemo
//
//  Created by llbt on 16/1/9.
//  Copyright © 2016年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cardModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *image;

//带参数的构造函数
-(cardModel *)initWithTitle:(NSString *)title andPrice:(NSString *)price andImage:(NSString *)image ;

+(cardModel *)initWithTitle:(NSString *)title andPrice:(NSString *)price andImage:(NSString *)image ;

@end

@interface showInfoButton : UIButton

- (void)showCardInfoTitle:(NSString *)title andPrice:(NSString *)price andImage:(NSString *)image ;
@end

@interface ViewController : UIViewController


@end

