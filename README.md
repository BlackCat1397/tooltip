# tooltip
React-native wrapper for iOS [UIMenuController](https://developer.apple.com/documentation/uikit/uimenucontroller).

Completely based on [chirag04/tooltip](https://github.com/chirag04/tooltip) project.
Updated to React-native 0.56.0.
Provides easy way to interaction: on menu option tap passes index of taped option to callback.

Text component is not having onChange so we use category on RCTText to add eventDispatcher on it.

TooltipMenu module will show the uimenucontroller on the text component and call the selector in RCTText which will emit the change event.

# How it works
We use [Objective-C category](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Category.html) on `RCTView+Menu.m` and `RCTTextView+Menu.m` to override [`canBecomeFirstResponder` property](https://developer.apple.com/documentation/uikit/uiresponder/1621130-canbecomefirstresponder) (which is nescessary to show menu) and to add [functions which handles menu tap](https://stackoverflow.com/questions/9146670/ios-uimenucontroller-uimenuitem-how-to-determine-item-selected-with-generic-sel).

# Api

```
const EditMenu = NativeModules.MenuController;



In render:
<Text
    onLongPress={event => handleLongPress(event)}
  />

Show the menu on focus:

handleLongPress: function(event) {
  EditMenu.show(event.target, ['x', 'z'], (error, result)=>alert(result));
},
  
```

# Using with touchable
If you want to show this menu from touchable element with multiple nested elements you'll notice that `event.target` is not touchable but nested elemnt on which you tap.
To prevent this add `pointerEvents="none"` to nested elements.

# Credits

This was only possible because of help from
 
 [@chirag04](https://github.com/chirag04)
 [@brentvatne](https://github.com/brentvatne)
 [@ide](https://github.com/ide)
 [@robertjpayne](https://github.com/robertjpayne)

# Search tags
React-native edit menu iOS
React-native popup menu iOS
React-native tooltip menu iOS
React-native text menu iOS
