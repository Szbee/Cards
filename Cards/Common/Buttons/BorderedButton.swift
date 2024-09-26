//
//  BorderedButton.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 24/09/2024.
//

import UIKit

class BorderedButton: UIButton {

    override init(frame: CGRect) {
           super.init(frame: frame)
           setUpButton()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setUpButton()
       }
    
    private func setUpButton(){
        backgroundColor = .clear
        tintColor = .blue
        setTitleColor(UIColor(named: "secondaryBlue"), for: .normal)
        setTitleColor(UIColor(named: "secondaryBlue"), for: .highlighted)
        
        layer.cornerRadius = 4
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(named: "secondaryBlue")?.cgColor
    }

}
