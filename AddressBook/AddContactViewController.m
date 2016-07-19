//
//  AddContactViewController.m
//  ContactLish
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import "AddContactViewController.h"
#import "ContactModel.h"

@interface AddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameFiled];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void)textChange
{
    if (self.nameFiled.text.length && self.phoneField.text.length) {
        self.addBtn.enabled = YES;
    }
    else
    {
        self.addBtn.enabled = NO;
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

- (IBAction)addAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(addContactOfController:addContact:)]) {
        ContactModel *model = [[ContactModel alloc]init];
        model.name = self.nameFiled.text;
        model.phone = self.phoneField.text;
        [self.delegate addContactOfController:self addContact:model];
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
