//
//  ZKKeyBindingStorage.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 14/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKKeyBinding, ZKKeyBindingGroup;

@interface ZKKeyBindingStorage : NSObject

+ (instancetype)sharedStorage;

- (void)setKeyBindingGroup:(ZKKeyBindingGroup *)group selected:(BOOL)selected;
- (void)setKeyBinding:(ZKKeyBinding *)keyBinding selected:(BOOL)selected;

- (BOOL)keyBindgingSelected:(ZKKeyBinding *)keyBinding;
- (BOOL)keyBindgingGroupSelected:(ZKKeyBindingGroup *)group;

@end
