//
//  ClockViewController.m
//  KAnimClock
//
//  Created by khr on 4/27/16.
//  Copyright © 2016 khr. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()
@end

@implementation ClockViewController {

  NSTimer *_timer;
  CALayer *_secondHandLayer;
  CALayer *_minuteHandLayer;
  CALayer *_hourHandLayer;

}

- (void)viewDidLoad {

  [super viewDidLoad];

  _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(tick)
                                          userInfo:nil
                                           repeats:YES];

  //Set initial position
  [self tick];

  CGFloat xc = self.view.frame.size.width / 2.0f;
  CGFloat yc = self.view.frame.size.height / 2.0f;

  _hourHandLayer = [CALayer layer];
  _hourHandLayer.frame = CGRectMake(xc - 50.0f, yc - 50.0f, 100.0f, 100.0f);
  _hourHandLayer.anchorPoint = CGPointMake(0.5f, 0.1f);

  _hourHandLayer.contents = [NSImage imageNamed:@"HourHand"];
  _hourHandLayer.contentsGravity = kCAGravityResizeAspect;

  [self.view.layer addSublayer:_hourHandLayer];

  _minuteHandLayer = [CALayer layer];
  _minuteHandLayer.frame = CGRectMake(xc - 50.0f, yc - 50.0f, 100.0f, 100.0f);
  _minuteHandLayer.anchorPoint = CGPointMake(0.5f, 0.1f);

  _minuteHandLayer.contents = [NSImage imageNamed:@"MinuteHand"];
  _minuteHandLayer.contentsGravity = kCAGravityResizeAspect;

  [self.view.layer addSublayer:_minuteHandLayer];

  _secondHandLayer = [CALayer layer];
  _secondHandLayer.frame = CGRectMake(xc - 50.0f, yc - 50.0f, 100.0f, 100.0f);
  _secondHandLayer.anchorPoint = CGPointMake(0.5f, 0.1f);

  _secondHandLayer.contents = [NSImage imageNamed:@"SecondHand"];
  _secondHandLayer.contentsGravity = kCAGravityResizeAspect;

  [self.view.layer addSublayer:_secondHandLayer];

}

- (void)tick {

  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSUInteger units =
  NSCalendarUnitHour |
  NSCalendarUnitMinute |
  NSCalendarUnitSecond;

  NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];

  CGFloat secondsFraction = components.second / 60.0f;
  CGFloat minutesFraction = (components.minute + secondsFraction) / 60.0f;

  CGFloat hoursAngle = - (components.hour + minutesFraction) / 12.0f * M_PI * 2.0;
  CGFloat minutesAngle = - minutesFraction * M_PI * 2.0;
  CGFloat secondsAngle = - secondsFraction * M_PI * 2.0;

  _hourHandLayer.transform = CATransform3DMakeRotation(hoursAngle, 0.0f, 0.0f, 1.0f);
  _minuteHandLayer.transform = CATransform3DMakeRotation(minutesAngle, 0.0f, 0.0f, 1.0f);
  _secondHandLayer.transform = CATransform3DMakeRotation(secondsAngle, 0.0f, 0.0f, 1.0f);
  
}

@end
