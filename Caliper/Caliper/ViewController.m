//
//  ViewController.m
//  Caliper
//
//  Created by Billy on 16/4/13.
//  Copyright © 2016年 zzjr. All rights reserved.
//

#import "ViewController.h"
#import "CaliperViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:[CaliperViewController new] animated:YES completion:nil];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
