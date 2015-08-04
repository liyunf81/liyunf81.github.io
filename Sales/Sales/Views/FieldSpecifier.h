//
//  FieldSpecifier.h
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Enumber.h"


@interface FieldSpecifier : NSObject
@property(nonatomic,assign) FieldSpecifierType type;
@property(nonatomic,strong) NSArray*   subSections;
@property(nonatomic,strong) NSString*  key;
@property(nonatomic,strong) NSString*  title;
@property(nonatomic,strong) NSString*  placeHolder;
@property(nonatomic,strong) id  defaultValue; //不知道会是神马类型
@property(nonatomic,assign) BOOL    shouldDisplayDisclosureIndicator;

+(FieldSpecifier *)fieldWithType:(FieldSpecifierType) type andKey:(NSString*)key;
+(FieldSpecifier *)switchFiledWithKey:(NSString*)key title:(NSString*) switchTitle defulatValue:(BOOL) flag;
+(FieldSpecifier*)emailFieldWithKey:(NSString*)key title:(NSString*) emailTitle defulatValue:(NSString*)defultEmail;
+(FieldSpecifier*)URLFieldWithKey:(NSString*)key title:(NSString*)urlTitle defulatValue:(NSString*)defultUrl;
+(FieldSpecifier*)passwordFieldWithKey:(NSString*)key title:(NSString*)passwordTitele defulatValue:(NSString*)defultPassword;
+(FieldSpecifier*)textFieldWithKey:(NSString*)key title:(NSString*)textTitle defulatValue:(NSString*)defultText;
+(FieldSpecifier*)numbericFieldWithKey:(NSString*)key title:(NSString*)numbericTitle defultValue:
(NSString*)defultNumberic;
+(FieldSpecifier*)checkFieldWithKey:(NSString*)key title:(NSString*)checkTitle defultValue:(BOOL)checked;
+(FieldSpecifier*)buttonFieldWithKey:(NSString*)key title:(NSString*)buttonKey;
@end

@interface NamedTextFiled : UITextField

@property(nonatomic,strong)NSString* name;

@end

@interface NamedSwitch : UISwitch

@property(nonatomic,strong)NSString* name;

@end
