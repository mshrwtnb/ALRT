import UIKit

class DemoViewController: UIViewController {
    fileprivate enum ActionTitle: String {
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
        
        guard
            let title = sender.title,
            let actionTitle = ActionTitle(rawValue: title)
        else {
            return
        }
        
        switch actionTitle {
        case .alert:
            ALRT.create(.alert, title: "Breaking News", message: "MagSafe is gone")
                .addOK()
                .addAction("NO WAY", preferred: true) // preferredAction is available iOS 9.0 or later
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
                    textField.accessibilityIdentifier = "Username"
                }
                .addTextField { textField in
                    textField.placeholder = "Password"
                    textField.accessibilityIdentifier = "Password"
                    textField.isSecureTextEntry = true
                }
                .addCancel()
                .addOK()
                .show { result in
                    switch result {
                    case .success:
                        print("The alert is displayed.")
                        
                    case .failure(let error):
                        print("The alert is not displayed. Error => \(error)")
                    }
                }
        }

    }
    
}

