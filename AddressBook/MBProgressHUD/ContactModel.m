//
//  ContactModel.m
//  StoryboardLogin
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
