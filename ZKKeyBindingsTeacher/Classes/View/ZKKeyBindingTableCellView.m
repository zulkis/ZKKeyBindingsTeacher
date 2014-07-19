//
//  ZKKeyBindingTableCellView.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 01/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingTableCellView.h"

@interface ZKKeyBindingTableCellView ()

@property (nonatomic, strong) IBOutlet NSView *separatorView;

@end

@implementation ZKKeyBindingTableCellView

- (void)awakeFromNib {
    if (self.separatorView) {
        CALayer *layer = self.separatorView.layer;
        CGColorRef color = [NSColor colorWithCalibratedWhite:1.f alpha:0.2].CGColor;
        layer.backgroundColor = color;
    }
}

- (IBAction)onSelectionChanged:(NSButton *)sender {
    if (self.onSelectionChanged) {
        self.onSelectionChanged((BOOL)sender.state);
    }
}

@end
