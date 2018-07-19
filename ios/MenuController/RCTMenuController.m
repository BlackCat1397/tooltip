//
//  RCTMenuController.m
//  Popup
//
//  Created by Roman Pavlov on 7/11/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTUIManager.h>
//#import </Users/rpavlov/Documents/Sharekey/Popup/node_modules/react-native/Libraries/Text/Text/RCTTextView.h>
#import "RCTMenuController.h"
#import "RCTView+Menu.h"
#import "RCTTextView+Menu.h"

@implementation MenuController

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return _bridge.uiManager.methodQueue;
}


RCT_EXPORT_METHOD(show: (NSNumber * _Nonnull)reactTag items: (NSArray *)items callback: (RCTResponseSenderBlock)callback)
{
  [_bridge.uiManager addUIBlock: ^(RCTUIManager *uiManager, NSDictionary *viewRegistry)
   {
     //RCTTextView *view = viewRegistry[reactTag];
     RCTView *view = viewRegistry[reactTag];
     view._callback = callback;
     view._items = items;
     NSArray *buttons = items;
     NSMutableArray *menuItems = [NSMutableArray array];
     for (NSString *buttonText in buttons) {
       NSString *sel = [NSString stringWithFormat:@"magic_%@", buttonText];
       
       [menuItems addObject:[[UIMenuItem alloc]
                  initWithTitle:buttonText
                  action:NSSelectorFromString(sel)]];
     }
     
     _Bool t = true;
     t = [view becomeFirstResponder];
     UIMenuController *menuCont = [UIMenuController sharedMenuController];
     
     //Задаем таргет
     [menuCont setTargetRect:view.frame inView:view.superview];
    
     //Рисуем меню
     menuCont.arrowDirection = UIMenuControllerArrowDown;
     menuCont.menuItems = menuItems;
     [menuCont setMenuVisible:YES animated:YES];
   }
   ];
}

//{
//  [_bridge.uiManager addUIBlock:
//   ^(RCTUIManager *uiManager, RCTSparseArray *viewRegistry)
//   {
//     //Получаем нужную вьюху по тегу. Как это сделать?
//     RCTText *view = viewRegistry[reactTag];
//     if (!view) {
//       RCTLogError(@"Cannot find view with tag #%@", reactTag);
//       return;
//     }
//
//     NSArray *buttons = items;
//     //Почему квадратные скобки? Вызов конструктора что-ли?
//     NSMutableArray *menuItems = [NSMutableArray array];
//     for (NSString *buttonText in buttons) {
//       //magic????????????
//       NSString *sel = [NSString stringWithFormat:@"magic_%@", buttonText];
//
//       //KMP
//       [menuItems addObject:[[UIMenuItem alloc]
//                             initWithTitle:buttonText
//                             action:NSSelectorFromString(sel)]];
//       //Откуда селектор знает про коллбэк?
//     }
//
//     //Всм?! Так можно?! А как же canBecomeFirstResponder??
//     [view becomeFirstResponder];
//
//     //Получаем меню
//     UIMenuController *menuCont = [UIMenuController sharedMenuController];
//
//     //Задаем таргет
//     [menuCont setTargetRect:view.frame inView:view.superview];
//
//     //Рисуем меню
//     menuCont.arrowDirection = UIMenuControllerArrowDown;
//     menuCont.menuItems = menuItems;
//     [menuCont setMenuVisible:YES animated:YES];
//   }
//   ];
//}

@end
