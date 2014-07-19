//
//  ZKKeyboardShortcut.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 06/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyboardShortcut.h"

@implementation ZKKeyboardShortcut

+ (instancetype)keyboardShortcutWithIDEKeyboardShortcut:(id<IDEKeyboardShortcut>)shortcut {
    ZKKeyboardShortcut *this = [self new];
    [self new];
    this.stringRepresentation = shortcut.stringRepresentation;
    this.humanRedableName = shortcut.humanRedableName;
    this.localizedDisplayName = shortcut.localizedDisplayName;
    this.displayName = shortcut.displayName;
    this.localizedModifierMaskDisplayName = shortcut.localizedModifierMaskDisplayName;
    this.modifierMaskDisplayName = shortcut.modifierMaskDisplayName;
    this.localizedKeyEquivalentDisplayName = shortcut.localizedKeyEquivalentDisplayName;
    this.keyEquivalentDisplayName = shortcut.keyEquivalentDisplayName;
    
    this.modifierMask = shortcut.modifierMask;
    this.keyEquivalent = shortcut.keyEquivalent;
    
    return this;
}

@end
