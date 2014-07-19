//
//  ZKKeyBindingSet.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 06/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingSet.h"
#import "ZKKeyBinding.h"
#import "ZKKeyBindingGroup.h"
#import "ZKKeyBindingStorage.h"

#import "IDEKeyBindingPreferenceSet.h"

@interface ZKKeyBindingSet () {
    NSDictionary *_keyBindingGroupsByTitle;
}

@property (nonatomic, strong) NSMutableDictionary *mutableKeyBindingGroupsByTitle;

@end

@implementation ZKKeyBindingSet

ZKKeyBindingSet *_keyBindingSet = nil;

+ (void)initialize {
    [self xcodeKeyBindingSet];
}

+ (instancetype)xcodeKeyBindingSet {
    if (!_keyBindingSet) {
        Class<IDEKeyBindingPreferenceSet> _IDEKeyBindingPreferenceSet = NSClassFromString(@"IDEKeyBindingPreferenceSet");
        
        id<IDEKeyBindingPreferenceSet> prefSet = [[_IDEKeyBindingPreferenceSet preferenceSetsManager] currentPreferenceSet];
        
        id<IDEMenuKeyBindingSet> menuBindingsSet = [prefSet menuKeyBindingSet];
        id<IDETextKeyBindingSet> textBindingsSet = [prefSet textKeyBindingSet];
        
        _keyBindingSet = [[ZKKeyBindingSet alloc] initWithIDEKeyBindings:[menuBindingsSet.keyBindings arrayByAddingObjectsFromArray:textBindingsSet.keyBindings]];
        
    }
    return _keyBindingSet;
    
}

- (instancetype)initWithIDEKeyBindings:(NSArray *)keyBindings {
    self = [super init];
    if (self) {
        self.mutableKeyBindingGroupsByTitle = [NSMutableDictionary new];
        
        ZKKeyBindingStorage *storage = [ZKKeyBindingStorage sharedStorage];
        
        for (id<IDEKeyBinding> binding in keyBindings) {
            ZKKeyBinding *kb = [[ZKKeyBinding alloc] initWithIDEKeyBinding:binding];
            kb.selected = [storage keyBindgingSelected:kb];
            [self addKeyBinding:kb withGroupName:binding.group];
        }
        _keyBindingGroupsByTitle = [self.mutableKeyBindingGroupsByTitle copy];
        
    }
    return self;
}

- (void)addKeyBinding:(ZKKeyBinding *)keyBinding withGroupName:(NSString *)groupName {
    ZKKeyBindingGroup *group = self.mutableKeyBindingGroupsByTitle[groupName];
    if ([[keyBinding.shortcuts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"keyEquivalent.length > 0"]] count] > 0) {
        if (!group) {
            group = [ZKKeyBindingGroup groupWithTitle:groupName];
            self.mutableKeyBindingGroupsByTitle[groupName] = group;
        }
        [group addKeyBinding:keyBinding];
    }
}

- (NSDictionary *)keyBindingGroupsByTitle {
    return _keyBindingGroupsByTitle;
}

- (NSArray *)selectedKeyBindings {
    NSMutableArray *array = [NSMutableArray new];
    for (NSArray *keyBindigns in [[self.keyBindingGroupsByTitle allValues] valueForKey:@"keyBindings"]) {
        NSArray *selectedKeyBindings = [keyBindigns filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"selected = YES"]];
        [array addObjectsFromArray:selectedKeyBindings];
    }
    return [array copy];
}

@end
