//
//  ViewController.m
//  iRollingBall
//
//  Created by Bui Duc Khanh on 9/8/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSTimer* timer;
    
    UIImageView *ball;
    
    float radius;
    
    float angle;
    float maxAngle;
    
    float scheduleTimer;
    float deltaAngle;
    
    bool isLeftToRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    radius = 56;
    angle = 0;
    maxAngle = (self.view.frame.size.width - 2.0 * radius) / radius;
    
    scheduleTimer = 0.03; // Tốc độ lăn càng nhỏ càng nhanh
    deltaAngle = 0.05;     // Góc lăn càng nhỏ càng mịn
    
    isLeftToRight = true;
    
    
    [self addBall];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:scheduleTimer
                                             target:self selector:@selector(rollBall)
                                           userInfo:nil
                                            repeats:true];
}

// Hàm tạo bóng và đưa vào giao diện
- (void) addBall{
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    ball.center = CGPointMake(radius, self.view.frame.size.height/2.0);
    
    [self.view addSubview:ball];
}


// Lăn bóng
- (void) rollBall{
    // Kiểm tra đến biên phải chưa -> phải thì quay ngược lại
    if (isLeftToRight && (angle + deltaAngle) > maxAngle)
    {
        isLeftToRight = false;
    }
    
    // Kiểm tra đến biên trái -> phải thì quay ngược lại
    if (!isLeftToRight && (angle - deltaAngle) < 0)
    {
        isLeftToRight = true;
    }
    
    if (isLeftToRight)  // Quay từ trái sang phải
    {
        angle = angle + deltaAngle;
        
        ball.transform = CGAffineTransformMakeRotation(angle);
        
        ball.center = CGPointMake(ball.center.x + deltaAngle*radius, ball.center.y);
    }
    else  // Quay từ phải sang trái
    {
        angle = angle - deltaAngle;
        
        ball.transform = CGAffineTransformMakeRotation(angle);
        
        ball.center = CGPointMake(ball.center.x - deltaAngle*radius, ball.center.y);
    }
}

@end
