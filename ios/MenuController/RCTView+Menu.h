#import <UIKit/UIKit.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTView.h>

@class RCTEventDispatcher;

@interface RCTView (Menu)

@property (nonatomic, strong) RCTEventDispatcher *_eventDispatcher;

@property (nonatomic, strong) RCTResponseSenderBlock _callback;

@property (nonatomic, strong) NSArray *_items;

- (void)tappedMenuItem:(NSString *)text;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher;
@end
