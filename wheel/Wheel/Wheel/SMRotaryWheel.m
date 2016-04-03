//
//  SMRotaryWheel.m
//  PracticeWheel
//
//  Created by Maia Ezratty on 4/2/16.
//  Copyright © 2016 Maia Ezratty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SMRotaryWheel.h"
@import SpriteKit;

@interface SMRotaryWheel()
- (void)drawWheel;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildSectorsEven;
- (void) buildSectorsOdd;
- (UIImageView *) getSectorByValue:(int)value;
@end

// save the angle when the user touches the component
static float deltaAngle;

static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation SMRotaryWheel

@synthesize delegate, container, numberOfSections, startTransform, sectors, currentSector, angularDamping, angularVelocity;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    // 1 - Call super init
    if ((self = [super initWithFrame:frame])) {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        // 3 - Draw wheel
        [self drawWheel];
        self.currentSector = 0;
        // 4 - Timer for rotating wheel
//        [NSTimer scheduledTimerWithTimeInterval:2.0
//                                         target:self
//                                       selector:@selector(rotate)
//                                       userInfo:nil
//                                        repeats:YES];
    }
    return self;
}



- (void) drawWheel {
    // 1
    container = [[UIView alloc] initWithFrame:self.frame];
    
    SKSpriteNode * sprite = [SKSpriteNode spriteNodeWithImageNamed:@"slice.png"];
    sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width/2];
    sprite.physicsBody.dynamic = YES;
    sprite.physicsBody.allowsRotation = YES;
    sprite.physicsBody.angularDamping = 0.1;
    sprite.physicsBody.angularVelocity = 1.0; //???
    
    // 2
    CGFloat angleSize = 2*M_PI/numberOfSections;
    // 3 - Create the sectors
    for (int i = 0; i < numberOfSections; i++) {
        // 4 - Create image view
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slice.png"]];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        container.bounds.size.height/2.0-container.frame.origin.y);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = minAlphavalue;
        im.tag = i;
        if (i == 0) {
            im.alpha = maxAlphavalue;
        }
        // 5 - Set sector image
        UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 40, 40)];
        // sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [im addSubview:sectorImage];
        // 6 - Add image view to container
        [container addSubview:im];
    }
    // 7
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    // 7.1 - Add background image
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
    bg.image = [UIImage imageNamed:@"wheel_2.png"];
    [self addSubview:bg];
    // 8 - Initialize sectors
    sectors = [NSMutableArray arrayWithCapacity:numberOfSections];
    if (numberOfSections % 2 == 0) {
        [self buildSectorsEven];
    } else {
        [self buildSectorsOdd];
    }
    // 9 - Call protocol method
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]];
}

- (void) rotate {
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -0.78);
    container.transform = t;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1 - Get touch position
    CGPoint touchPoint = [touch locationInView:self];
    // 1.1 - Get the distance from the center
    float dist = [self calculateDistanceFromCenter:touchPoint];
    // 1.2 - Filter out touches too close to the center
    if (dist < 40 || dist > 100)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    // 2 - Calculate distance from center
    float dx = touchPoint.x - container.center.x;
    float dy = touchPoint.y - container.center.y;
    // 3 - Calculate arctangent value
    deltaAngle = atan2(dy,dx);
    // 4 - Save current transform
    startTransform = container.transform;
    // 5 - Set current sector's alpha value to the minimum value
    UIImageView *im = [self getSectorByValue:currentSector];
    im.alpha = minAlphavalue;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    NSLog(@"rad is %f", radians);
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    // 1 - Get current container rotation in radians
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    // 2 - Initialize new value
    CGFloat newVal = 0.0;
    // 3 - Iterate through all the sectors
    for (SMSector *s in sectors) {
        // 4 - See if the current sector contains the radian value
        if (radians > s.minValue && radians < s.maxValue) {
            // 5 - Set new value
            newVal = radians - s.midValue;
            // 6 - Get sector number
            currentSector = s.sector;
            break;
        }
    }
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:10.0 * touch.force];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    [UIView commitAnimations];
    // 9 - Call protocol method
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]];
    // 10 - Highlight selected sector
    UIImageView *im = [self getSectorByValue:currentSector];
    im.alpha = maxAlphavalue;
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void) buildSectorsOdd {
    // 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
    // 2 - Set initial midpoint
    CGFloat mid = 0;
    // 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
        // 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        mid -= fanWidth;
        if (sector.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
        // 5 - Add sector to array
        [sectors addObject:sector];
        NSLog(@"cl is %@", sector);
    }
}

- (void) buildSectorsEven {
    // 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
    // 2 - Set initial midpoint
    CGFloat mid = 0;
    // 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
        // 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        if (sector.maxValue-fanWidth < - M_PI) {
            mid = M_PI;
            sector.midValue = mid;
            sector.minValue = fabsf(sector.maxValue);
            
        }
        mid -= fanWidth;
        NSLog(@"cl is %@", sector);
        // 5 - Add sector to array
        [sectors addObject:sector];
    }
}

- (UIImageView *) getSectorByValue:(int)value {
    UIImageView *res;
    NSArray *views = [container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
}


@end













