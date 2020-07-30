//
//  SettingsViewController.swift
//  CoYatteTotte
//
//  Created by 桜井広大 on 2020/07/31.
//  Copyright © 2020 KotaSakurai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

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
        view.setTitle("Blue", for: .normal)
        view.setTitleColor(.gray, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let settingDefaultColorButton: UIButton = {
       let view = UIButton.init()
       view.setTitle("Default", for: .normal)
       view.setTitleColor(.gray, for: .normal)
       view.translatesAutoresizingMaskIntoConstraints = false
       
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
    
    @objc func setDefaultUiColor() {
         UserDefaults.standard.set("f2abae", forKey: "ui-color")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.view.addSubview(privacyButton)
        self.view.addSubview(settingBlueColorButton)
        self.view.addSubview(settingDefaultColorButton)
        
        self.privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchDown)
        self.settingBlueColorButton.addTarget(self, action: #selector(setBlueUiColor), for: .touchDown)
        self.settingDefaultColorButton.addTarget(self, action: #selector(setDefaultUiColor), for: .touchDown)
        
        NSLayoutConstraint.activate([
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            settingBlueColorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingBlueColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settingDefaultColorButton.centerYAnchor.constraint(equalTo: settingBlueColorButton.bottomAnchor, constant: 50),
            settingDefaultColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.onClose()
    }
}

