//
//  Extensions.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 08.01.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
