//
//  ZKKeyBindingStorage.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 14/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingStorage.h"

#import "ZKKeyBinding.h"
#import "ZKKeyBindingGroup.h"

static NSString * const ZKKeyBindingStorageKey = @"ZKKeyBindingStorageKey";

@implementation ZKKeyBindingStorage {
    NSMutableSet *_keyBindingActions;
}

+ (instancetype)sharedStorage {
    static ZKKeyBindingStorage *_storage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _storage = [self new];
    });
    return _storage;
}

- (id)init {
    self = [super init];
    if (self) {
        [self load];
        if (!_keyBindingActions) {
            _keyBindingActions = [NSMutableSet new];
        }
    }
    return self;
}

- (void)setKeyBindingGroup:(ZKKeyBindingGroup *)group selected:(BOOL)selected {
    for (ZKKeyBinding *keyBinding in group.keyBindings) {
        if (selected) {
            [_keyBindingActions addObject:keyBinding.action];
        } else {
            [_keyBindingActions removeObject:keyBinding.action];
        }
    }
    [self save];
}

- (void)setKeyBinding:(ZKKeyBinding *)keyBinding selected:(BOOL)selected {
    if (selected) {
        [_keyBindingActions addObject:keyBinding.action];
    } else {
        [_keyBindingActions removeObject:keyBinding.action];
    }
    [self save];
}

#pragma mark - Checking

- (BOOL)keyBindgingSelected:(ZKKeyBinding *)keyBinding {
    return [_keyBindingActions containsObject:keyBinding.action];
}

- (BOOL)keyBindgingGroupSelected:(ZKKeyBindingGroup *)group {
    for (ZKKeyBinding *keyBinding in group.keyBindings) {
        if (![_keyBindingActions containsObject:keyBinding.action]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Save/Load

- (void)save {
    [[NSUserDefaults standardUserDefaults] setObject:[_keyBindingActions allObjects] forKey:ZKKeyBindingStorageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)load {
    _keyBindingActions = [NSMutableSet setWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:ZKKeyBindingStorageKey]];
}

@end
