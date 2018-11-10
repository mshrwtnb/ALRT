# Usage
## `.alert`
```swift
import ALRT

ALRT.create(.alert, title: "Title", message: "Message").addOK().addCancel().show()
```

## `.actionSheet`
```swift
ALRT.create(.actionSheet, message: "Action Sheet")
    .addAction("Option A") { action, textfield in 
        print("\(action.title)") // Option A
    }
    .addAction("Option B")
    .addDestructive("Destructive Option")
    .show() 
```

## Custom Title
```swift
ALRT.create(.alert, title: "Custom Title", message: "🐈 or 🐶?")
    .addAction("🐈")
    .addAction("🐶")
    .addCancel("❌")
    .show()
```

## Action Handling
```swift
ALRT.create(.alert, title: "Action Handling")
    .addOK() { action, _ in
        print("\(action.title!) tapped")
    }
    .show()
```

## Result Handling
```swift
ALRT.create(.alert, title: "Result Handling")
    .addOK()
    .show() { result in
        switch result {
        case .success:
            print("Alert is successfully shown")
        case .failure(let error):
            print("Error occurred. \(error.localizedDescription)")
        }
    }
```

## TextField(s)
```swift
enum TextFieldIdentifier: Int {
    case username
    case password
}

ALRT.create(.alert, title: "Enter your credentials")
    // configure textfield
    .addTextField { textfield in
        textfield.placeholder = "Username"
        textfield.tag = TextFieldIdentifier.username.rawValue
    }
    .addTextField() { textField in
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.tag = TextFieldIdentifier.password.rawValue
    }
    .addAction("Login") { _, textfields in
        for textField in textfields ?? [] {
            if let identifier = TextFieldIdentifier(rawValue: textField.tag) {
                switch identifier {
                case .username:
                    // Extract username
                case .password:
                    // Extract password
                }
            }
        }
    }
    .addCancel()
    .show()
```

## Changing source ViewController to present from

```swift
ALRT.create(.alert, title: "Source?")
    .addOK()
    .show(self) // self = source ViewController
```