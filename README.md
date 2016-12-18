[![Build Status](https://www.bitrise.io/app/a83365a50419cead.svg?token=CsJmpuGa23wFB_6FYmeHVg)](https://www.bitrise.io/app/a83365a50419cead)
[![codecov](https://codecov.io/gh/mshrwtnb/ALRT/branch/master/graph/badge.svg)](https://codecov.io/gh/mshrwtnb/ALRT)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods](https://img.shields.io/cocoapods/v/ALRT.svg?style=flat)](https://cocoapods.org/pods/ALRT)

# ALRT
<img width=600 src="https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png">

ALRT is a call-site-friendly UIAlertController framework that aims to be an AL(R)Ternative to tedious UIAlertController implementation process.

Similar snippets will no longer mess up your project.

## Image
<img height="300" src="https://media.giphy.com/media/26hirZS4wE6kwpCpy/giphy.gif">


## Features
* Call-site-friendly. See Usages
* Chainable UIAlertController setup both Alert and ActionSheet styles
* Add UITextField(s) and handle their values when a certain UIAlertAction button is clicked
* Preferred Action Support
* Can handle the result of show() action both .Success and .Failure

## Usages
### Alert with OK / Cancel buttons

```swift
import ALRT

// alert without title/message
ALRT.create(.alert)
    .addOK()
    .addCancel()
    .show()

// alert with title
ALRT.create(.alert, title: "Title")
    .addOK()
    .addCancel()
    .show()

// alert with title and message
ALRT.create(.alert, title: "Title", message: "Message")
    .addOK()
    .addCancel()
    .show()
```

### ActionSheet
UIAlertControllerStyle.ActionSheet is supported.

```swift
ALRT.create(.actionSheet, title: "Choose your destination")
    .configurePopoverPresentation {
        // set popover.barButtonItem or popover.sourceView for iPad
        popover in
        popover?.barButtonItem = sender
    }
    .addAction("New York") { action, _ in
        print("New York has been selected")
    }
    .addAction("Paris")
    .addAction("London")
    .addDestructive("None of the above")
    .show()
```
### Alert with two textfields
UIAlertController.textFields can be accessed asynchronously right after the OK button is tapped.
Also you are able to know if the alert or action sheet is displayed or not.

```swift
ALRT.create(.alert, title: "Login", message: "Please enter your credentials")
    .addTextField { textField in
        textField.placeholder = "Username"
        textField.accessibilityIdentifier = "Username"
    }
    .addTextField { textField in
        textField.placeholder = "Password"
        textField.accessibilityIdentifier = "Password"
        textField.isSecureTextEntry = true
    }
    .addCancel()
    .addOK() { alert, textFields in
        textFields?
            .flatMap { (placeholder: $0.placeholder ?? "No Placeholder", text: $0.text ?? "No Text") }
            .forEach { print("\($0.placeholder) => \($0.text)") }
    }
    .show { result in
        switch result {
        case .success:
            print("The alert is displayed.")

        case .failure(let error):
            print("The alert is not displayed. Error => \(error)")
        }
    }
```

## Requirements
* Xcode 8.0 (Swift 3.0) or later
* iOS 8.0 or later

## Installation
### Cocoapods
Add to your Podfile and run pod install.

```
platform :ios, '8.0'

target YOUR_TARGET do
  use_frameworks!
  pod "ALRT"
end
```

### Carthage
Add to your Cartfile.

```
github "mshrwtnb/ALRT"
```

## Documentation
* [Full Documentation](http://cocoadocs.org/docsets/ALRT/0.4/)
