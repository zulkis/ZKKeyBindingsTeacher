//
//  ZKKeyBindingGroup.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 02/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingGroup.h"
#import "ZKKeyBinding.h"

@interface ZKKeyBindingGroup ()

@property (nonatomic, strong) NSMutableArray *mutableKeyBindigns;

@end

@implementation ZKKeyBindingGroup

+ (instancetype)groupWithTitle:(NSString *)title {
    ZKKeyBindingGroup *this = [self new];
    this.title = title;
    return this;
}

- (void)addKeyBinding:(ZKKeyBinding *)keyBinding {
    if (!self.mutableKeyBindigns) {
        self.mutableKeyBindigns = [NSMutableArray new];
    }
    NSLog(@"Added %@ to %@ group", keyBinding.title, self.title);
    [self.mutableKeyBindigns addObject:keyBinding];
}

- (NSArray *)keyBindings {
    return [self.mutableKeyBindigns copy];
}

- (void)setAllKeyBindingsSelected:(BOOL)selected {
    for (ZKKeyBinding *kb in self.mutableKeyBindigns) {
        kb.selected = selected;
    }
}

- (ZKSelectionState)state {
    BOOL atLeastOneSelected = NO;
    BOOL atLeastOneDeselected = NO;
    for (ZKKeyBinding *kb in self.mutableKeyBindigns) {
        if (kb.selected) {
            atLeastOneSelected = YES;
        } else {
            atLeastOneDeselected = YES;
        }
    }
    if (atLeastOneSelected && atLeastOneDeselected) {
        return ZKMixedState;
    } else if (atLeastOneSelected) {
        return ZKSelectedState;
    } else {
        return ZKDeselectedState;
    }
}

@end
