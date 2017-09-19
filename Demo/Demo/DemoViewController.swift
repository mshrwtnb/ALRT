import UIKit

class DemoViewController: UIViewController {
    
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var actionSheetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapAlertButton(_ sender: UIButton) {
        ALRT.create(.alert, title: "Show me some alert").addOK().addCancel().show()
    }
    
    @IBAction func didTapActionSheetButton(_ sender: UIButton) {
        ALRT.create(.actionSheet, title: "ALRT", message: "Show me some action sheet")
            .addAction("Option A") { _, _ in print("Option A has been tapped!") }
            .addAction("Option B") { action, textfield in print("\(action.title!) has been tapped!") }
            .addDestructive("Destructive Option")
            .show()
    }
}
