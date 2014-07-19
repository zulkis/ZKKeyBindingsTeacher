//
//  ZKKeyBindingTableCellView.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 01/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZKKeyBindingTableCellView : NSTableCellView

@property (nonatomic, weak) IBOutlet NSTextField *titleTextField;
@property (nonatomic, weak) IBOutlet NSTextField *shortcutTextField;
@property (nonatomic, weak) IBOutlet NSButton *checkboxButton;

@property (nonatomic, copy) void(^onSelectionChanged)(BOOL selected);

@end
