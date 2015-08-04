//
//  FieldSectionSpecifier.h
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FieldSectionSpecifier : NSObject

@property(nonatomic,strong)NSArray* fields;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* Description;
@property(nonatomic,assign)BOOL exclusiveSelection;

+(FieldSectionSpecifier*)sectionWithFields:(NSArray*)fields title:(NSString*)title description:(NSString*)descritio;

@end
