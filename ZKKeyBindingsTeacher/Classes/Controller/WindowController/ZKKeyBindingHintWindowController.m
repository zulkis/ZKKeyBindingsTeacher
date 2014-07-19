//
//  ZKKeyBindingHintWindowController.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 14/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingHintWindowController.h"
#import "ZKKeyBindingSet.h"
#import "ZKKeyBinding.h"
#import "ZKKeyboardShortcut.h"

#import "ZKKeyBindingsEditorController.h"

#import "ZKKeyBindingsController.h"

@interface ZKKeyBindingHintWindowController ()

@property (nonatomic) BOOL editingInProgress;

@property (nonatomic) NSUInteger modifierFlags;

@property (nonatomic, strong) id modifierFlagsMonitor;
@property (nonatomic, strong) NSArray *selectedKeyBindings;

@property (nonatomic, strong) IBOutlet ZKKeyBindingsController *keyBindingsController;

@property (nonatomic, strong) id willStartEditingNotificationIdentifier;
@property (nonatomic, strong) id didEndEditingNotificationIdentifier;

@end

@implementation ZKKeyBindingHintWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"ZKKeyBindingHintWindowController"];
    if (self) {
        [self updateSelectedKeyBindings];
        
        self.willStartEditingNotificationIdentifier = [[NSNotificationCenter defaultCenter] addObserverForName:ZKKeyBindingWindowControllerWillStartEditing object:nil queue:nil usingBlock:^(NSNotification *note) {
            self.editingInProgress = YES;
        }];
        self.didEndEditingNotificationIdentifier = [[NSNotificationCenter defaultCenter] addObserverForName:ZKKeyBindingWindowControllerDidEndEditing object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self updateSelectedKeyBindings];
            self.editingInProgress = NO;
        }];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self.keyBindingsController setContent:self.selectedKeyBindings];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.willStartEditingNotificationIdentifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self.didEndEditingNotificationIdentifier];
}

#pragma mark - Work

- (void)listenForModiferKeyChanges {
    self.modifierFlagsMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSFlagsChangedMask handler:^NSEvent *(NSEvent *event) {
        [self updateBindingsWithModifiersFlags:event.modifierFlags];
        return event;
    }];
}

#pragma mark - Update bindings with modifiers

/* Device-independent bits found in event modifier flags
 enum {
 NSAlphaShiftKeyMask         = 1 << 16,
 NSShiftKeyMask              = 1 << 17,
 NSControlKeyMask            = 1 << 18,
 NSAlternateKeyMask          = 1 << 19,
 NSCommandKeyMask            = 1 << 20,
 NSNumericPadKeyMask         = 1 << 21,
 NSHelpKeyMask               = 1 << 22,
 NSFunctionKeyMask           = 1 << 23,
 NSDeviceIndependentModifierFlagsMask    = 0xffff0000UL
 };
 */

- (void)updateSelectedKeyBindings {
    self.selectedKeyBindings = [[ZKKeyBindingSet xcodeKeyBindingSet] selectedKeyBindings];
}

- (void)updateKeyBindingsContent {
    NSMutableArray *bindings = [NSMutableArray array];
    for (ZKKeyBinding *kb in self.selectedKeyBindings) {
        BOOL goodEnough = NO;
        for (ZKKeyboardShortcut *sc in kb.shortcuts) {
            if ((sc.modifierMask & self.modifierFlags) == self.modifierFlags) {
                goodEnough = YES;
                break;
            }
        }
        if (goodEnough) {
            [bindings addObject:kb];
        }
    }
    [self.keyBindingsController setContent:bindings];
    
}

- (void)updateBindingsWithModifiersFlags:(NSUInteger)modifierFlags {
    self.modifierFlags = modifierFlags & NSDeviceIndependentModifierFlagsMask;
    if (!self.editingInProgress &&
            (
             modifierFlags & NSShiftKeyMask ||
             modifierFlags & NSControlKeyMask ||
             modifierFlags & NSAlternateKeyMask ||
             modifierFlags & NSCommandKeyMask
             )
        ) {
        [self updateKeyBindingsContent];
        [self showWindowOnCurrentScreen];
    } else {
        [self.window close];
    }
}

- (void)showWindowOnCurrentScreen {
    CGRect frame = self.window.frame;
    frame.size.height = [NSScreen mainScreen].visibleFrame.size.height;
    [self.window setFrame:frame display:YES];
    [self.window makeKeyAndOrderFront:self];
}

- (void)setCanShowHintWindow:(BOOL)canShow {
    if (canShow) {
        [self listenForModiferKeyChanges];
    } else {
        [NSEvent removeMonitor:self.modifierFlagsMonitor];
    }
}

@end
