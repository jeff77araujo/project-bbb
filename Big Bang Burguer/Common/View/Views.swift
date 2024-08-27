//
//  Views.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 22/08/24.
//

import UIKit

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}
