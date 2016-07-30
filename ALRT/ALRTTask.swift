//
//  ALRTTask.swift
//
//  Created by Masahiro Watanabe on 7/27/16.
//  Copyright © 2016 Masahiro Watanabe. All rights reserved.
//

import UIKit

public class ALRTTask {
    
    private var alert: UIAlertController!
    
    // MARK: Initializer
    
    private init(){}
    
    public init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle){
        self.alert = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: preferredStyle)
    }
    
    // MARK: TextField
    
    public func addTextField(configurationHandler: ((UITextField) -> Void)?) -> Self{
        guard alert.preferredStyle == .Alert else {
            return self
        }
        
        alert.addTextFieldWithConfigurationHandler {
            textField in
            if let configurationHandler = configurationHandler {
                configurationHandler(textField)
            }
        }
        
        return self
    }
    
    // MARK: Action
    
    public func addAction(title: String?,
                          style: UIAlertActionStyle = .Default,
                          handler: ((UIAlertAction, [UITextField]?) -> Void)? = nil) -> Self {
        
        alert.addAction(UIAlertAction(title: title, style: style){
            action in
            
            handler?(action, self.alert.preferredStyle == .Alert ? self.alert.textFields : nil)
            self.alert = nil
            
            })
        
        return self
    }
    
    public func addOK(title: String = "OK",
                      style: UIAlertActionStyle = .Default,
                      handler:((UIAlertAction, [UITextField]?) -> Void)? = nil) -> Self {
        
        return addAction(title, style: style, handler: handler)
    }
    
    public func addCancel(title: String = "Cancel",
                          style: UIAlertActionStyle = .Cancel,
                          handler: ((UIAlertAction, [UITextField]?) -> Void)? = nil) -> Self {
        
        return addAction(title, style: style, handler: handler)
    }
    
    public func addDestructive(title: String?,
                               style: UIAlertActionStyle = .Destructive,
                               handler: ((UIAlertAction, [UITextField]?) -> Void)? = nil) -> Self {
        
        return addAction(title, style: style, handler: handler)
    }
    
    // MARK: Popover
    
    public func setPopoverPresentationController(sourceView: UIView? = nil, sourceRect: CGRect) -> Self {
        
        alert.popoverPresentationController?.sourceView = sourceView
        alert.popoverPresentationController?.sourceRect = sourceRect
        
        return self
    }
    
    // MARK: Show
    
    public func show(viewController: UIViewController? = nil,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil){
        
        if let viewController = viewController {
            viewController.presentViewController(self.alert, animated: animated, completion: completion)
        } else {
            let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
            rootViewController?.presentViewController(self.alert, animated: animated, completion: completion)
        }
    }
}
