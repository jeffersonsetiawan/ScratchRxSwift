//
//  ViewController.swift
//  ScratchRxSwift
//
//  Created by Jefferson Setiawan on 22/10/21.
//

import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Page"
        let button = UIButton()
        button.setTitle("Tap Me", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.backgroundColor = .white
    }
    
    @objc private func didTap() {
        navigationController?.pushViewController(MyReactiveVC(), animated: true)
    }
}
