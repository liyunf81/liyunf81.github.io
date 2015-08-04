//
//  SalesAccount.h
//  Sales
//
//  Created by feng on 15/8/4.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 *  账号类，用于管理账号相关基础信息，包括账号密码，销售，等，其中密码存放在keychain中
 */

@interface SalesAccount : NSManagedObject

@property(nonatomic,assign)BOOL isDownloadingReports;
@property(nonatomic,retain)NSString* password;
@property(nonatomic,retain)NSString* downloadStatus;
@property(nonatomic,assign)float downloadProgress;

@property(nonatomic,retain) NSString* userName;
@property(nonatomic,retain) NSString* vendorId; //销售ID 其实就是账号对应的标示ID
@property(nonatomic,retain) NSString* title; //这个事什么鬼
@property(nonatomic,retain) NSNumber* sortIndex;
@property(nonatomic,retain) NSSet*    dailyReports;
@property(nonatomic,retain) NSSet*    weeklyReports;
@property(nonatomic,retain) NSSet*    products;
@property(nonatomic,retain) NSSet*    payments;
@property(nonatomic,retain) NSNumber* reportsBadge;
@property(nonatomic,retain) NSNumber* paymentsBadge;

-(void)deletePassword;
-(NSString*)displayName;
@end
