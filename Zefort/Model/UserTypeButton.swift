//
//  userTypeButton.swift
//  Zefort
//
//  Created by NIK FIKRI on 21/06/2019.
//  Copyright © 2019 Zyepher. All rights reserved.
//

import UIKit

class UserTypeButton: UIButton {
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = Colors.twitterBlue.cgColor
        layer.cornerRadius = frame.size.height/2
        
        setTitleColor(Colors.twitterBlue, for: .normal)
        addTarget(self, action: #selector(UserTypeButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        isOn = bool
        
        let color = bool ? Colors.twitterBlue : .clear
        let title = bool ? "Student" : "Tutor"
        let titleColor = bool ? . white : Colors.twitterBlue
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }
}
