//
//  ZKKeyboardShortcut.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 06/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDEKeyBindingPreferenceSet.h"

@interface ZKKeyboardShortcut : NSObject

@property(nonatomic, copy) NSString *stringRepresentation;
@property(nonatomic, copy) NSString *humanRedableName;
@property(nonatomic, copy) NSString *localizedDisplayName;
@property(nonatomic, copy) NSString *displayName;
@property(nonatomic, copy) NSString *localizedModifierMaskDisplayName;
@property(nonatomic, copy) NSString *modifierMaskDisplayName;
@property(nonatomic, copy) NSString *localizedKeyEquivalentDisplayName;
@property(nonatomic, copy) NSString *keyEquivalentDisplayName;

@property(nonatomic) unsigned long long modifierMask;
@property(nonatomic, copy) NSString *keyEquivalent;

+ (instancetype)keyboardShortcutWithIDEKeyboardShortcut:(id<IDEKeyboardShortcut>)shortcut;

@end
