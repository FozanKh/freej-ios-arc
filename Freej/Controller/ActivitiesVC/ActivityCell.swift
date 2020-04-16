//
//  ActivityCell.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivityTypeCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
	@IBOutlet weak var collectionView: UICollectionView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		configureCollectionView()
    }
	
	func configureCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return CollectionCell()
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
