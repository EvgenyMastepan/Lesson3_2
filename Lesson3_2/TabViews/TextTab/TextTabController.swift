//
//  TextTabController.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import UIKit

class TextTabController: UIViewController {
    private let networkLayer = NetworkLayer()
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let ourIndent: CGFloat = 5
    var collectionViewWidth: CGFloat = 100
    var allMessages = [Message]()
    
    lazy var aiTableCollectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ourIndent
        layout.minimumInteritemSpacing = ourIndent
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 20
        $0.contentInset = UIEdgeInsets(top: ourIndent, left: 0, bottom: ourIndent, right: 0)
        $0.delegate = self
        $0.dataSource = self
        $0.register(CellView.self, forCellWithReuseIdentifier: CellView.identifier)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout()))
    
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
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubviews(aiTableCollectionView, promptTextView, sendButton, descriptionTextLabel)
        setupConstraints()
        collectionViewWidth = aiTableCollectionView.bounds.width
    }
    
    // MARK: - Constraints
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            aiTableCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aiTableCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            aiTableCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            aiTableCollectionView.heightAnchor.constraint(equalToConstant: screenWidth - 20),
            
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            sendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
        
            promptTextView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20),
            promptTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            promptTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            promptTextView.topAnchor.constraint(equalTo: aiTableCollectionView.bottomAnchor, constant: 20),
            
            descriptionTextLabel.centerXAnchor.constraint(equalTo: promptTextView.centerXAnchor),
            descriptionTextLabel.centerYAnchor.constraint(equalTo: promptTextView.topAnchor, constant: -10),
            descriptionTextLabel.widthAnchor.constraint(equalToConstant: 300),
            descriptionTextLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Function Chapter
    
    func scrollToBottom(){
        let item = collectionView(self.aiTableCollectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndex = IndexPath(item: item, section: 0)
        self.aiTableCollectionView.scrollToItem(at: lastItemIndex, at: .top, animated: false)
    }
    
    func waitAnimation(){
        UIView.animate(withDuration: 0.8, delay: 0,
                       options: [.repeat, .autoreverse, .curveEaseInOut],
                       animations: {self.animationView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) },
                       completion: nil)
    }
    
    
    func waitingScreenOn(){
        self.view.addSubviews(self.waitView, self.waitLabel, self.animationView)
        NSLayoutConstraint.activate([
            waitView.centerXAnchor.constraint(equalTo: aiTableCollectionView.centerXAnchor),
            waitView.centerYAnchor.constraint(equalTo: aiTableCollectionView.centerYAnchor),
            waitView.heightAnchor.constraint(equalTo: aiTableCollectionView.heightAnchor),
            waitView.widthAnchor.constraint(equalTo: aiTableCollectionView.widthAnchor),

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
    
    func sendRequest(){
        networkLayer.sendRequest(prompt: promptTextView.text ?? "") { choices in
            DispatchQueue.main.async {
                let ourMessage: Message = .init(role: "user", content: self.promptTextView.text)
                self.allMessages.append(ourMessage)
                self.aiTableCollectionView.reloadData()
                print(choices.first?.message.content ?? "")
                self.allMessages.append(choices[0].message)
                self.promptTextView.text = ""
                self.promptTextView.reloadInputViews()
                self.aiTableCollectionView.reloadData()
                self.scrollToBottom()
                self.waitingScreenOff()
                
            }
        }
    }
}
