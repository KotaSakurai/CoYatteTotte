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
    
    let settingGreenColorButton: UIButton = {
        let view = UIButton.init()
        view.frame = CGRect(x: 20, y: 130, width: 50, height:50)
        view.backgroundColor = UIColor.greenColor
        view.layer.cornerRadius = 5.0;
        return view
    }()
    
    let settingBlueColorButton: UIButton = {
        let view = UIButton.init()
        view.frame = CGRect(x: 120, y: 130, width: 50, height:50)
        view.backgroundColor = UIColor.blueColor
        view.layer.cornerRadius = 5.0;
        return view
    }()
    
    let settingDefaultColorButton: UIButton = {
         let view = UIButton.init()
         view.frame = CGRect(x: 220, y: 130, width: 50, height:50)
         view.backgroundColor = UIColor.brandColor
         view.layer.cornerRadius = 5.0;
         return view
    }()
    
    let filterHeader: UILabel = {
        let view = UILabel.init()
        view.text = "Filter Settings"
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc let settingFilter: UISwitch = {
        let view = UISwitch.init()
        view.tintColor = .white
        view.frame = CGRect(x: 20, y: 270, width: 50, height: 25)
        view.backgroundColor = .white
        view.layer.cornerRadius = view.frame.size.height/2;
        view.onTintColor = UIColor.brandColor
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
    
    @objc func toggleDefaultFilter(sender: UISwitch) {
        // toggleにしたい
        UserDefaults.standard.set(!sender.isOn, forKey: "filter")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.view.addSubview(colorHeader)
        self.view.addSubview(privacyButton)
        self.view.addSubview(settingBlueColorButton)
        self.view.addSubview(settingGreenColorButton)
        self.view.addSubview(settingDefaultColorButton)
        self.view.addSubview(filterHeader)
        self.view.addSubview(settingFilter)
        
        settingFilter.isOn = !UserDefaults.standard.bool(forKey: "filter")
        
        self.privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchDown)
        self.settingBlueColorButton.addTarget(self, action: #selector(setBlueUiColor), for: .touchDown)
        self.settingGreenColorButton.addTarget(self, action: #selector(setGreenUiColor), for: .touchDown)
        self.settingDefaultColorButton.addTarget(self, action: #selector(setDefaultUiColor), for: .touchDown)
        self.settingFilter.addTarget(self, action: #selector(toggleDefaultFilter), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            colorHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            settingBlueColorButton.bottomAnchor.constraint(equalTo: colorHeader.bottomAnchor, constant: 20),
            settingBlueColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            settingGreenColorButton.centerYAnchor.constraint(equalTo: settingBlueColorButton.bottomAnchor, constant: 50),
            settingGreenColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settingDefaultColorButton.centerYAnchor.constraint(equalTo: settingGreenColorButton.bottomAnchor, constant: 50),
            settingDefaultColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            filterHeader.topAnchor.constraint(equalTo: colorHeader.bottomAnchor, constant: 60),
            filterHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            settingFilter.topAnchor.constraint(equalTo: filterHeader.bottomAnchor, constant: 20),
            settingFilter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.onClose()
    }
}

