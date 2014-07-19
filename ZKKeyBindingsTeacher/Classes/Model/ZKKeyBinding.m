//
//  ZKKeyBinding.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 30/06/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBinding.h"
#import "ZKKeyboardShortcut.h"

#import "IDEKeyBindingPreferenceSet.h"

@implementation ZKKeyBinding

//+ (NSArray *)ideTextKeyBindings {
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:@"/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Resources/IDETextKeyBindingSet.plist"];
//    
//    NSError *error = nil;
//    NSPropertyListFormat *format = NULL;
//    NSDictionary *keyBindingsBySections = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:format error:&error];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//        return nil;
//    }
//    
//    NSMutableArray *ideTextKeyBindings = [NSMutableArray arrayWithCapacity:256];
//    [keyBindingsBySections enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL *stop) {
//        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//            [ideTextKeyBindings addObject:[[ZKKeyBinding alloc] initWithAction:obj shortcut:nil title:key]];
//        }];
//    }];
//    return [ideTextKeyBindings copy];
//}
//
//+ (NSDictionary *)systemwideBindingsObject {
//    NSError *error = nil;
//    NSPropertyListFormat *format = NULL;
//    
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:@"/System/Library/Frameworks/AppKit.framework/Resources/StandardKeyBinding.dict"];
//    NSDictionary *systemwideBindings = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:format error:&error];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//        return nil;
//    }
//    return systemwideBindings;
//}
//
//+ (NSDictionary *)xcodeDefaultBindingsObject {
//    NSError *error = nil;
//    NSPropertyListFormat *format = NULL;
//    
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:@"/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Resources/IDEDefaultKeyBindings.idekeybindings"];
//    
//    NSDictionary *xcodeDefaultBindings = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:format error:&error][@"Text Key Bindings"][@"Key Bindings"];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//        return nil;
//    }
//    return xcodeDefaultBindings;
//}
//
+ (NSArray *)xcodeUserBindingsObject {
    NSError *error = nil;
    NSPropertyListFormat *format = NULL;
    
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:[NSHomeDirectory() stringByAppendingString:@"/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings"]];
    
    NSDictionary *xcodeAllSectionsUserBindings = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:format error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    }
    NSMutableArray *allBindings = [NSMutableArray new];
    
    for (NSString *key in [xcodeAllSectionsUserBindings allKeys]) {
        NSDictionary *bindings = xcodeAllSectionsUserBindings[key];
        for (NSDictionary *dict in bindings[@"Key Bindings"]) {
            [allBindings addObject:dict];
        }
    }
    return allBindings;
}
//
//+ (void)updateBindingsFromObject:(id)object toKeyBindingsArray:(NSMutableArray *)array {
//    NSArray *keyBindings = nil;
//    if ([object isKindOfClass:[NSDictionary class]]) {
//        keyBindings = [self keyBindingsFromDictionary:object];
//    } else if ([object isKindOfClass:[NSArray class]]) {
//        keyBindings = [self keyBindingsFromArray:object];
//    }
//    for (ZKKeyBinding *keyBinding in keyBindings) {
//        for (ZKKeyBinding *existingKeyBinding in array) {
//            if ([keyBinding.action isEqualTo:existingKeyBinding.action] &&
//                [keyBinding.shortcut length] > 0) {
//                existingKeyBinding.shortcut = keyBinding.shortcut;
//            }
//        }
//    }
//}
//
//+ (void)updateOrInsertBindingsFromObject:(id)object toKeyBindingsArray:(NSMutableArray *)array {
//    NSArray *keyBindings = nil;
//    if ([object isKindOfClass:[NSDictionary class]]) {
//        keyBindings = [self keyBindingsFromDictionary:object];
//    } else if ([object isKindOfClass:[NSArray class]]) {
//        keyBindings = [self keyBindingsFromArray:object];
//    }
//    NSMutableArray *sameKeyBindings = [NSMutableArray new];
//    for (ZKKeyBinding *keyBinding in keyBindings) {
//        for (ZKKeyBinding *existingKeyBinding in array) {
//            if ([keyBinding.action isEqualTo:existingKeyBinding.action] &&
//                [keyBinding.shortcut length] > 0) {
//                existingKeyBinding.shortcut = keyBinding.shortcut;
//                [sameKeyBindings addObject:keyBinding];
//            } else if ([keyBinding isEqualTo:existingKeyBinding]) {
//                [sameKeyBindings addObject:keyBinding];
//            }
//        }
//    }
//    NSMutableArray *mutableKeyBindings = [keyBindings mutableCopy];
//    [mutableKeyBindings removeObjectsInArray:sameKeyBindings];
//    [array addObjectsFromArray:mutableKeyBindings];
//}
//
//static NSArray *_allAvailableKeyBindings = nil;
//
//+ (void)prepareAvailableKeyBindings {
//    if (!_allAvailableKeyBindings) {
//        NSMutableArray *allAvailableKeyBindings = [NSMutableArray arrayWithCapacity:256];
//        [allAvailableKeyBindings addObjectsFromArray:[self ideTextKeyBindings]];
//        [self updateBindingsFromObject:[self systemwideBindingsObject] toKeyBindingsArray:allAvailableKeyBindings];
//        
//        [self updateOrInsertBindingsFromObject:[self xcodeDefaultBindingsObject] toKeyBindingsArray:allAvailableKeyBindings];
//        [self updateOrInsertBindingsFromObject:[self xcodeUserBindingsObject] toKeyBindingsArray:allAvailableKeyBindings];
//        
//        _allAvailableKeyBindings = [[allAvailableKeyBindings filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"action != %@ && shortcut.length > 0", @"noop:"]] copy];
//    }
//}
//
//+ (NSArray *)allAvailableKeyBindings {
//    return _allAvailableKeyBindings;
//}

#pragma mark - Multiple creation

//+ (NSArray *)keyBindingsFromDictionary:(NSDictionary *)dict {
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[dict count]];
//    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if ([obj isKindOfClass:[NSArray class]]) { //We can have multiple actions on 1 keybinding
//            NSArray *objectsArray = obj;
//            for (NSString *string in objectsArray) {
//                [array addObject:[[self alloc] initWithAction:string shortcut:key title:nil]];
//            }
//        } else if ([obj isKindOfClass:[NSDictionary class]]){
//            [array addObjectsFromArray:[self keyBindingsFromDictionary:obj]];
//        } else {
//            [array addObject:[[self alloc] initWithAction:obj shortcut:key title:nil]];
//        }
//    }];
//    return [array copy];
//}

+ (NSArray *)keyBindingsFromArray:(NSArray *)bindingsDictArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[bindingsDictArray count]];
    [bindingsDictArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [array addObject:[[self alloc] initWithDictionary:obj]];
    }];
    return [array copy];
}

#pragma mark - Instance creation

- (instancetype)initWithIDEKeyBinding:(id<IDEKeyBinding>)binding {
    self = [super init];
    if (self) {
        self.action = NSStringFromSelector(binding.action);
        self.title = binding.title;
        NSMutableArray *shortcuts = [NSMutableArray new];
        for (id<IDEKeyboardShortcut> shortcut in binding.keyboardShortcuts) {
            ZKKeyboardShortcut *zk_shortcut = [ZKKeyboardShortcut keyboardShortcutWithIDEKeyboardShortcut:shortcut];
            [shortcuts addObject:zk_shortcut];
        }
        self.shortcuts = [shortcuts copy];
    }
    return self;
}

#pragma mark - Accessors

- (NSString *)shortcutsDisplayNames {
    NSArray *names = [self.shortcuts valueForKey:@"localizedDisplayName"];
    return [names componentsJoinedByString:@", "];
}

@end
