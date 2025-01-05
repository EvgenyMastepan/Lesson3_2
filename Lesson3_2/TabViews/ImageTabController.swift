//
//  ImageTabController.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import UIKit

class ImageTabController: UIViewController {
    
    private let networkLayer = NetworkLayer()
    private let screenWidth: CGFloat = UIScreen.main.bounds.width

    lazy var aiImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        // MARK: - Demo-version. Don't forget to remove!
        $0.image = UIImage(named: "1")
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    
    lazy var promptTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = true
        $0.text = "Prompt text there..."
        $0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .systemGray
        $0.textAlignment = .left
        $0.autocorrectionType = .no
        $0.layer.borderColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 20
        return $0
    }(UITextView())
    
    lazy var sendButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray
        $0.tintColor = .systemOrange
        $0.setImage(UIImage(systemName: "arrow.up.square"), for: .normal)
        $0.setTitle("Send prompt", for: .normal)
        $0.layer.cornerRadius = 20
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(aiImage)
        self.view.addSubview(promptTextView)
        self.view.addSubview(sendButton)
        setupConstraints()
//        networkLayer.sendRequest(prompt: "")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            aiImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aiImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aiImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aiImage.heightAnchor.constraint(equalToConstant: screenWidth - 20),
            
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            sendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
        
            promptTextView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20),
            promptTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            promptTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            promptTextView.topAnchor.constraint(equalTo: aiImage.bottomAnchor, constant: 20)
        ])
    }
}
