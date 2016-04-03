//
//  SMRotaryProtocol.h
//  PracticeWheel
//
//  Created by Maia Ezratty on 4/2/16.
//  Copyright © 2016 Maia Ezratty. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMRotaryProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue;

@end
