//
//  ViewController.m
//  Created by 曹桂祥 on 17/2/9.
//  Copyright © 2017年 曹桂祥. All rights reserved.
//

#import "ViewController.h"
#import "WavesView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WavesView *doubleWaves = [[WavesView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
    [self.view addSubview:doubleWaves];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
