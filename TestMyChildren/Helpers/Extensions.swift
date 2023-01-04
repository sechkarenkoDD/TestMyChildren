//
//  Extensions.swift
//  TestMyChildren
//
//  Created by Дмитрий Сечкаренко on 25.10.2022.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.keyboardType = keyboardType
    }
}

extension UIButton {
    convenience init(title: String, withImage: Bool = false, backgroundColor: UIColor = .tintColor, foregroundColor: UIColor = .tintColor ) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configuration = .borderedTinted()
        self.setTitle(title, for: .normal)
        self.configuration?.baseBackgroundColor = backgroundColor
        self.configuration?.baseForegroundColor = foregroundColor
        
        if withImage == true {
            self.setImage(UIImage(systemName: "plus"), for: .normal)
            self.configuration?.imagePadding = 6
        }
    }
}

extension UILabel {
    convenience init(text: String) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
    }
}


