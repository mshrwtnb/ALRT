# ALRT
<img width=300 src="https://raw.githubusercontent.com/wiki/mshrwtnb/ALRT/logobanner.png">

ALRTは、UIAlertControllerをシンプルに呼び出すことができるライブラリです。
`.alert`, `.actionSheet`のどちらも簡単に作成、表示することができます。

例
```swift
ALRT.create(.alert, title: "Show me some alert").addOK().addCancel().show()
```

## イメージ
<img height=400 src="https://media.giphy.com/media/3ohhwqMEooV3s7lntm/giphy.gif">

## 特徴
* ワンライナーでUIAlertControllerを作成、表示
* UIAlertControllerStyle.alert, .actionSheetに対応
* UIAlertControllerにUITextFieldを追加
* 表示結果をResult型でハンドリング

## 例
### 例1 .alert表示
ALRTを使わず、オーソドックスにUIAlertControllerを作成し、表示するにはこのようなコードが必要です。
```swift
let alertController = UIAlertController(title: "Show me some alert", message: nil, preferredStyle: .alert)

let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
alertController.addAction(okAction)
alertController.addAction(cancelAction)

self.present(alertController, animated: true, completion: nil)
```

しかし、ALRTを使えば、これだけで済みます。
```swift
import ALRT
ALRT.create(.alert, title: "Show me some alert").addOK().addCancel().show()
```

### 例2 .actionSheet表示、Actionタップをハンドリング
UIAlertActionのタップハンドリングはTrailing Closureで行うことができます。   
以下の例ではタップされるとメッセージがprintされます。

```swift
ALRT.create(.actionSheet, title: "ALRT", message: "Show me some action sheet")
      .addAction("Option A") { _, _ in print("Option A has been tapped!") }
      .addAction("Option B") { action, textfield in print("\(action.title!) has been tapped!") }
      .addDestructive("Destructive Option")
      .show()
```

## 例3 UIAlertControllerにUITextFieldを追加
<img height=300 src="https://media.giphy.com/media/l378jFjtJQqJvSCSQ/giphy.gif">

UIAlertControllerにUITextFieldを追加することもできます（例：ログイン）。   
以下の例では、OKタップ時にUITextFieldの配列を回します。
tagやUITextField変数をスコープ外に用意することで、UITextFieldのtextの取得が可能になります。

```swift
ALRT.create(.alert, title: "Login", message: "Please enter your credentials")
    .addTextField { textField in
        textField.placeholder = "Username"
    }
    .addTextField { textField in
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
    }
    .addCancel()
    .addOK() { _, textFields in
        for textField in textFields ?? [] {
            // ...
        }
    }
    .show()
```

## 環境
* Xcode 10.0
* Swift 4.2
* iOS 9.0以上

## インストール方法
### Cocoapods
Podfileに追加

```
pod "ALRT"
```

### Carthage
```
github "mshrwtnb/ALRT" ~> 1.3.0
```

## Multilanguages Documents
English version can be found [here](https://github.com/mshrwtnb/ALRT/blob/master/README_en.md)
