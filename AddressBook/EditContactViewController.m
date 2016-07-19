//
//  EditContactViewController.m
//  ContactLish
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import "EditContactViewController.h"
#import "ContactModel.h"
@interface EditContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveAction:(id)sender;

- (IBAction)edit:(UIBarButtonItem *)sender;

- (IBAction)backAction:(UIBarButtonItem *)sender;


@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = self.model.name;
    self.phoneField.text = self.model.phone;
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void)textChange
{
    if (self.nameField.text.length && self.phoneField.text.length) {
        self.saveBtn.enabled = YES;
    }
    else
    {
        self.saveBtn.enabled = NO;
    }
    //    self.loginBtn.enabled = self.nameFiled.text.length && self.pwdField.text.length;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(editContactController:editContact:)]) {
        ContactModel *model = [[ContactModel alloc]init];
        model.name = self.nameField.text;
        model.phone = self.phoneField.text;
        [self.delegate editContactController:self editContact:model];
    }
}

- (IBAction)edit:(UIBarButtonItem *)sender {
    if (self.nameField.enabled) {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        sender.title = @"编辑";
        
        self.nameField.text = self.model.name;
        self.phoneField.text = self.model.phone;
    }else
    {
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.view endEditing:NO];
        self.saveBtn.hidden = NO;
        sender.title = @"取消";
    }

}

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
