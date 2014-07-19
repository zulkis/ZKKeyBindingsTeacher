//
//  ZKKeyBindingGroupController.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 10/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingGroupController.h"

#import "ZKKeyBindingGroup.h"

@implementation ZKKeyBindingGroupController

- (NSArray *)sortDescriptors {
    return @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
}

- (ZKKeyBindingGroup *)keyBindingGroupAtIndex:(NSUInteger)index {
    NSArray *groups = self.arrangedObjects;
    if ([groups count] > 0) {
        return groups[index];
    }
    return nil;
}

- (void)setContent:(id)content {
    [super setContent:content];
    [self rearrangeObjects];
}


@end
