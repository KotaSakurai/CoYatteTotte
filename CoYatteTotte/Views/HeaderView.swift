//
//  HeaderView.swift
//  CoYatteTotte
//
//  Created by 桜井広大 on 2020/07/30.
//  Copyright © 2020 KotaSakurai. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UIView {
    let menuButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage.init(systemName: "ellipsis.circle"), for: .normal)
        
        button.tintColor = .brandColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            menuButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            menuButton.widthAnchor.constraint(equalToConstant: 50),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
