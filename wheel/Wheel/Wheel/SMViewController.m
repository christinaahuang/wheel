//
//  ViewController.m
//  TestWheel
//
//  Created by Maia Ezratty on 4/2/16.
//  Copyright © 2016 Maia Ezratty. All rights reserved.
//

#import "SMRotaryWheel.h"
#import "SMViewController.h"

@interface SMViewController ()

@end

@implementation SMViewController

@synthesize sectorLabel;

- (void)viewDidLoad {
    // 1 - Call super method
    [super viewDidLoad];
    // 2 - Create sector label
    sectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
    sectorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:sectorLabel];
    // 3 - Set up rotary wheel
    SMRotaryWheel *wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)
                                                    andDelegate:self
                                                   withSections:8];
    wheel.center = CGPointMake(160, 240);
    // 4 - Add wheel to view
    [self.view addSubview:wheel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue {
    self.sectorLabel.text = newValue;
}

@end
