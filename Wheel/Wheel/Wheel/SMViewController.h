//
//  ViewController.h
//  TestWheel
//
//  Created by Maia Ezratty on 4/2/16.
//  Copyright © 2016 Maia Ezratty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"

@interface SMViewController : UIViewController<SMRotaryProtocol>

@property (nonatomic, strong) UILabel *sectorLabel;

@end

