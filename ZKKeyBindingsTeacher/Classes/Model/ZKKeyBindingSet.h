//
//  ZKKeyBindingSet.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 06/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKKeyBindingSet : NSObject

@property (nonatomic, strong, readonly) NSDictionary *keyBindingGroupsByTitle;

+ (instancetype)xcodeKeyBindingSet;

- (NSArray *)selectedKeyBindings;

@end
