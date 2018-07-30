//
//  MJTimeRulerView.m
//  TT
//
//  Created by MJ2009 on 2018/7/26.
//  Copyright © 2018年 MJ2009. All rights reserved.
//

#import "MJTimeRulerView.h"
#import "MJTickMarkCell.h"

static double amountSec = 3600 * 24;//总秒数 24h
static CGFloat baseWidth = 8; //最小刻度间隔(未缩放)
static CGFloat minLabelSpace = 55;//时间标签之间的最小距离

@interface MJTimeRulerView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *tickModels;

@property (nonatomic, assign, readwrite) CGSize cellSize;
@property (nonatomic, assign, readwrite) CGFloat distance;

@property (nonatomic, strong) NSMutableDictionary *modelsDic;

/**
 刻度总数
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 缩放级别 (最小刻度的时长 秒为单位)
 */
@property (nonatomic, copy) NSArray<NSNumber *> *scales;

/**
 加刻度值的时长 (秒为单位 比如1小时加个时间标签 半小时也加一个时间标签...)
 */
@property (nonatomic, copy) NSArray<NSNumber *> *tagDurations;

@end

@implementation MJTimeRulerView

- (instancetype)init {
    if (self = [super init]) {
        [self initSet];
        [self initViews];
    }
    return self;
}

- (void)initSet {
    self.cellSize = CGSizeMake(2, [MJTickMarkCell lineHeightForLevel:MJTickScaleLevel1] + 25);
    
    //最小刻度的时长 秒为单位
    _scales = @[@(600),//10 min
                @(300),//5 min
                @(60),//1 min
                @(10),//10 s
                @(5),//5 s
                //                @(1)//1 s
                ];
    
    //加刻度值的时长 (秒为单位 比如1小时加个时间标签 半小时也加一个时间标签...)
    _tagDurations = @[@(3600),//1 h
                      @(1800),//30 min
                      @(900),//15 min
                      @(300),//5 min
                      @(60),//1 min
                      @(30),//30 s
                      ];
    
    //缩放级别
    _scale = 1;
    _averageSec = [self.scales.firstObject doubleValue];
    _distance = 8; //8 pt
}

- (void)initViews {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self redraw];
}

- (void)redraw {
    //根据缩放级别确定单位刻度时长和宽度
    NSInteger scale = 0;
    if (_scale >= 1 && _scale < 2) {
        _averageSec = [self.scales[0] unsignedIntegerValue];
        _distance = baseWidth * _scale;
        scale = 0;
    }
    if (_scale >= 2 && _scale < 3) {
        _averageSec = [self.scales[1] unsignedIntegerValue];
        _distance = baseWidth * (_scale - 1);
        scale = 1;
    }
    if (_scale >= 3 && _scale < 4) {
        _averageSec = [self.scales[2] unsignedIntegerValue];
        _distance = baseWidth * (_scale - 2);
        scale = 2;
    }
    if (_scale >= 4 && _scale < 5) {
        _averageSec = [self.scales[3] unsignedIntegerValue];
        _distance = baseWidth * (_scale - 3);
        scale = 3;
    }
    if (_scale >= 5 && _scale < 6) {
        _averageSec = [self.scales[4] unsignedIntegerValue];
        _distance = baseWidth * (_scale - 4);
        scale = 4;
    }
    if (_scale >= 6) {
        _averageSec = [self.scales[5] unsignedIntegerValue];
        _distance = baseWidth;
        scale = 5;
    }
    
    self.tickModels = [self.modelsDic objectForKey:@(scale)];
    
    [self.collectionView reloadData];
    
    CGFloat lineWidth = 2;
    self.collectionView.contentOffset = CGPointMake((_distance + lineWidth) * self.currentSec / _averageSec, 0);
}

- (NSString *)dateStrSinceZeroDateWithInterval:(NSTimeInterval)interval hasSecond:(BOOL)isHasSec {
    NSDate *zeroDate = [self zeroDate];
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate dateWithTimeInterval:interval sinceDate:zeroDate];
    dateFomater.dateFormat = isHasSec ? @"HH:mm:ss" : @"HH:mm";
    return [dateFomater stringFromDate:date];
}

- (NSDate *)zeroDate {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy年MM月dd日";
    NSString *zeroDateStr = [dateFomater stringFromDate:nowDate];
    return [dateFomater dateFromString:zeroDateStr];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJTickMarkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.tickModels.count > indexPath.item) {
        cell.model = self.tickModels[indexPath.item];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.edgeInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return MAXFLOAT;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _distance;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellSize;
}

#pragma mark - Setter
- (void)setScale:(float)scale {
    //确保缩放级别在有效范围内
    _scale = scale;
    if (scale < 1) {
        _scale = 1;
    }
    if (scale > _scales.count + 1) {
        _scale = _scales.count + 0.95;
    }
    
    [self redraw];
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    _edgeInset = edgeInset;
    [self.collectionView reloadData];
}

- (void)setCellSize:(CGSize)cellSize {
    _cellSize = cellSize;
    [self.collectionView reloadData];
}

#pragma mark - Getter
- (NSUInteger)count {
    return (NSUInteger)(amountSec / _averageSec) + 1;
}

- (float)maxScale {
    return _scales.count + 0.5;
}

- (NSArray<NSNumber *> *)scales {
    NSArray *arr = [_scales sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return obj1 < obj2;
    }];
    return arr;
}

- (NSArray<NSNumber *> *)tagDurations {
    NSArray *arr = [_tagDurations sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return obj1 < obj2;
    }];
    return arr;
}

- (NSMutableArray *)tickModels {
    if (!_tickModels) {
        _tickModels = [NSMutableArray arrayWithCapacity:100];
    }
    return _tickModels;
}

- (NSMutableDictionary *)modelsDic {
    if (!_modelsDic) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self->_modelsDic = [NSMutableDictionary dictionaryWithCapacity:self.scales.count];
            
            CGFloat diatance = baseWidth * 1.5; //最小刻度缩放1.5倍时显示刻度值
            [self.scales enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                double averageSec = obj.integerValue;
                NSInteger count = amountSec / averageSec + 1;
                NSMutableArray *models = [NSMutableArray arrayWithCapacity:10];
                for (long i = 0; i < count; i++) {
                    MJTickModel *model = [MJTickModel new];
                    
                    //添加刻度线
                    long value = i * averageSec;
                    BOOL isNeedAddLabel = NO;
                    if (value % (self.tagDurations.count > 0 ? [self.tagDurations[0] longValue] : 3600) == 0) {
                        model.level = MJTickScaleLevel1;
                        isNeedAddLabel = YES;
                    }
                    else if (value % (self.tagDurations.count > 1 ? [self.tagDurations[1] longValue] : 1800) == 0) {
                        model.level = MJTickScaleLevel2;
                        isNeedAddLabel = ((self.tagDurations.count > 1 ? [self.tagDurations[1] longValue] : 1800) / averageSec) * diatance > minLabelSpace;
                    }
                    else if (value % (self.tagDurations.count > 2 ? [self.tagDurations[2] longValue] : 900) == 0) {
                        model.level = MJTickScaleLevel3;
                        isNeedAddLabel = ((self.tagDurations.count > 2 ? [self.tagDurations[2] longValue] : 900) / averageSec) * diatance > minLabelSpace;
                    }
                    else if (value % (self.tagDurations.count > 3 ? [self.tagDurations[3] longValue] : 300) == 0) {
                        model.level = MJTickScaleLevel4;
                        isNeedAddLabel = ((self.tagDurations.count > 3 ? [self.tagDurations[3] longValue] : 300) / averageSec) * diatance > minLabelSpace;
                    }
                    else if (value % (self.tagDurations.count > 4 ? [self.tagDurations[4] longValue] : 60) == 0) {
                        model.level = MJTickScaleLevel5;
                        isNeedAddLabel = ((self.tagDurations.count > 4 ? [self.tagDurations[4] longValue] : 60) / averageSec) * diatance > minLabelSpace;
                    }
                    else if (value % (self.tagDurations.count > 5 ? [self.tagDurations[5] longValue] : 30) == 0) {
                        model.level = MJTickScaleLevel6;
                        isNeedAddLabel = ((self.tagDurations.count > 5 ? [self.tagDurations[5] longValue] : 30) / averageSec) * diatance > minLabelSpace;
                    }
                    else {//最小刻度
                        model.level = MJTickScaleLevel7;
                    }
                    
                    if (isNeedAddLabel) {
                        model.timeStr = [self dateStrSinceZeroDateWithInterval:value hasSecond:model.level == MJTickScaleLevel6];
                    }
                    [models addObject:model];
                }
                [self->_modelsDic setObject:models forKey:@(idx)];
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               [self redraw];
            });
            
        });
    }
    return _modelsDic;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MJTickMarkCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [UICollectionViewFlowLayout new];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

@end
