//
//  ZKKeyBindingsTeacher.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 28/06/14.
//    Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingsTeacher.h"
#import "ZKKeyBindingSet.h"

#import "ZKKeyBindingsEditorController.h"
#import "ZKKeyBindingHintWindowController.h"

static NSString *ZKKeyBindingsTeacherEnabled = @"ZKKeyBindingsTeacherEnabled";

static ZKKeyBindingsTeacher *sharedPlugin;

@interface ZKKeyBindingsTeacher()

@property (nonatomic, retain) ZKKeyBindingsEditorController *editorController;
@property (nonatomic, retain) ZKKeyBindingHintWindowController *hintWindowController;

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end

@implementation ZKKeyBindingsTeacher

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedInstance {
    return sharedPlugin;
}
 
- (instancetype)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
        
        if (NSApp && !NSApp.mainMenu) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidFinishLaunching:)
                                                         name:NSApplicationDidFinishLaunchingNotification
                                                       object:nil];
        }
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    [self initialize];
}

- (void)initialize {
    self.editorController = [ZKKeyBindingsEditorController new];
    self.hintWindowController = [ZKKeyBindingHintWindowController new];
    
    BOOL teacherEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:ZKKeyBindingsTeacherEnabled];
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"View"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *teachMeHotkeysMenuItem = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Teach me key bindings", nil) action:@selector(teachMeHotkeysEnabled:) keyEquivalent:@""];
        [teachMeHotkeysMenuItem setTarget:self];
        [[menuItem submenu] addItem:teachMeHotkeysMenuItem];
        
        NSMenuItem *modifyKeyBindingsMenuItem = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Modify key bindings", nil) action:@selector(modifyKeyBindings:) keyEquivalent:@""];
        [modifyKeyBindingsMenuItem setTarget:self];
        [[menuItem submenu] addItem:modifyKeyBindingsMenuItem];
    }
    
    if (teacherEnabled) {
        [self startLesson];
    }
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	if ([menuItem action] == @selector(teachMeHotkeysEnabled:)) {
		[menuItem setState:[[NSUserDefaults standardUserDefaults] boolForKey:ZKKeyBindingsTeacherEnabled] ? NSOnState : NSOffState];
	}
	return YES;
}

- (void)teachMeHotkeysEnabled:(id)sender
{
	BOOL wasEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:ZKKeyBindingsTeacherEnabled];
	[[NSUserDefaults standardUserDefaults] setBool:!wasEnabled forKey:ZKKeyBindingsTeacherEnabled];
	if (!wasEnabled) {
		[self startLesson];
	} else {
        [self stopLesson];
	}
}

- (void)modifyKeyBindings:(id)sender {
    [self.editorController.window makeKeyAndOrderFront:self];
}

#pragma mark - Main Plugin methods

- (void)startLesson {
    [self.hintWindowController setCanShowHintWindow:YES];
}

- (void)stopLesson {
    [self.hintWindowController setCanShowHintWindow:NO];
}

- (void)dealloc
{
    [self stopLesson];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
