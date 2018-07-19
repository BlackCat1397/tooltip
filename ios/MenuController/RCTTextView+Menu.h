#import <UIKit/UIKit.h>
#import <React/RCTEventDispatcher.h>
#import "./../../node_modules/react-native/Libraries/Text/Text/RCTTextView.h"

@class RCTEventDispatcher;

@interface RCTTextView (Menu)

// is it ok to have it as a property instead of ivar?
// doesn't work without having this as property.
@property (nonatomic, strong) RCTEventDispatcher *_eventDispatcher;

@property (nonatomic, strong) RCTResponseSenderBlock _callback;

@property (nonatomic, strong) NSArray *_items;

- (void)tappedMenuItem:(NSString *)text;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher;
@end
