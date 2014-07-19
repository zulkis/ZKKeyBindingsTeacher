//
//  ZKKeyBindingSelectAllCellView.h
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 14/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZKKeyBindingSelectAllCellView : NSTableCellView

@property (nonatomic, strong, readonly) IBOutlet NSButton *checkAllButton;

@end
