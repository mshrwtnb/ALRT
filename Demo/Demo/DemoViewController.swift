//
//  DemoViewController.swift
//  Demo
//
//  Created by Masahiro Watanabe on 7/30/16.
//  Copyright © 2016 Masahiro Watanabe. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Login", style: .Plain, target: self, action: #selector(DemoViewController.didTapButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        ]
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.setToolbarItems(items, animated: false)
    }
    
    func didTapButton(sender: UIBarButtonItem){
        
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
            .show()
    }
    
}

