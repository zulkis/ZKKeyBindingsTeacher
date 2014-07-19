//
//  ZKKeyBindingSelectAllCellView.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 14/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingSelectAllCellView.h"

@interface ZKKeyBindingSelectAllCellView ()

@property (nonatomic, strong, readwrite) IBOutlet NSButton *checkAllButton;

@end

@implementation ZKKeyBindingSelectAllCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.checkAllButton setTitle:NSLocalizedString(@"Check All", nil)];
}

@end
