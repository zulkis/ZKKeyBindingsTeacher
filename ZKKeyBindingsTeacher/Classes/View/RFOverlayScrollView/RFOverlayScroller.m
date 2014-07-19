//
//  RFTransparentScroller.m
//  RFOverlayScrollView
//
//  Created by Tim Brückmann on 30.12.12.
//  Copyright (c) 2012 Rheinfabrik. All rights reserved.
//

#import "RFOverlayScroller.h"

@implementation RFOverlayScroller

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self == nil) {
        return nil;
    }
    [self commonInitializer];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInitializer];
}

- (void)commonInitializer
{
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                                options:(
                                                                         NSTrackingMouseEnteredAndExited
                                                                         | NSTrackingActiveInActiveApp
                                                                         | NSTrackingMouseMoved
                                                                         )
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
}

#define kKnobSlotMargin 3.f

- (void)drawRect:(NSRect)dirtyRect
{
	if ([self usableParts] != NSNoScrollerParts) {
		NSRect rect = [self bounds];
		rect = NSOffsetRect(rect, 0.f, kKnobSlotMargin);
		rect.size.height -= 2 * kKnobSlotMargin;
		[self drawKnobSlotInRect:rect highlight:NO];
		[self drawKnob];
	}
}

- (void)drawKnobSlotInRect:(NSRect)slotRect highlight:(BOOL)flag
{
    
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:slotRect
														 xRadius:0
														 yRadius:0];
	[path fill];
    
}

- (void)drawKnob
{
    NSRect rect = [self rectForPart:NSScrollerKnob];
	[[NSColor colorWithCalibratedWhite:0.4 alpha:1.f] set];
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(rect, kKnobSlotMargin, 0)
														 xRadius:5.f
														 yRadius:5.f];
	[path fill];
}

- (void)setFloatValue:(float)aFloat
{
    [super setFloatValue:aFloat];
    [self.animator setAlphaValue:1.0f];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
    [self performSelector:@selector(fadeOut) withObject:nil afterDelay:1.5f];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    [super mouseExited:theEvent];
    [self fadeOut];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [super mouseEntered:theEvent];
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.1f;
        [self.animator setAlphaValue:1.0f];
    } completionHandler:^{
    }];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	[super mouseMoved:theEvent];
    self.alphaValue = 1.0f;
}

- (void)fadeOut
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.3f;
        [self.animator setAlphaValue:0.0f];
    } completionHandler:^{
    }];
}

+ (BOOL)isCompatibleWithOverlayScrollers
{
    return self == [RFOverlayScroller class];
}

+ (CGFloat)zeroWidth
{
    return 0.0f;
}

@end
