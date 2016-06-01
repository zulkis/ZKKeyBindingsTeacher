//
//  ZKKeyBindingsTeacher.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 28/06/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <AppKit/AppKit.h>

@class ZKKeyBindingsEditorController;

@interface ZKKeyBindingsTeacher : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) NSBundle *bundle;

@end