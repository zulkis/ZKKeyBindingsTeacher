//
//  ZKKeyBindingGroup.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 02/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZKSelectionState) {
    ZKMixedState = NSMixedState,
    ZKSelectedState = NSOnState,
    ZKDeselectedState = NSOffState
};

@class ZKKeyBinding;

@interface ZKKeyBindingGroup : NSObject

@property (nonatomic, readonly) ZKSelectionState state;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong, readonly) NSArray *keyBindings;

+ (instancetype)groupWithTitle:(NSString *)title;

- (void)addKeyBinding:(ZKKeyBinding *)keyBinding;

- (void)setAllKeyBindingsSelected:(BOOL)selected;

@end
