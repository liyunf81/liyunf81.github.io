//
//  SalesAccountTableViewController.m
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "SalesAccountTableViewController.h"
#import "FieldSpecifier.h"
#import "FieldSectionSpecifier.h"

static NSString* kAccountTitle = @"accountTitle";
static NSString* kAddNewAccountEiditor = @"newAccount";

@interface SalesAccountTableViewController ()
@property(nonatomic,retain,readwrite)FieldSpecifier* passcodeLockField;
@property(nonatomic,retain,readwrite)SalesFieldEditorViewController* settingsViewController ;
@property(nonatomic,retain,readwrite)UINavigationController* settingsNavController; //有什么作用？？

-(void)reloadAccounts; //重新载入
-(void)downloadReports:(id)sender;//下载数据事件
-(void)doExport;//导出
-(NSString *)folderNameForExportingReportsOfAccount:(SalesAccount*) account;//根据账号信息获取文件名字
-(void)showSettings;
-(void)showInfos;
-(void)addNewAccount;
-(void)editAccount:(SalesAccount*)account;
-(void)saveContext; //保存数据 core data..
- (void)contextDidChange:(NSNotification *)notification;
@end

@implementation SalesAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(downloadReports:)];
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton* infoBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [infoBtn addTarget:self action:@selector(showInfos) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* infoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoBtn];
    
    self.toolbarItems = @[infoButtonItem,flexSpace,settingsButtonItem];
    self.navigationItem.rightBarButtonItem = self.refreshButtonItem;
    self.title = NSLocalizedString(@"Sales", nil);
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewAccount)];
    self.navigationItem.leftBarButtonItem = addButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidChange:) name:SettingViewDidChangeNotfiction object:self.managedObjectContext];
    [self reloadAccounts];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.accounts.count == 0) {
        [self addNewAccount];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isBusy"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.refreshButtonItem.enabled = !
            NSLog(@"数据更新...");
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)contextDidChange:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
}

//从数据库取数据
-(void) reloadAccounts
{
    self.accounts = [NSArray new];
    [self.tableView reloadData];
}

-(void)addNewAccount
{
    FieldSpecifier* titleField = [FieldSpecifier textFieldWithKey:kAccountTitle title:@"Description" defulatValue:@""];
    titleField.placeHolder = NSLocalizedString(@"optional", nil);
    FieldSectionSpecifier* titleSection = [FieldSectionSpecifier sectionWithFields:@[titleField] title:nil description:nil];
    
    FieldSpecifier* userNameField = [FieldSpecifier emailFieldWithKey:kAccountUserName title:NSLocalizedString(@"email", nil) defulatValue:@""];
    FieldSpecifier* passwordField = [FieldSpecifier passwordFieldWithKey:kAccountPassword title:NSLocalizedString(@"password", nil) defulatValue:@""];
    FieldSpecifier* vendorIdField = [FieldSpecifier numbericFieldWithKey:kAccountVendorId title:NSLocalizedString(@"Vendor ID", nil) defultValue:@""];
    vendorIdField.placeHolder = @"XXXXXXXX";
    FieldSpecifier* selectVendorIdButton = [FieldSpecifier buttonFieldWithKey:@"SelectVendorId" title:NSLocalizedString(@"Auto-Fill VendorID", nil)];
    FieldSectionSpecifier* loginSection = [FieldSectionSpecifier sectionWithFields:@[userNameField,passwordField,vendorIdField,selectVendorIdButton] title:NSLocalizedString(@"iTunes Connect Login", nil) description:NSLocalizedString(@"You can import reports via iTunes File Sharing without entering your login.", nil)];
    
    SalesFieldEditorViewController* addAccountController = [[SalesFieldEditorViewController alloc] initWithFieldSections:@[titleSection,loginSection] andTitle:NSLocalizedString(@"New Account", nil)];
    addAccountController.DoneTitle = NSLocalizedString(@"Done", nil);
    addAccountController.cancelTitle = NSLocalizedString(@"Cancel", nil);
    addAccountController.delegate = self;
    addAccountController.editorIdentifier = kAddNewAccountEiditor;
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:addAccountController];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navController animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return 1;
    }
    return self.accounts.count ==0 ? 1 : self.accounts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return self.accounts.count;
    }
    
    if (self.accounts.count == 0) {
        return 0;
    }
    return  2; //为什么是2.。
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return nil;
    }
    
    if (self.accounts.count == 0) {
        return nil;
    }
#warning TODO
    return nil;
}




//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell* cell =
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
