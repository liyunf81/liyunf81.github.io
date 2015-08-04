//
//  SalesAccount.m
//  Sales
//
//  Created by feng on 15/8/4.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "SalesAccount.h"
#import "SSKeychain.h"

static NSString* kAccountKeyChain = @"accountKeyChan";

@implementation SalesAccount

@dynamic userName,vendorId,title,sortIndex,dailyReports,weeklyReports,
products,payments,reportsBadge,paymentsBadge;
@synthesize isDownloadingReports,downloadProgress,downloadStatus;

-(NSString *)password
{
    return [SSKeychain passwordForService:kAccountKeyChain account:self.userName];
}

-(void)setPassword:(NSString *)password
{
    [SSKeychain setPassword:password forService:kAccountKeyChain account:self.userName];
}

-(void)deletePassword
{
    [SSKeychain deletePasswordForService:kAccountKeyChain account:self.userName];
}

-(NSString *)displayName
{
    if (self.title && ![self.title isEqual:@""]) {
        return self.title;
    }
    return self.userName;
}
@end
