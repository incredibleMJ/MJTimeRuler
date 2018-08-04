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
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) MJTimeRulerView *ruler;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.ruler = [MJTimeRulerView new];
    [self.view addSubview:self.ruler];
    [self.ruler mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    [self.view layoutIfNeeded];
    self.ruler.lineColor = [UIColor blackColor];
    self.ruler.timeTextColor = [UIColor blackColor];
    self.ruler.indicatorColor = [UIColor darkGrayColor];
    
    __weak ViewController *weakSelf = self;
    self.ruler.didScroll = ^(double currentSec) {
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"sec:%.0f time:%@", currentSec, [NSString dateStrSinceZeroDateWithInterval:currentSec hasSecond:YES]];
    };
    self.ruler.currentSec = 8888;//当前秒数

    self.slider.minimumValue = 1;
    self.slider.maximumValue = self.ruler.maxScale;
}

- (IBAction)valueChanged:(UISlider *)sender {
    self.ruler.scale = sender.value;
}

@end
