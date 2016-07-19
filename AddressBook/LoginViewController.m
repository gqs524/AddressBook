//
//  LoginViewController.m
//  ContactLish
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+WT.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;
@property (weak, nonatomic) IBOutlet UISwitch *rembSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)loginAction;
@end

#define UserNameKey @"name"
#define PwdKey @"pwd"
#define RembPwdKey @"remb_key"


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameFiled];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdFiled];
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    self.nameFiled.text = [userdefaults valueForKey:UserNameKey];
//    self.pwdFiled.text = [userdefaults valueForKey:PwdKey];
    self.rembSwitch.on = [userdefaults boolForKey:RembPwdKey];
    if (self.rembSwitch.isOn) {
        self.pwdFiled.text = [userdefaults valueForKey:PwdKey];
        self.loginBtn.enabled = YES;
    }
}

- (void)textChange
{
    if (self.nameFiled.text.length && self.pwdFiled.text.length) {
        self.loginBtn.enabled = YES;
    }
    else
    {
        self.loginBtn.enabled = NO;
    }
    //    self.loginBtn.enabled = self.nameFiled.text.length && self.pwdField.text.length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *contactVc = segue.destinationViewController;
    contactVc.title = [NSString stringWithFormat:@"%@的联系人",self.nameFiled.text];
}


- (IBAction)loginAction {
    if (![self.nameFiled.text isEqualToString:@"gqs"]) {
        [MBProgressHUD showError:@"账户不存在" toView:self.view];
        return;
    }
    if (![self.pwdFiled.text isEqualToString:@"gqs"]) {
        [MBProgressHUD showError:@"密码错误" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMessag:@"加载中" toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
        
    });
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameFiled.text forKey:UserNameKey];
    [defaults setObject:self.pwdFiled.text forKey:PwdKey];
    [defaults setBool:self.rembSwitch.isOn forKey:RembPwdKey];
    [defaults synchronize];
    
}
@end
