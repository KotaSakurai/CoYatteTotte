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
        view.setTitleColor(.brandColor, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @objc func openPrivacy() {
        let url: URL = URL(string: "https://docs.google.com/document/d/e/2PACX-1vRvqJwP9YRGIbvmdrLTXgVxepGZVpO7ZrRCXmDZKAk4wCtxwOoDmdrWsRFdGxlHP4J_UXkGK7DlZ3eG/pub")!
        UIApplication.shared.open(url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.view.addSubview(privacyButton)
        
        self.privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchDown)
        
        NSLayoutConstraint.activate([
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}
