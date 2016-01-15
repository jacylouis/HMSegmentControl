//
//  ViewController.m
//  HMSegmentControl
//
//  Created by mac on 16/1/15.
//  Copyright © 2016年 leiliang. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentControl.h"

@interface ViewController () {
    HMSegmentControl *segmentControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    segmentControl = [[HMSegmentControl alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 40) dataArray:@[@"Hello", @"Swift", @"Objc", @"Apple"]];
    segmentControl.maskWidth = 60.f;
    segmentControl.maskHeight = 25.f;
    segmentControl.duration = 3.f;
    segmentControl.cornerRadius = 10.f;
    [self.view addSubview:segmentControl];
    
    [segmentControl reloadData];
    
    [segmentControl HMSegmentControlClickedCompletion:^(NSInteger index, id returnValue) {
        NSLog(@"%zd, %@", index, returnValue);
    }];
    
}

- (IBAction)reloadData:(id)sender {
    
    segmentControl.maskWidth = 80.f;
    segmentControl.maskHeight = 30.f;
    segmentControl.duration = 0.5f;
    segmentControl.cornerRadius = 5.f;
    
    [segmentControl reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
