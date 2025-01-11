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
        $0.image = UIImage(named: "1")
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    
    lazy var promptTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = true
        $0.text = ""
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
    
    lazy var descriptionTextLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Write the request text here:"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .systemOrange
        return $0
    }(UILabel())
    
    lazy var sendButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray
        $0.tintColor = .systemOrange
        $0.setImage(UIImage(systemName: "arrow.up.square"), for: .normal)
        $0.setTitle("Send prompt", for: .normal)
        $0.layer.cornerRadius = 20
        return $0
    }(UIButton(primaryAction: UIAction(handler: { _ in
        self.waitingScreenOn()
        self.sendRequest()
    })))
    
    lazy var waitView: UIView = {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        return $0
    }(UIView())
    
    lazy var waitLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Please wait..."
        $0.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        $0.textAlignment = .center
        $0.textColor = .systemOrange
        return $0
    }(UILabel())
    
    lazy var animationView: UIView = {
        $0.backgroundColor = .systemOrange
        $0.layer.cornerRadius = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubviews(aiImage, promptTextView, sendButton, descriptionTextLabel)
//        sendRequest()
        setupConstraints()

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
            promptTextView.topAnchor.constraint(equalTo: aiImage.bottomAnchor, constant: 20),
            
            descriptionTextLabel.centerXAnchor.constraint(equalTo: promptTextView.centerXAnchor),
            descriptionTextLabel.centerYAnchor.constraint(equalTo: promptTextView.topAnchor, constant: -10),
            descriptionTextLabel.widthAnchor.constraint(equalToConstant: 300),
            descriptionTextLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func waitingScreenOn(){
        self.view.addSubviews(self.waitView, self.waitLabel, self.animationView)
        NSLayoutConstraint.activate([
            waitView.centerXAnchor.constraint(equalTo: aiImage.centerXAnchor),
            waitView.centerYAnchor.constraint(equalTo: aiImage.centerYAnchor),
            waitView.heightAnchor.constraint(equalTo: aiImage.heightAnchor),
            waitView.widthAnchor.constraint(equalTo: aiImage.widthAnchor),

            waitLabel.centerXAnchor.constraint(equalTo: waitView.centerXAnchor),
            waitLabel.centerYAnchor.constraint(equalTo: waitView.centerYAnchor),
            waitLabel.heightAnchor.constraint(equalToConstant: 50),
            waitLabel.widthAnchor.constraint(equalToConstant: 200),
            
            animationView.topAnchor.constraint(equalTo: waitLabel.bottomAnchor, constant: 10),
            animationView.centerXAnchor.constraint(equalTo: waitView.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 50),
            animationView.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.waitAnimation()
    }
    
    func waitingScreenOff(){
        self.waitLabel.removeFromSuperview()
        self.waitView.removeFromSuperview()
        self.animationView.removeFromSuperview()
    }
    
    func waitAnimation(){
        UIView.animate(withDuration: 0.8, delay: 0,
                       options: [.repeat, .autoreverse, .curveEaseInOut],
                       animations: {self.animationView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) },
                       completion: nil)
    }
    
    func sendRequest(){
        networkLayer.sendImgRequest(prompt: promptTextView.text ?? "") { data in
            DispatchQueue.main.async {
//                guard let error204 = URL(string: "https://http.cat/images/204.jpg") else { return }
                guard let imgUrl = URL(string: data[0].url) else { return }
                
                self.aiImage.load(url: imgUrl)
                self.aiImage.reloadInputViews()
                self.promptTextView.text = ""
                self.promptTextView.reloadInputViews()
                self.waitingScreenOff()

            }
        }
    }
}

extension UIImageView{
    func load(url: URL){
        DispatchQueue.global(qos: .utility).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
