//
//  DemoViewController.swift
//  Demo
//
//  Created by Masahiro Watanabe on 7/30/16.
//  Copyright © 2016 Masahiro Watanabe. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    private enum ActionTitle: String {
        case Alert
        case ActionSheet
        case Login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: ActionTitle.Alert.rawValue, style: .Plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: ActionTitle.ActionSheet.rawValue, style: .Plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: ActionTitle.Login.rawValue, style: .Plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
        ]
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.setToolbarItems(items, animated: false)
    }
    
    func didTapButton(sender: UIBarButtonItem){
        
        guard let title = sender.title else {
            return
        }
        
        if title == ActionTitle.Alert.rawValue {
            
            ALRT.create(.Alert, title: "Error", message: "No item found")
                .addOK()
                .show()
            
        } else if title == ActionTitle.ActionSheet.rawValue {
            
            ALRT.create(.ActionSheet, title: "Destination", message: "Please select your destination")
                .addPopoverPresentation {
                    // implement popover.barButtonItem or popover.sourceView for iPad
                    popover in
                    popover?.barButtonItem = sender
                }
                .addAction("New York") { action, textFields in print("New York has been selected") }
                .addAction("Paris")
                .addAction("London")
                .addDestructive("Not interested")
                .show()
            
        } else if title == ActionTitle.Login.rawValue {
            
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
                .show() { print("Alert has been shown") }
            
        }
    }
    
}

