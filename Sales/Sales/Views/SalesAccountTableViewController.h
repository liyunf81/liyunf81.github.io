//
//  SalesAccountTableViewController.h
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SalesFieldEditorViewController.h"

static NSString* kAccountUserName = @"userName";
static NSString* kAccountPassword = @"password";
static NSString* kAccountVendorId = @"vendorId";
static NSString* SettingViewDidChangeNotfiction = @"SettingsChange";

@class SalesAccount;
@protocol SalesAccountViewDelegate;

@interface SalesAccountTableViewController : UITableViewController<NSFetchedResultsControllerDelegate,UIAlertViewDelegate,
SalesFieldEditorViewControllerDelegate,UIDocumentInteractionControllerDelegate>

@property(nonatomic,assign)id<SalesAccountViewDelegate> delegate; //视图代理，通知其他界面更新
@property(nonatomic,retain)UIBarButtonItem* refreshButtonItem; //刷新按钮
@property(nonatomic,retain)NSArray* accounts; //账号数组
@property(nonatomic,retain)SalesAccount* selectedAccount; //编辑的账号
@property(nonatomic,retain)NSManagedObjectContext* managedObjectContext;//coredata的上下文
@property(nonatomic,retain)NSString* exportedReportsZipPath; //导出路劲
@property(nonatomic,retain)UIDocumentInteractionController* documentIController;
@property(nonatomic,retain,readonly)FieldSpecifier* passcodeLockField;
@property(nonatomic,retain,readonly)SalesFieldEditorViewController* settingsViewController;
@property(nonatomic,retain,readonly)UINavigationController* settingsNavController; //有什么作用？？
@end


@protocol SalesAccountViewDelegate <NSObject>

@optional
-(void)accountViewController:(SalesAccountTableViewController*) viewController didSelectAccount:(SalesAccount*)account;

@end