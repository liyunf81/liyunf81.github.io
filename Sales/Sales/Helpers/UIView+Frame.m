//
//  UIView+Frame.m
//  Sales
//
//  Created by feng on 15/8/4.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (SalesFrame)

-(CGFloat)Width
{
    return self.frame.size.width;
}

-(CGFloat)Height
{
    return self.frame.size.height;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(CGSize)size
{
    return self.bounds.size;
}

-(CGPoint)point
{
    return self.frame.origin;
}

@end
