//
//  FieldSectionSpecifier.m
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "FieldSectionSpecifier.h"

@implementation FieldSectionSpecifier

+(FieldSectionSpecifier*)sectionWithFields:(NSArray *)fields title:(NSString *)title description:(NSString *)descritio
{
    FieldSectionSpecifier* section = [FieldSectionSpecifier new];
    section.fields = fields;
    section.title = title;
    section.Description = descritio;
    section.exclusiveSelection = NO;
    return section;
}

-(void)dealloc
{
    self.fields = nil;
    self.title = nil;
    self.Description = nil;
    self.exclusiveSelection = NO;
}
@end
