//
//  SalesFieldEditorViewController.h
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enumber.h"


@class FieldSpecifier,SalesFieldEditorViewController,FieldSectionSpecifier;

@protocol SalesFieldEditorViewControllerDelegate <NSObject>

@optional
-(void)fieldEditor:(SalesFieldEditorViewController *)editor didFinishEditingWithVaues:(NSDictionary*) values;
-(void)fieldEditorDidCancel:(SalesFieldEditorViewController *)editor;
-(void)fieldEditor:(SalesFieldEditorViewController*)editor  presseButtonWithKey:(NSString*)key;
@end

@interface SalesFieldEditorViewController : UITableViewController<UITextFieldDelegate,SalesFieldEditorViewControllerDelegate>

@property(nonatomic,weak)id<SalesFieldEditorViewControllerDelegate> delegate;
@property(nonatomic,strong)NSArray* fieldSections;
@property(nonatomic,strong)NSString* DoneTitle;
@property(nonatomic,strong)NSString* cancelTitle;
@property(nonatomic,strong)NSString* editorIdentifier;
@property(nonatomic,strong)id context;
@property(nonatomic,assign)BOOL isSubSection;
@property(nonatomic,assign)BOOL hasChange;
@property(nonatomic,strong,readonly)UITextField* selectedTextField;
@property(nonatomic,strong,readonly)NSMutableDictionary* values;

-(id)initWithFieldSections:(NSArray*)sections andTitle:(NSString*)title;
-(void)dismissKeyboard;
@end


