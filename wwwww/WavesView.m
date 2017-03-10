//
//  WavesView.m
//  wwwww
//
//  Created by 曹桂祥 on 17/2/9.
//  Copyright © 2017年 曹桂祥. All rights reserved.
//

#import "WavesView.h"

@interface WavesView()

@property (nonatomic,strong) CAShapeLayer *firstWavesLayer;

@property (nonatomic,strong) CADisplayLink *firstWaveDisplayLink;

@property (nonatomic,strong) UIColor *firstWavesColor;

@property (nonatomic,strong) UIView *sinView;

@property (nonatomic,strong) UIView *cosView;

@property (nonatomic,strong) CADisplayLink *secondDisplayLink;

@property (nonatomic,strong) CAShapeLayer *secondWaveLLayer;

@end

@implementation WavesView
{
    CGFloat waveCycle ;//水纹周期
    CGFloat waveVirb;//水纹振幅
    CGFloat waveWidth;
    CGFloat waveSpeed;
    
    CGFloat offsetX1;
    CGFloat offsetX2;
    CGFloat currentK;//当前波浪高度Y
}

-(UIView *)sinView{
    
    if (!_sinView) {
        _sinView = [[UIView alloc]initWithFrame:self.bounds];
        _sinView.alpha = 0.6;
    }
    
    return _sinView;
}

- (UIView *)cosView{
    if (!_cosView) {
        _cosView = [[UIView alloc]initWithFrame:self.frame];
        _cosView.alpha = 0.6;
    }
    return _cosView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.sinView];
        [self addSubview:self.cosView];
        
        [self setUpFirstWave];
        [self setUpSecondWave];
    }
    
    return self;
}

-(void)setUpFirstWave{
    
//    self.firstWavesColor =
//    [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
    
    self.firstWavesColor = [UIColor cyanColor];
    
    
    waveSpeed = 1/M_PI;
    
    if (!self.firstWavesLayer) {
        self.firstWavesLayer            = [CAShapeLayer new];
        self.firstWavesLayer.fillColor  = self.firstWavesColor.CGColor;
    }
    
    [self.sinView.layer addSublayer:self.firstWavesLayer];
    
    waveSpeed = 0.02;
    
    waveVirb  = 12;
    
    waveWidth = self.frame.size.width;
    
    waveCycle = 0.5/30.0;
    
    //设置波浪纵向
    currentK = self.frame.size.height * 0.5;
    
    //启动定时器
    self.firstWaveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getFirstWave:)];
    
    [self.firstWaveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
   
}

-(void)getFirstWave:(CADisplayLink *)displayLink{
    
    offsetX1 += waveSpeed;
    
    [self setFirstWaveLayerPath];

    
   }

-(void)setFirstWaveLayerPath{
    //创建一个path
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y = currentK;
    //将点移动到 x = 0, y = current的位置
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (NSInteger i = 0.0f; i<=waveWidth; i++) {
        //正弦
        y = waveVirb * sin(waveCycle * i + offsetX1) + currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    
    CGPathCloseSubpath(path);
    self.firstWavesLayer.path = path;
    
    //使用layer 而没用CurrentContext
    CGPathRelease(path);

}

-(void)setUpSecondWave{
    
    if (!self.secondWaveLLayer) {
        self.secondWaveLLayer           = [CAShapeLayer new];
        self.secondWaveLLayer.fillColor = [UIColor orangeColor].CGColor;
        
        [self.cosView.layer addSublayer:self.secondWaveLLayer];
    }
    
    waveWidth = self.frame.size.width;
    
    waveVirb  = 12;
    
    waveCycle = 0.5/30;
    
    waveSpeed = 0.02;
    
    //设置波浪纵向位置
    currentK = self.frame.size.height/2;//屏幕居中
    
    self.secondDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getSecondWave:)];
    
    [self.secondDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

-(void)getSecondWave:(CADisplayLink *)displayLink{
    
    offsetX2 += waveSpeed;
    
    [self setSecondWaveLayerPath];
    
}

-(void)setSecondWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y             = currentK;
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (int i = 0.0f; i<waveWidth; i++) {
        y                 = waveVirb * cos(i * waveCycle + offsetX2)+currentK;
        CGPathAddLineToPoint(path, nil, i, y);
    }
    CGPathAddLineToPoint(path, nil, waveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    
    CGPathCloseSubpath(path);
    self.secondWaveLLayer.path = path;
    
    //使用layer 而没用CurrentContext
    CGPathRelease(path);

    
    
}

@end
