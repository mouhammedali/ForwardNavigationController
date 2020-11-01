<!--
  Title: ForwardNavigationController
  Description: A UINavigationController subclass, to support push to history view controller, with right to left slide gesture
     Author: mouhammedali
  -->
<meta name='keywords' content='iOS, naivgation, controller, push, slide, RTL, history, previous, UINavigationController, UIVViewController, swift regexp'>

# ForwardNavigationController

[![CI Status](https://img.shields.io/travis/mouhammedali/ForwardNavigationController.svg?style=flat)](https://travis-ci.org/mouhammedali/ForwardNavigationController)
[![Version](https://img.shields.io/cocoapods/v/ForwardNavigationController.svg?style=flat)](https://cocoapods.org/pods/ForwardNavigationController)
[![License](https://img.shields.io/cocoapods/l/ForwardNavigationController.svg?style=flat)](https://cocoapods.org/pods/ForwardNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/ForwardNavigationController.svg?style=flat)](https://cocoapods.org/pods/ForwardNavigationController)
![](https://i.imgur.com/RYAkMra.mp4)
>Forward to any popped viewController with familiar slide gesture

## Features
- slide from right edge to push to the popped viewcontroller
- uses bezire function animation, to replicate UINavigation pop and push animations.
- disable/enable push gesture on indiviual view controllers.
- supports RTL/LTR.
- supports iOS 14 new back history list.
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Usage
you can either use ForwardNavigationController in code or in storyboard.

- **Code**


```swift
let vc = ForwardNavigationController(rootViewController: UIViewController())
```

- **Storyboard**

![](https://i.imgur.com/f7KfGCL.png)

- **Disable Push gesture if needed**

```swift
(self.navigationController as? ForwardNavigationController)?.allowForward = false
```


## Requirements
iOS 9.0+

## Installation

ForwardNavigationController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ForwardNavigationController'
```

## Author

mouhammedali, mouhammedaliamer@gmail.com

## License

ForwardNavigationController is available under the MIT license. See the LICENSE file for more info.
