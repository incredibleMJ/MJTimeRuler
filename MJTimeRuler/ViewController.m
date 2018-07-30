//
//  ViewController.m
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import "ViewController.h"
#import "MJTimeRulerView.h"

@interface ViewController ()
@property (nonatomic, strong) MJTimeRulerView *ruler;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ruler = [MJTimeRulerView new];
    [self.view addSubview:self.ruler];
    [self.ruler mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    [self.view layoutIfNeeded];
    
    CGFloat LRPadding = self.view.bounds.size.width / 2.0 - self.ruler.cellSize.width / 2;
    CGFloat topPadding = self.ruler.bounds.size.height - self.ruler.cellSize.height - 1;
    self.ruler.edgeInset = UIEdgeInsetsMake(topPadding, LRPadding, 0, LRPadding);
    self.ruler.currentSec = 8888;
    
    UIView *line = [UIView new];
    [self.ruler addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(2);
    }];
    line.backgroundColor = [UIColor whiteColor];
    
    self.slider.minimumValue = 1;
    self.slider.maximumValue = self.ruler.maxScale;
    
}

- (IBAction)valueChanged:(UISlider *)sender {
    self.ruler.scale = sender.value;
}

@end
