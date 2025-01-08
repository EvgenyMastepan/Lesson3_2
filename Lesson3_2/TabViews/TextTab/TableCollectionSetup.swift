//
//  TableCollectionSetup.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 08.01.2025.
//

import UIKit

extension TextTabController: UICollectionViewDataSource, UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allMessages.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.identifier, for: indexPath) as! CellView
        let card = allMessages[indexPath.item]
        cell.setupCell(data: card)
        
        return cell
    }
    
    
}
    
    
    
    

