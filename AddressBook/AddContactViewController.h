//
//  AddContactViewController.h
//  ContactLish
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController,ContactModel;
@protocol AddContactDelegate <NSObject>

- (void)addContactOfController:(UIViewController *)controller addContact:(ContactModel *)model;

@end

@interface AddContactViewController : UIViewController
@property (nonatomic,assign)id<AddContactDelegate> delegate;

@end
