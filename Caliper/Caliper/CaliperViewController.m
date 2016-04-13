//
//  CaliperViewController.m
//  TestCommon
//
//  Created by Billy on 16/4/6.
//  Copyright © 2016年 zzjr. All rights reserved.
//

#import "CaliperViewController.h"
#import "BCCaliperView.h"

@interface CaliperViewController ()

@property (nonatomic,strong) BCCaliperView *viewCaliper;

@end

@implementation CaliperViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.viewCaliper];
}

#pragma mark - Setter methods

- (BCCaliperView *)viewCaliper {
    
    if (!_viewCaliper) {
        
        _viewCaliper = [[BCCaliperView alloc] initWithFrame:CGRectMake(0, 100.0, SCREEN_WIDTH, 200.0)];
    }
    
    return _viewCaliper;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

@end
