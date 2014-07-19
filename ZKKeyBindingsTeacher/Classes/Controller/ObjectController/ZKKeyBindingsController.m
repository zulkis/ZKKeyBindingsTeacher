//
//  ZKKeyBindingsController.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 10/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingsController.h"

@implementation ZKKeyBindingsController

- (void)setContent:(id)content {
    [super setContent:content];
    [self rearrangeObjects];
}

@end
