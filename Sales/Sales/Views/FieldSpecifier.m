//
//  FieldSpecifier.m
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "FieldSpecifier.h"

@implementation FieldSpecifier
+(FieldSpecifier *)fieldWithType:(FieldSpecifierType)type andKey:(NSString *)key
{
    FieldSpecifier* field = [FieldSpecifier new];
    field.type = type;
    field.key = key;
    field.subSections = nil;
    return field;
}

+(FieldSpecifier *)switchFiledWithKey:(NSString *)key title:(NSString *)switchTitle defulatValue:(BOOL)flag
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Switch andKey:key];
    field.title = switchTitle;
    field.defaultValue = [NSNumber numberWithBool:flag];
    return field;
}

+(FieldSpecifier *)emailFieldWithKey:(NSString *)key title:(NSString *)emailTitle defulatValue:(NSString *)defultEmail
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Email andKey:key];
    field.title = emailTitle;
    field.defaultValue = defultEmail;
    return field;
}

+(FieldSpecifier*)URLFieldWithKey:(NSString *)key title:(NSString *)urlTitle defulatValue:(NSString *)defultUrl
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_URL andKey:key];
    field.title = urlTitle;
    field.defaultValue = defultUrl;
    return field;
}

+(FieldSpecifier*)passwordFieldWithKey:(NSString *)key title:(NSString *)passwordTitele defulatValue:(NSString *)defultPassword
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Password andKey:key];
    field.title = passwordTitele;
    field.defaultValue = defultPassword;
    return field;
}

+(FieldSpecifier*)textFieldWithKey:(NSString *)key title:(NSString *)textTitle defulatValue:(NSString *)defultText
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Text andKey:key];
    field.title = textTitle;
    field.defaultValue = defultText;
    return field;
}

+(FieldSpecifier*)numbericFieldWithKey:(NSString *)key title:(NSString *)numbericTitle defultValue:(NSString *)defultNumberic
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Numberic andKey:key];
    field.title = numbericTitle;
    field.defaultValue = defultNumberic;
    return field;
}

+(FieldSpecifier*)checkFieldWithKey:(NSString *)key title:(NSString *)checkTitle defultValue:(BOOL)checked
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Check andKey:key];
    field.title = checkTitle;
    field.defaultValue = [NSNumber numberWithBool:checked];
    return field;
}

+(FieldSpecifier*)buttonFieldWithKey:(NSString *)key title:(NSString *)buttonKey
{
    FieldSpecifier* field = [FieldSpecifier fieldWithType:FieldSpecifierType_Button andKey:key];
    field.title = buttonKey;
    return field;
}
@end

@implementation NamedTextFiled

-(void)dealloc
{
    self.name = nil;
}
@end

@implementation NamedSwitch

-(void)dealloc
{
    self.name = nil;
}

@end

