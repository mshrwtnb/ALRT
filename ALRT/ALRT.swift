//
//  ALRT.swift
//
//  Created by Masahiro Watanabe on 7/26/16.
//  Copyright © 2016 Masahiro Watanabe. All rights reserved.
//

import UIKit

public class ALRT {
    private init(){}
    public class func create(style: UIAlertControllerStyle,
                             title: String?,
                             message: String?) -> ALRTTask {
        return ALRTTask(title: title, message: message, preferredStyle: style)
    }
}
