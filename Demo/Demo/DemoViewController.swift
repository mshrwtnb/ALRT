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
        case alert
        case actionSheet
        case login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: ActionTitle.alert.rawValue, style: .plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: ActionTitle.actionSheet.rawValue, style: .plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: ActionTitle.login.rawValue, style: .plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        ]
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.setToolbarItems(items, animated: false)
        
    }
    
    func didTapButton(_ sender: UIBarButtonItem){
        
        guard let title = sender.title else {
            return
        }
        
        if let title = ActionTitle(rawValue: title) {
            switch title {
            case .alert:
                ALRT.create(.alert, title: "Error", message: "No item found")
                    .addOK()
                    .addAction("No Way!", preferred: true) // preferredAction is available iOS 9.0 or later
                    .show()
            
            case .actionSheet:
                ALRT.create(.actionSheet, title: "Destination", message: "Please select your destination")
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
                
            case .login:
                ALRT.create(.alert, title: "Login", message: "Please enter your credentials")
                    .addTextField { textField in
                        textField.placeholder = "Username"
                    }
                    .addTextField { textField in
                        textField.placeholder = "Password"
                        textField.isSecureTextEntry = true
                    }
                    .addCancel()
                    .addOK() { alert, textFields in
                        textFields?
                            .flatMap { (placeholder: $0.placeholder ?? "No Placeholder", text: $0.text ?? "No Text") }
                            .forEach { print("\($0.placeholder) => \($0.text)") }
                    }
                    .show(completion: { result in
                        switch result {
                        case .success:
                            print("The alert is displayed.")
                            
                        case .failure(let error):
                            print("The alert is not displayed. Error => \(error)")
                        }
                    })
            }
        }

    }
    
}

