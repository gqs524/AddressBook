//
//  EditContactViewController.h
//  ContactLish
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactModel,EditContactViewController;
@protocol EditDelegate <NSObject>

- (void)editContactController:(UIViewController *)vc editContact:(ContactModel *)model;

@end
@interface EditContactViewController : UIViewController
@property (nonatomic,strong)ContactModel *model;
@property (nonatomic,assign)id<EditDelegate> delegate;
@end
