//
//  ViewController.m
//  MasonryTestDemo
//
//  Created by llbt on 16/1/9.
//  Copyright © 2016年 llbt. All rights reserved.
//

#import "ViewController.h"
#include <Masonry/Masonry.h>

@implementation cardModel

-(cardModel *)initWithTitle:(NSString *)title andPrice:(NSString *)price andImage:(NSString *)image {

    self = [super init];
    if (self) {
        self.title = title;
        self.price = price;
        self.image = image;
    }
    return self;
}

+ (cardModel*)initWithTitle:(NSString *)title andPrice:(NSString *)price andImage:(NSString *)image {
    cardModel *card = [[cardModel alloc]initWithTitle:title andPrice:price andImage:image];
    return card;
}

@end

@implementation showInfoButton
- (void)showCardInfoTitle:(NSString *)title andPrice:(NSString *)price andImage:(NSString *)image {
    
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(3, 10 , 100, 90)];
    imageView.image = [UIImage imageNamed:image];
    imageView.layer.borderWidth=0.5f;
    imageView.layer.borderColor=[UIColor grayColor].CGColor;
    imageView.layer.cornerRadius=4.0f;
    [self addSubview:imageView];
    
    
    UILabel * titleLel = [[UILabel alloc]initWithFrame:CGRectMake(3,imageView.frame.size.height , 100, 50)];
    titleLel.text=title;
    titleLel.numberOfLines =2;
    titleLel.textColor=[UIColor blackColor];
    titleLel.font=[UIFont systemFontOfSize:14];
    [self addSubview:titleLel];
    
    UILabel * priceLel = [[UILabel alloc]initWithFrame:CGRectMake(3,imageView.frame.size.height+40 , 100, 25)];
    priceLel.text=price;
    priceLel.contentMode=NSTextAlignmentCenter;
    priceLel.textColor=[UIColor blackColor];
    priceLel.font=[UIFont systemFontOfSize:15];
    [self addSubview:priceLel];
}

@end


@interface ViewController ()
{
    NSArray *_titleArray;
    NSArray *_priceArray;
    NSArray *_imageArray;
    
    UIView *showView;
    NSMutableArray *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initData];
    [self createShowView];
}

- (void)initData {
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];

    
    _titleArray = @[@"酒酒酒恒久老白干1",@"酒酒酒恒久老白干2",@"酒酒酒恒久老白干3",@"酒酒酒恒久老白干4",@"酒酒酒恒久老白干5",@"酒酒酒恒久老白干6"];
    _imageArray = @[@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png"];
    _priceArray = @[@"￥9.00",@"￥19.00",@"￥29.00",@"￥39.00",@"￥49.00",@"￥59.00"];
    
    for (int i = 0; i<_titleArray.count; i++) {
        cardModel *model = [[cardModel alloc]initWithTitle:_titleArray[i] andPrice:_priceArray[i] andImage:_imageArray[i]];
        
        [_dataArray addObject:model];
    }
}

- (void)createShowView {
    
    showView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 320)];
    showView.center = self.view.center;
    showView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:showView];
    

    NSMutableArray *btnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < _dataArray.count; i++) {
        
        showInfoButton *showBtn = [[showInfoButton alloc]init];
        cardModel *model = _dataArray[i];
        [showBtn showCardInfoTitle:model.title andPrice:model.price andImage:model.image];
        showBtn.tag = i;
        [showBtn addTarget:self action:@selector(clickTagAction:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:showBtn];
        [btnArray addObject:showBtn];
    }
    
    //设置动画
    [UIView animateWithDuration:1 animations:^{
        showView.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height);
        showView.backgroundColor = [UIColor magentaColor];
    }];
    
    //显示6个View修改。。。。
    [self equalSpacingView:btnArray
                 viewWidth:(showView.frame.size.width/3)
                viewHeight:160
            superViewWidth:showView.frame.size.width];
    
    //显示一行
    
//    [self equalSpacingView:btnArray viewWidth:showView.frame.size.width/3 viewHeight:150 superWithWidth:showView.frame.size.width];
}

//一行
/***
- (void)equalSpacingView:(NSArray *)views
               viewWidth:(CGFloat)width
              viewHeight:(CGFloat)height
          superViewWidth:(CGFloat)superViewWidth {
    
    //每个视图之间的距离
    CGFloat padding = (superViewWidth -  width * views.count) / (views.count - 1);
    
    for (int i = 0; i < views.count; i++) {
        
        UIView *firstView   = views[0];
        UIView *lastView    = views[views.count - 1];
        UIView *currentView = views[i];
        
        if (i == 0) {
            
            UIView *nextView = views[i + 1];
            [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(currentView.superview.mas_centerY);
                make.left.equalTo(currentView.superview.mas_left);
                make.right.equalTo(nextView.mas_left).with.offset(-padding);
                make.height.mas_equalTo(height);
                make.width.equalTo(nextView);
            }];
            
        }else if (i == views.count-1){
            
            UIView *previousView = views[i - 1];
            [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(lastView.superview.mas_centerY);
                make.left.equalTo(previousView.mas_right).with.offset(padding);
                make.right.equalTo(lastView.superview.mas_right);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView.mas_width);
            }];
        }
        else {
            UIView *previousView = views[i - 1];
            UIView *nextView = views[i + 1];
            
            [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(currentView.superview.mas_centerY);

                make.left.equalTo(previousView.mas_right).with.offset(padding);
                make.right.equalTo(nextView.mas_left).with.offset(-padding);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView);
            }];
            
            if (i + 1 == views.count) {
                
                [nextView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(nextView.superview.mas_centerY);
                    make.left.equalTo(currentView.mas_right).with.offset(padding);
                    make.right.equalTo(nextView.superview.mas_right);
                    make.height.mas_equalTo(width);
                    make.width.equalTo(previousView);
                }];
                
                return;
            }
        }
    }
}
 
 ***/

//两行
- (void)equalSpacingView:(NSArray *)views
               viewWidth:(CGFloat)width
              viewHeight:(CGFloat)height
          superViewWidth:(CGFloat)superViewWidth {
    
    //每个视图之间的距离
//    CGFloat padding = (superViewWidth -  width * views.count) / (views.count - 1);
    //0、1、2、
    //3、4、5
    for (int i = 0; i < views.count; i++) {
        UIView *currentView = views[i];
        
        if (i % 3 == 0) { // 0、3
            [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.top.equalTo(currentView.superview.mas_top);
                }else{
                    UIView *preView = views[i-1];
                    make.top.equalTo(preView.mas_bottom).offset(10);
                }
//                make.width.mas_equalTo(100);//会造成冲突。。。
                make.left.equalTo(currentView.superview.mas_left);
                make.height.mas_equalTo(height);
            }];
        } else if ((i +1) %3 == 0){ //2、5
            
            UIView *previousView = views[i - 1];
            [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(previousView.mas_top);
                make.left.equalTo(previousView.mas_right).offset(0);
                make.right.equalTo(currentView.superview.mas_right);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView.mas_width);
            }];
        }
        
        else { //1 、4
            
            UIView *previousView = views[i - 1];
            [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(previousView.mas_top);
                make.left.equalTo(previousView.mas_right).offset(0);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView.mas_width);
            }];
        }
    }
    
}

- (void)clickTagAction:(UIButton *)sender {
    NSLog(@"你点击了tag：%d",sender.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
