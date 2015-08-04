//
//  SalesReportDownloadOperation.h
//  Sales
//
//  Created by Angle on 15/8/4.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString* kASReportDownloadErrorDes = @"errorDes";
static NSString* kASReportDownloadFailedNotfi = @"kASReportDownloadFailedNotfi";

@class SalesAccount;
@interface SalesReportDownloadOperation : NSOperation

@property(readonly) NSInteger downloadCount;
@property(copy) NSManagedObjectID* accountObjectId;

-(id)initWithAccount:(SalesAccount *)account;
@end
