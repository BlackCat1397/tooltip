//
//  RCTToolTipText.m
//  ToolTipMenu
//
//  Created by Chirag Jain on 5/15/15.
//  Copyright (c) 2015 Chirag Jain. All rights reserved.
//

#import "RCTToolTipText.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"

@implementation RCTToolTipText

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
    if ((self = [super initWithFrame:CGRectZero])) {
        self._eventDispatcher = eventDispatcher;
    }
    
    return self;
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)tappedMenuItem:(NSString *)text {
    [self._eventDispatcher sendTextEventWithType:RCTTextEventTypeChange
                                        reactTag:self.reactTag
                                            text:text];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSString *sel = NSStringFromSelector(action);
    NSRange match = [sel rangeOfString:@"magic_"];
    if (match.location == 0) {
        return YES;
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if ([super methodSignatureForSelector:sel]) {
        return [super methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:@selector(tappedMenuItem:)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *sel = NSStringFromSelector([invocation selector]);
    NSRange match = [sel rangeOfString:@"magic_"];
    if (match.location == 0) {
        [self tappedMenuItem:[sel substringFromIndex:6]];
    } else {
        [super forwardInvocation:invocation];
    }
}


@end
