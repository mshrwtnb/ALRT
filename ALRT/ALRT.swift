import UIKit

/// Responsible for creating and managing an ALRT object.

public class ALRT {
    /**
     Configuration struct to define default tintColor for buttons, ok button title and cancel button title.
     Use `defaultConfiguration`
     */
    public struct Configuration {
        public var tintColor: UIColor?
        public var okTitle: String?
        public var cancelTitle: String?

        public init(
            tintColor: UIColor?,
            okTitle: String?,
            cancelTitle: String?
        ) {
            self.tintColor = tintColor
            self.okTitle = okTitle
            self.cancelTitle = cancelTitle
        }
    }

    /**
     Result indicating whether the alert is displayed or not.

     - success: The alert is displayed.
     - failure: The alert is not displayed due to an ALRTError.
     */

    public enum Result {
        case success
        case failure(ALRTError)
    }

    /**
     ALRTError enums.

     - alertControllerNil: The alert controller is nil.
     - popoverNotSet: An attempt to show .ActionSheet type alert controller failed because the popover presentation controller has not been set up.
     */

    public enum ALRTError: Error {
        case alertControllerNil
        case popoverNotSet
        case sourceViewControllerNil
    }

    public static var defaultConfiguration: Configuration?

    public var alertController: UIAlertController?

    private init() {}

    private init(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )

        if let tintColor = ALRT.defaultConfiguration?.tintColor {
            alertController.view.tintColor = tintColor
        }

        self.alertController = alertController
    }

    // MARK: Creating an ALRT

    /**
     Creates an ALRT object.

     - parameter style:   UIAlertControllerStyle constants indicating the type of alert to display.
     - parameter title:   The title of the alert.
     - parameter message: The message of the alert.

     - returns: ALRT
     */

    public class func create(
        _ style: UIAlertController.Style,
        title: String? = nil,
        message: String? = nil
    ) -> ALRT {
        return ALRT(title: title, message: message, preferredStyle: style)
    }

    // MARK: Fetching the Alert

    /**
     Fetches the ALRT object's alert controller.

     - parameter handler: A block for fetching the alert controller. This block has no return value and takes the alert controller.

     - returns: Self
     */

    @discardableResult
    public func fetch(_ handler: (_ alertController: UIAlertController?) -> Void) -> Self {
        handler(alertController)
        return self
    }

    // MARK: Configuring Text Fields

    /**
     Adds a text field to an alert.

     - parameter configurationHandler: A block for configuring the text field prior to displaying the alert. This block has no return value and takes a single parameter corresponding to the text field object. Use that parameter to change the text field properties.

     - returns: Self
     */

    @discardableResult
    public func addTextField(_ configurationHandler: ((_ textField: UITextField) -> Void)?) -> Self {
        guard alertController?.preferredStyle == .alert else {
            return self
        }

        alertController?.addTextField { textField in
            if let configurationHandler = configurationHandler {
                configurationHandler(textField)
            }
        }

        return self
    }

    // MARK: Configuring Customizable User Actions

    /**
     Attaches an action object to the alert or action sheet.

     - parameter title:     The title of the action’s button.
     - parameter style:     The style that is applied to the action’s button. The default value is .Default.
     - parameter preferred: The preferred action for the user to take from an alert(iOS 9 or later). The default value is false.
     - parameter handler:   A block to execute when the user selects the action. This block has no return value and take the selected action object and the text fields added to the alert controller if any. The default value is nil.

     - returns: Self
     */

    @discardableResult
    public func addAction(
        _ title: String?,
        style: UIAlertAction.Style = .default,
        preferred: Bool = false,
        handler: ((_ action: UIAlertAction, _ textFields: [UITextField]?) -> Void)? = nil
    ) -> Self {
        let action = UIAlertAction(title: title, style: style) { action in
            handler?(action, self.alertController?.preferredStyle == .alert ? self.alertController?.textFields : nil)
            self.alertController = nil
        }

        alertController?.addAction(action)

        if preferred {
            alertController?.preferredAction = action
        }

        return self
    }

    // MARK: Configuring Pre-defined User Actions

    /**
     Attaches an action object to the alert or action sheet. The default title is "OK".

     - parameter title:     The title of the action’s button. The default value is "OK".
     - parameter style:     The style that is applied to the action’s button. The default value is .Default.
     - parameter preferred: The preferred action for the user to take from an alert(iOS 9 or later). The default value is false.
     - parameter handler:   A block to execute when the user selects the action. This block has no return value and take the selected action object and the text fields added to the alert controller if any. The default value is nil.

     - returns: Self
     */

    @discardableResult
    public func addOK(
        _ title: String = ALRT.defaultConfiguration?.okTitle ?? "OK",
        style: UIAlertAction.Style = .default,
        preferred: Bool = false,
        handler: ((_ action: UIAlertAction, _ textFields: [UITextField]?) -> Void)? = nil
    ) -> Self {
        return addAction(title, style: style, preferred: preferred, handler: handler)
    }

    /**
     Attaches an action object to the alert or action sheet. The default title is "Cancel".

     - parameter title:     The title of the action’s button. The default value is "Cancel".
     - parameter style:     The style that is applied to the action’s button. The default value is .Cancel.
     - parameter preferred: The preferred action for the user to take from an alert(iOS 9 or later). The default value is false.
     - parameter handler:   A block to execute when the user selects the action. This block has no return value and take the selected action object and the text fields added to the alert controller if any. The default value is nil.

     - returns: Self
     */

    @discardableResult
    public func addCancel(
        _ title: String = ALRT.defaultConfiguration?.cancelTitle ?? "Cancel",
        style: UIAlertAction.Style = .cancel,
        preferred: Bool = false,
        handler: ((_ action: UIAlertAction, _ textFields: [UITextField]?) -> Void)? = nil
    ) -> Self {
        return addAction(title, style: style, preferred: preferred, handler: handler)
    }

    /**
     Attaches an action object to the alert or action sheet. The default style is .Destructive.

     - parameter title:     The title of the action’s button.
     - parameter style:     The style that is applied to the action’s button. The default value is .Destructive.
     - parameter preferred: The preferred action for the user to take from an alert(iOS 9 or later). The default value is false.
     - parameter handler:   A block to execute when the user selects the action. This block has no return value and take the selected action object and the text fields added to the alert controller if any. The default value is nil.

     - returns: Self
     */

    @discardableResult
    public func addDestructive(
        _ title: String?,
        style: UIAlertAction.Style = .destructive,
        preferred: Bool = false,
        handler: ((_ action: UIAlertAction, _ textFields: [UITextField]?) -> Void)? = nil
    ) -> Self {
        return addAction(title, style: style, preferred: preferred, handler: handler)
    }

    // MARK: Configuring the Popover Presentation

    /** Configures the alert controller's popover presentation controller.

     - parameter configurationHandler: A block for configuring the popover presentation controller. This block has no return value and take the alert controller's popover presentation controller. If the alert controller's style is .ActionSheet and the device is iPad, this configuration is necessary.

     - returns: Self
     */

    @discardableResult
    public func configurePopoverPresentation(_ configurationHandler: ((_ popover: UIPopoverPresentationController?) -> Void)? = nil) -> Self {
        configurationHandler?(alertController?.popoverPresentationController)
        return self
    }

    // MARK: Showing the Alert

    /**
     Displays the alert or action sheet.

     - parameter viewControllerToPresent: The view controller to display the alert from. The default value is nil. If the parameter is not given, the key window's root view controller will present the alert.
     - parameter animated:       Pass true to animate the presentation; otherwise, pass false. The default value is true.
     - parameter completion:     The block to execute after the presentation finishes. This block has no return value and takes an Result parameter. The default value is nil.
     */

    public func show(
        _ viewControllerToPresent: UIViewController? = nil,
        animated: Bool = true,
        completion: @escaping ((ALRT.Result) -> Void) = { _ in }
    ) {
        guard let alert = alertController else {
            completion(.failure(.alertControllerNil))
            return
        }

        if UIDevice.current.userInterfaceIdiom == .pad,
            alert.preferredStyle == .actionSheet,
            alert.popoverPresentationController?.sourceView == nil,
            alert.popoverPresentationController?.barButtonItem == nil {
            completion(.failure(.popoverNotSet))
            return
        }

        let sourceViewController: UIViewController? = {
            let viewController = viewControllerToPresent ?? UIApplication.shared.topMostViewController()
            if let navigationController = viewController as? UINavigationController {
                return navigationController.visibleViewController
            }
            return viewController
        }()

        guard let source = sourceViewController else {
            completion(.failure(.sourceViewControllerNil))
            return
        }

        source.present(alert, animated: animated) {
            if let tintColor = ALRT.defaultConfiguration?.tintColor {
                alert.view.tintColor = tintColor
            }
            completion(.success)
        }
    }
}

private extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }

        return self
    }
}

private extension UIApplication {
    func topMostViewController() -> UIViewController? {
        guard let keyWindow = windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        return keyWindow.rootViewController?.topMostViewController()
    }
}
