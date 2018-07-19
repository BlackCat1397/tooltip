#import <React/UIView+React.h>
#import "RCTTextView+Menu.h"
#import <objc/runtime.h>

static void * EventDispatcherKey = &EventDispatcherKey;
static void * CallbackKey = &CallbackKey;

@implementation RCTTextView (Menu)

@dynamic _callback;
// use AssociatedObject to add _eventDispatcher property on RCTText.
// need _eventDispatcher for initWithEventDispatcher below.

- (RCTEventDispatcher *)_eventDispatcher {
    return objc_getAssociatedObject(self, EventDispatcherKey);
}

- (void)set_eventDispatcher:(RCTEventDispatcher *)_eventDispatcher {
    objc_setAssociatedObject(self, EventDispatcherKey, _eventDispatcher, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RCTResponseSenderBlock)_callback {
  return objc_getAssociatedObject(self, @selector(_callback));
}

- (void)set_callback:(RCTResponseSenderBlock)_callback {
  objc_setAssociatedObject(self, @selector(_callback), _callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)_items {
  return objc_getAssociatedObject(self, @selector(_items));
}

- (void)set_items:(NSArray *)_items {
  objc_setAssociatedObject(self, @selector(_items), _items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
    if ((self = [self initWithFrame:CGRectZero])) {
        self._eventDispatcher = eventDispatcher;
    }
    
    return self;
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)tappedMenuItem:(NSString *)text {
  NSLog(@"Tapped '%@'", text);
  RCTResponseSenderBlock selfCallback = self._callback;
  NSArray* selfItems = self._items;
  NSUInteger res = [selfItems indexOfObject:text];
  selfCallback(@[[NSNull null], @(res)]);
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
