//
//  SalesFieldEditorViewController.m
//  Sales
//
//  Created by feng on 15/7/31.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "SalesFieldEditorViewController.h"
#import "FieldSpecifier.h"
#import "FieldSectionSpecifier.h"
#import "UIView+Frame.h"

static NSString* kCellIndefiner = @"SalesCell";
const NSInteger kTextFieldTag = 1;
const NSInteger kSwitchTag = 2;

@interface SalesFieldEditorViewController ()

@property(nonatomic,strong,readwrite)UITextField* selectedTextField;
@property(nonatomic,strong,readwrite)NSMutableDictionary* values;

-(void)Done;
-(void)Cancel;
-(void)switchValueDidChange:(NamedSwitch *)swtich;
@end

@implementation SalesFieldEditorViewController

-(id)initWithFieldSections:(NSArray *)sections andTitle:(NSString *)title
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (nil != self) {
        self.title = title;
        self.values = [NSMutableDictionary new];
        self.fieldSections = sections;
        for (FieldSectionSpecifier *spSection in self.fieldSections) {
            NSArray* fileds = spSection.fields;
            for (FieldSpecifier* field in fileds) {
                NSString* key = field.key;
                id defultValue = field.defaultValue;
                if (nil != defultValue) {
                    [_values setObject:defultValue forKey:key];
                }
                
                if (field.type == FieldSpecifierType_Section) {
                    NSArray* subSections = field.subSections;
                    for (FieldSectionSpecifier* section in  subSections) {
                        for (FieldSpecifier* field in section.fields) {
                            NSString* key = field.key;
                            id aDefaultValue = field.defaultValue;
                            if (nil != aDefaultValue) {
                                [_values setObject:aDefaultValue forKey:key];
                            }
                        }
                    }
                }
            }
            
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChanged:) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledDidBeginEidting:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dismissKeyboard
{
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.isSubSection) {
        if (self.DoneTitle) {
            UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithTitle:self.DoneTitle style:UIBarButtonItemStyleDone target:self action:@selector(Done)];
            self.navigationItem.rightBarButtonItem = doneBtn;
        }
        if (self.cancelTitle) {
            UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithTitle:self.cancelTitle style:UIBarButtonItemStylePlain target:self action:@selector(Cancel)];
            self.navigationItem.leftBarButtonItem = cancelBtn;
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!self.isSubSection) {
        if (!self.DoneTitle) {
            [self Done];
        }
    }
}

#warning 以后修改
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

/**
 *  确认按钮方法
 */
-(void)Done
{
    if ([self.delegate respondsToSelector:@selector(fieldEditor:didFinishEditingWithVaues:)]) {
        [self.delegate fieldEditor:self didFinishEditingWithVaues:self.values];
    }
}

/**
 *  取消按钮
 */
-(void)Cancel
{
    if ([self.delegate respondsToSelector:@selector(fieldEditorDidCancel:)]) {
        [self.delegate fieldEditorDidCancel:self];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fieldSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FieldSectionSpecifier* fieldSection = [self.fieldSections objectAtIndex:section];
    return fieldSection.fields.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    FieldSectionSpecifier* fieldSection = [self.fieldSections objectAtIndex:section];
    return fieldSection.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    FieldSectionSpecifier* fieldSection = [self.fieldSections objectAtIndex:section];
    return fieldSection.Description;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIndefiner];
    FieldSectionSpecifier* fieldSection = [self.fieldSections objectAtIndex:indexPath.section];
    FieldSpecifier* field = [fieldSection.fields objectAtIndex:indexPath.row];
    if (field.type != FieldSpecifierType_Button && field.type != FieldSpecifierType_Check && field.type != FieldSpecifierType_Section) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = field.title;
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NamedTextFiled* textField = (NamedTextFiled *)[cell.contentView viewWithTag:kTextFieldTag];
    NamedSwitch* switchField = (NamedSwitch *)[cell.contentView viewWithTag:kSwitchTag];
    FieldSectionSpecifier* sectioin = [self.fieldSections objectAtIndex:indexPath.section];
    FieldSpecifier* field = [sectioin.fields objectAtIndex:indexPath.row];
    cell.textLabel.text = field.title;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.accessoryType = UITableViewCellAccessoryNone;
    CGSize labelSize = [field.title sizeWithAttributes:@{NSFontAttributeName:cell.textLabel.font}];
    CGRect textLabelFrame = CGRectMake(10, 0, labelSize.width, 10);
    cell.detailTextLabel.text = @"";
    
    NSString* fieldKey = field.key;
    FieldSpecifierType fieldType = field.type;
    if ((fieldType == FieldSpecifierType_Email) ||
        (fieldType == FieldSpecifierType_Numberic )||
        (fieldType == FieldSpecifierType_Password) ||
        (fieldType == FieldSpecifierType_Text)||
        (fieldType == FieldSpecifierType_URL)) {
        if (nil == textField) {
            CGRect textFieldFrame = CGRectMake(textLabelFrame.origin.x + textLabelFrame.size.width + 10, 11, cell.contentView.Width - textLabelFrame.size.width - textLabelFrame.origin.x - 20 , 25);
            textField = [[NamedTextFiled alloc] initWithFrame:textFieldFrame];
            [cell.contentView addSubview:textField];
        }
        if (self.navigationController.navigationBar.barStyle == UIBarStyleBlack) {
            textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        }else{
            textField.keyboardAppearance = UIKeyboardAppearanceDefault;
        }
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        textField.textColor = cell.detailTextLabel.textColor;
        textField.tag = kTextFieldTag;
        textField.name = fieldKey;
        textField.text = [self.values objectForKey:fieldKey];
        textField.autocorrectionType = UITextAutocorrectionTypeNo;//禁止出现单词矫正
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;//禁止大写开头
        textField.clearButtonMode = UITextFieldViewModeWhileEditing; //开始编辑时，出现清除按钮
        textField.delegate = self;
        switch (fieldType) {
            case FieldSpecifierType_Email:
            {
                textField.placeholder = NSLocalizedString(@"example@domain.com", nil);
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                textField.secureTextEntry = NO;
            }
            break;
            case  FieldSpecifierType_Password:
            {
                textField.placeholder = @"";
                textField.keyboardType = UIKeyboardTypeAlphabet;
                textField.secureTextEntry = YES;
            }
            break;
            case FieldSpecifierType_URL:
            {
                textField.placeholder = NSLocalizedString(@"www.example.com", nil);
                textField.keyboardType = UIKeyboardTypeURL;
                textField.secureTextEntry = NO;
            }
            break;
            case FieldSpecifierType_Text:
            {
                textField.placeholder = @"";
                textField.keyboardType = UIKeyboardTypeDefault;
                textField.secureTextEntry = NO;
            }
            break;
            case FieldSpecifierType_Numberic:
            {
                textField.placeholder = @"";
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.secureTextEntry = NO;
            }
            default:
                break;
        }
        if ( nil != field.placeHolder) {
            textField.placeholder = field.placeHolder;
        }
    }else if (fieldType == FieldSpecifierType_Switch)
    {
        if (nil == switchField) {
            switchField = [NamedSwitch new];
            [cell.contentView addSubview:switchField];
            [switchField addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
        }
        CGRect switchFrame = CGRectMake(cell.contentView.Width - switchField.Width - 8, 8, switchField.Width, switchField.Height);
        switchField.frame = switchFrame;
        switchField.tag = kSwitchTag;
        switchField.name = fieldKey;
        switchField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        BOOL value = [[self.values objectForKey:fieldKey] boolValue];
        [switchField setOn:value];
    }else if (fieldType == FieldSpecifierType_Section)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (field.subSections.count == 1) {
            FieldSectionSpecifier *subSection = [field.subSections lastObject];
            if ([subSection exclusiveSelection]) {
                NSArray* subSectinoFields = subSection.fields;
                for (FieldSpecifier * aField in subSectinoFields) {
                    if ([[self.values objectForKey:aField.key] boolValue]) {
                        cell.detailTextLabel.text = aField.title;
                        break;
                    }
                }
            }
        }
    }else if(fieldType == FieldSpecifierType_Button)
    {
        cell.detailTextLabel.text = field.defaultValue;
    }
    
    if (fieldType == FieldSpecifierType_Button && field.shouldDisplayDisclosureIndicator) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FieldSectionSpecifier* fieldSection = [self.fieldSections objectAtIndex:indexPath.section];
    FieldSpecifier* field = [fieldSection.fields objectAtIndex:indexPath.row];
    UITableViewCell* tableCell = [tableView cellForRowAtIndexPath:indexPath];
    NamedTextFiled* textField = (NamedTextFiled *)[tableCell viewWithTag:kTextFieldTag];
    if (nil != textField) {
        [textField becomeFirstResponder];
        self.selectedTextField = textField;
    }
    
    if (field.type == FieldSpecifierType_Button) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([self.delegate respondsToSelector:@selector(fieldEditor:presseButtonWithKey:)]) {
            [self.delegate fieldEditor:self presseButtonWithKey:field.key];
        }
    }
}

#pragma mark -输入框通知消息
-(void)textFiledChanged:(NSNotification *)values
{
    if ([[values object] isKindOfClass:[NamedTextFiled class]] ) {
        self.hasChange = YES;
        NamedTextFiled* textField = [values object];
        NSString* name = textField.name;
        [self.values setObject:textField.name forKey:name];
    }
}

-(void)textFiledDidBeginEidting:(NSNotification*)values
{
    if ([[values object] isKindOfClass:[NamedTextFiled class]]) {
        NamedTextFiled* textField = [values object];
        NSString* name = textField.name;
        int row = 0;
        int section = 0;
        BOOL isFound = NO;
        for (FieldSectionSpecifier* fieldSection in self.fieldSections) {
            for (FieldSpecifier* field in fieldSection.fields) {
                if ([field.key isEqualToString:name]) {
                    isFound = YES;
                    break;
                }
                row++;
            }
            if (isFound) {
                break;
            }
            section++;
            row = 0;
        }
        
        if (isFound) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.selectedTextField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField performSelector:@selector(resignFirstResponder) withObject:nil];
    self.selectedTextField = nil;
    return YES;
}

@end
