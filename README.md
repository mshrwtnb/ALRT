<img src="https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png">

ALRT is a call-site-friendly UIAlertController framework that aims to be an AL(R)Ternative to tedious UIAlertController implementation process.

Similar snippets will no longer mess up your project.

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

ALRT.create(.Alert, title: "Confirm", message: "Please confirm your order")
    .addCancel()
    .addOK()
    .show()
```

### ActionSheet
UIAlertControllerStyle.ActionSheet is supported.

```swift
ALRT.create(.ActionSheet, title: "Destination", message: "Please select your destination")
    .configurePopoverPresentation {
        // set popover.barButtonItem or popover.sourceView for iPad
        popover in
        popover?.barButtonItem = sender
    }
    .addAction("New York") { action, textFields in print("New York has been selected") }
    .addAction("Paris")
    .addAction("London")
    .addDestructive("Not interested")
    .show()
```
### Alert with two textfields
UIAlertController.textFields can be accessed asynchronously right after the OK button is tapped.
Also you are able to know if the alert or action sheet is displayed or not.

```swift
ALRT.create(.Alert, title: "Login", message: "Please enter your credentials")
     .addTextField { textField in
         textField.placeholder = "Username"
     }
     .addTextField { textField in
         textField.placeholder = "Password"
         textField.secureTextEntry = true
     }
     .addCancel()
     .addOK() { alert, textFields in
         textFields?
             .flatMap { (placeholder: $0.placeholder ?? "No Placeholder", text: $0.text ?? "No Text") }
             .forEach { print("\($0.placeholder) => \($0.text)") }
     }
     .show(completion: { result in
         switch result {
         case .Success:
             print("The alert is displayed.")

         case .Failure(let error):
             print("The alert is not displayed. Error => \(error)")
         }
     })
```

## Requirements
* Swift 2.3
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
* [Full Documentation](http://cocoadocs.org/docsets/ALRT/0.2/)
