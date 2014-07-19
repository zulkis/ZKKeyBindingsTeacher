//
//  ZKWindowController.m
//  ZKKeyBindingsTeacher
//
//  Created by Alexey Minaev on 01/07/14.
//  Copyright (c) 2014 Alexey Minaev. All rights reserved.
//

#import "ZKKeyBindingsEditorController.h"
#import "ZKKeyBinding.h"
#import "ZKKeyBindingSet.h"
#import "ZKKeyBindingGroup.h"
#import "ZKKeyBindingStorage.h"

#import "ZKKeyBindingGroupController.h"
#import "ZKKeyBindingsController.h"

#import "ZKKeyBindingTableCellView.h"

NSString * const ZKKeyBindingWindowControllerWillStartEditing = @"ZKKeyBindingWindowControllerWillStartEditing";
NSString * const ZKKeyBindingWindowControllerDidEndEditing = @"ZKKeyBindingWindowControllerDidEndEditing";

@interface ZKKeyBindingsEditorController () <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) ZKKeyBindingStorage *keyBindingStorage;

@property (nonatomic, weak) IBOutlet NSTableView *keyBindingGroupsTableView;
@property (nonatomic, weak) IBOutlet NSTableView *groupKeyBindingsTableView;
@property (nonatomic, weak) IBOutlet NSTextField *groupTitleTextField;
@property (nonatomic, weak) IBOutlet NSButton *checkAllButton;

@property (nonatomic, strong) IBOutlet ZKKeyBindingGroupController *keyBindingsGroupController;
@property (nonatomic, strong) IBOutlet ZKKeyBindingsController *keyBindingsController;

@end

@implementation ZKKeyBindingsEditorController

- (id)init
{
    self = [super initWithWindowNibName:@"ZKKeyBindingsEditorController"];
    if (self) {
        self.keyBindingStorage = [ZKKeyBindingStorage sharedStorage];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSDictionary *dict = [ZKKeyBindingSet xcodeKeyBindingSet].keyBindingGroupsByTitle;
    [self.keyBindingsGroupController setContent:[dict allValues]];
    [self updateCheckAllButtonState];
}

- (ZKKeyBindingGroup *)selectedKeyBindingGroup {
    return [self.keyBindingsGroupController keyBindingGroupAtIndex:self.keyBindingGroupsTableView.selectedRow];
}

- (void)updateCheckAllButtonState {
    self.checkAllButton.state = [self selectedKeyBindingGroup].state;
}

#pragma mark - Data Source Bindings

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ZKKeyBindingTableCellView *cell = [tableView makeViewWithIdentifier:@"ZKKeyBindingTableCellView" owner:tableView];
    if (tableView == self.keyBindingGroupsTableView) {

    } else {
        __block ZKKeyBinding *keyBinding = [self.keyBindingsController.content objectAtIndex:row];
        cell.onSelectionChanged = ^(BOOL selected) {
            [self.keyBindingStorage setKeyBinding:keyBinding selected:selected];
            [self updateCheckAllButtonState];
        };
    }
    return cell;
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = notification.object;
    if (tableView == self.keyBindingGroupsTableView) {
        ZKKeyBindingGroup *group = [self selectedKeyBindingGroup];
        self.groupTitleTextField.stringValue = group.title;
        self.keyBindingsController.content = group.keyBindings;
    }
    [self updateCheckAllButtonState];
}

#pragma mark - Check All Action

- (IBAction)onCheckAllButtonTap:(NSButton *)sender {
    BOOL selected = sender.state != 0;
    ZKKeyBindingGroup *group = [self selectedKeyBindingGroup];
    [group setAllKeyBindingsSelected:selected];
    [self.keyBindingStorage setKeyBindingGroup:group
                                      selected:selected];
    [self.groupKeyBindingsTableView reloadData];
    [self updateCheckAllButtonState];
}

#pragma mark - Closing

- (void)windowDidBecomeMain:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:ZKKeyBindingWindowControllerWillStartEditing object:nil];
}

- (void)windowDidResignMain:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:ZKKeyBindingWindowControllerDidEndEditing object:nil];
}

@end
