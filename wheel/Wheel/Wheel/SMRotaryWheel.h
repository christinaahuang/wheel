//
//  SMRotaryWheel.h
//  PracticeWheel
//
//  Created by Maia Ezratty on 4/2/16.
//  Copyright © 2016 Maia Ezratty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"
#import "SMSector.h"

@interface SMRotaryWheel : UIControl

// delegate to notify when the user selects a section
@property (weak) id <SMRotaryProtocol> delegate;

// container view that the rotary wheel will be inside
@property (nonatomic, strong) UIView *container;

// number of sections in the rotary view
@property int numberOfSections;

// save the transform when the user taps on the component
@property CGAffineTransform startTransform;

@property (nonatomic, strong) NSMutableArray *sectors;
@property int currentSector;

@property(nonatomic, assign) CGFloat angularDamping;
@property(nonatomic) CGFloat angularVelocity;

// called from the view controller to initialize the component
- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;


-(void)rotate;

@end

