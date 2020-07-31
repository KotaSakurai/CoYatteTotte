//
//  SettingsViewController.swift
//  CoYatteTotte
//
//  Created by 桜井広大 on 2020/07/31.
//  Copyright © 2020 KotaSakurai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let colorHeader: UILabel = {
        let view = UILabel.init()
        view.text = "Color Settings"
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let privacyButton: UIButton = {
        let view = UIButton.init()
        view.setTitle("PrivacyPolicy", for: .normal)
        view.setTitleColor(.gray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let settingBlueColorButton: UIButton = {
        let view = UIButton.init()
//        view.setTitle("Blue", for: .normal)
        view.frame = CGRect(x: 30, y: 150,
        width: 50, height:50)
        view.backgroundColor = UIColor.blueColor
//        view.setTitleColor(.gray, for: .normal)
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let settingGreenColorButton: UIButton = {
        let view = UIButton.init()
//        UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
//        view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        view.frame = CGRect(x:130, y: 150,
        width: 50, height:50)
//        view.setTitle("Green", for: .normal)
        view.backgroundColor = UIColor.greenColor
//        view.setTitleColor(.gray, for: .normal)
//        view.frame = CGRect(x: (view.frame.size.width / 2 ) - 150, y: (view.frame.size.height / 2 ) - 150, width: 50, height: 50)
        
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let settingDefaultColorButton: UIButton = {
       let view = UIButton.init()
       view.frame = CGRect(x:230, y: 150,
        width: 50, height:50)
        view.backgroundColor = UIColor.brandColor
//       view.setTitle("Default", for: .normal)
//       view.setTitleColor(.gray, for: .normal)
//       view.translatesAutoresizingMaskIntoConstraints = false
       
       return view
   }()
    
    var onClose: () -> Void = { }

    @objc func openPrivacy() {
        let url: URL = URL(string: "https://docs.google.com/document/d/e/2PACX-1vRvqJwP9YRGIbvmdrLTXgVxepGZVpO7ZrRCXmDZKAk4wCtxwOoDmdrWsRFdGxlHP4J_UXkGK7DlZ3eG/pub")!
        UIApplication.shared.open(url)
    }
    
    @objc func setBlueUiColor() {
         UserDefaults.standard.set("B7CFE2", forKey: "ui-color")
    }
    
    @objc func setGreenUiColor() {
         UserDefaults.standard.set("A3C6AF", forKey: "ui-color")
    }
    
    @objc func setDefaultUiColor() {
         UserDefaults.standard.set("f2abae", forKey: "ui-color")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.view.addSubview(colorHeader)
        self.view.addSubview(privacyButton)
        self.view.addSubview(settingBlueColorButton)
        self.view.addSubview(settingGreenColorButton)
        self.view.addSubview(settingDefaultColorButton)
        
        self.privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchDown)
        self.settingBlueColorButton.addTarget(self, action: #selector(setBlueUiColor), for: .touchDown)
        self.settingGreenColorButton.addTarget(self, action: #selector(setGreenUiColor), for: .touchDown)
        self.settingDefaultColorButton.addTarget(self, action: #selector(setDefaultUiColor), for: .touchDown)
        
        NSLayoutConstraint.activate([
            colorHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            settingBlueColorButton.bottomAnchor.constraint(equalTo: colorHeader.bottomAnchor, constant: 20),
            settingBlueColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
//            settingBlueColorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            settingBlueColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
            settingGreenColorButton.centerYAnchor.constraint(equalTo: settingBlueColorButton.bottomAnchor, constant: 50),
            settingGreenColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settingDefaultColorButton.centerYAnchor.constraint(equalTo: settingGreenColorButton.bottomAnchor, constant: 50),
            settingDefaultColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.onClose()
    }
}

