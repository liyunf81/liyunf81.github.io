//
//  SalesReportDownloadOperation.m
//  Sales
//
//  Created by Angle on 15/8/4.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "SalesReportDownloadOperation.h"
#import "SalesAccount.h"

@interface SalesReportDownloadOperation ()

@property(strong) SalesAccount* account;
@property(strong) NSString* userName;
@property(strong) NSString* password;
@property(strong) NSPersistentStoreCoordinator* psc;

-(NSData *)dataFormSynPostRequestWithURL:(NSURL *)url bodyDictionary:(NSDictionary *)bodyDic response:(NSHTTPURLResponse **)response;
-(NSString *)stringFromSynPostRequestWithURL:(NSURL *)url bodyDIctionary:(NSDictionary *)bodyDic;
-(void)parsePaymentsPage:(NSString*)paymentsPage inAccount:(SalesAccount *)account vendorID:(NSString *)vendorId;

@end

@implementation SalesReportDownloadOperation

-(id)initWithAccount:(SalesAccount *)account
{
    self = [super init];
    if (self) {
        self.userName = account.userName;
        self.password = account.password;
        self.account = account;
        self.accountObjectId = account.objectID;
        self.psc = account.managedObjectContext.persistentStoreCoordinator;
    }
    return self;
}

-(void)main
{
    @autoreleasepool {
        int numberOfReportsDownloaded = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.account.downloadStatus = NSLocalizedString(@"Starting download", nil);
            self.account.downloadProgress = 0;
        });
        
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc]init];
        [moc setPersistentStoreCoordinator:self.psc];
        [moc setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        SalesAccount* account = (SalesAccount *)[moc objectWithID:self.accountObjectId];
        NSInteger previousBadge = [account.reportsBadge integerValue];
        NSString* vendorID = account.vendorId;
        for (NSString *dateType  in  @[@"Daily",@"Weekly"]) {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            
            NSDate *today = [NSDate date];
            if ([dateType isEqual:@"Weekly"]) {
                NSInteger weekDay = -1;
                while (YES) {
                    NSDateComponents *weekDayCompontes = [calendar components:NSWeekdayCalendarUnit fromDate:today];
                    weekDay = [weekDayCompontes weekday];
                    if (weekDay == 1) {
                        break;
                    }else{
                        today = [today dateByAddingTimeInterval:24 * 60 * 60];
                    }
                }
            }
        }
    }
}
@end
