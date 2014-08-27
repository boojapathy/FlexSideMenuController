# FlexSideMenuController

[![CI Status](http://img.shields.io/travis/boojapathy/FlexSideMenuController.svg?style=flat)](https://travis-ci.org/boojapathy/FlexSideMenuController)
[![Version](https://img.shields.io/cocoapods/v/FlexSideMenuController.svg?style=flat)](http://cocoadocs.org/docsets/FlexSideMenuController)
[![License](https://img.shields.io/cocoapods/l/FlexSideMenuController.svg?style=flat)](http://cocoadocs.org/docsets/FlexSideMenuController)
[![Platform](https://img.shields.io/cocoapods/p/FlexSideMenuController.svg?style=flat)](http://cocoadocs.org/docsets/FlexSideMenuController)

## Usage

Steps to integrate the FlexSideMenu in your project

## Installation

FlexSideMenuController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "FlexSideMenuController"

## Instantiate FlexSideMenu with relevant parameters in AppDelegate
FlexSideMenu *sideMenuController = [[FlexSideMenu alloc] initWithContentViewController:contentViewController leftSideMenuController:leftViewController rightSideMenuController:rightViewController usesAutoLayout:true animator:[[FlexSideMenuPopAnimator alloc] init]];

## Set the Side Menu instance as the root view
    self.window.rootViewController = sideMenuController;


## Running the Demo

To run the example demo project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

ios 7 and above
Automatic Reference Counting

## Author

boojapathy, boojapc@thoughtworks.com

## License

FlexSideMenuController is available under the MIT license. See the LICENSE file for more info.

