//
//  MJTickMarkCell.m
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import "MJTickMarkCell.h"

@interface MJTickMarkCell()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *label;
@end

@implementation MJTickMarkCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSet];
        [self initViews];
    }
    return self;
}

- (void)initSet {
    self.lineColor = [UIColor redColor];
}

- (void)initViews {
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo([MJTickMarkCell lineHeightForLevel:MJTickScaleLevel1]);
    }];
    
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


#pragma mark - Setter
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.line.backgroundColor = lineColor;
}

- (void)setModel:(MJTickModel *)model {
    _model = model;
    
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([MJTickMarkCell lineHeightForLevel:model.level]);
    }];
    
    self.label.text = model.timeStr;
}

#pragma mark - Getter
+ (CGFloat)lineHeightForLevel:(MJTickScaleLevel)level {
    CGFloat height = 0;
    switch (level) {
        case MJTickScaleLevel1:
            height = 35;
            break;
        case MJTickScaleLevel2:
            height = 30;
            break;
        case MJTickScaleLevel3:
            height = 25;
            break;
        case MJTickScaleLevel4:
            height = 20;
            break;
        case MJTickScaleLevel5:
            height = 15;
            break;
        case MJTickScaleLevel6:
            height = 10;
            break;
        case MJTickScaleLevel7:
            height = 5;
            break;
        default:
            height = 2;
            break;
    }
    return height;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
    }
    return _line;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor grayColor];
        _label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
