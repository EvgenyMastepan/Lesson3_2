//
//  CellView.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 08.01.2025.
//

import UIKit

class CellView: UICollectionViewCell {
    static let identifier: String = "CellView"
    let ourIndent: CGFloat = 5
//    lazy var screenWidth = UIScreen.main.bounds.width - 40
    
    lazy var textLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemGray6
        contentView.addSubview(textLabel)

    }
    
    func setupCell(data: Message) {
        if data.role == "user" {
            textLabel.textAlignment = .right
            textLabel.textColor = .systemOrange
        } else {
            textLabel.textAlignment = .left
            textLabel.textColor = .black
        }
        textLabel.text = data.role + " say:\n" + data.content
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textLabel.widthAnchor.constraint(equalToConstant: 300),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
