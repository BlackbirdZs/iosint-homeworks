//
//  CustomButton.swift
//  Navigation
//
//  Created by Anton Kruglov on 05.10.2026.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var tapOnButton: (() -> Void)?
    
    var title: String
    var titleColor: UIColor
    
    init(title: String, titleColor: UIColor) {
        self.title = title
        self.titleColor = titleColor
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true

        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        tapOnButton?()
    }
}
