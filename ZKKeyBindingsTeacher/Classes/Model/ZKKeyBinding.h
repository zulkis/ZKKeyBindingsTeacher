//
//  ZKKeyBinding.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 30/06/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDEKeyBindingPreferenceSet.h"

@interface ZKKeyBinding : NSObject

@property (nonatomic) BOOL selected;
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *shortcuts;

@property (nonatomic, copy, readonly) NSString *shortcutsDisplayNames;

- (instancetype)initWithIDEKeyBinding:(id<IDEKeyBinding>)binding;

@end
