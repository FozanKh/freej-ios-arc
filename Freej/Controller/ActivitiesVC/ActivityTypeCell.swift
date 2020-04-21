//
//  ActivityCell.swift
//  Freej
//
//  Created by Abdulelah Hajjar on 16/04/2020.
//  Copyright © 2020 Squadra. All rights reserved.
//

import UIKit

class ActivityTypeCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	@IBOutlet weak var collectionView: UICollectionView!
	var acTID = -1
	var speceficActivityArray = [Activity]()
	
	func setupCell() {
		if Activity.activitiesDict?.keys.contains(acTID) ?? false {
			speceficActivityArray = Activity.activitiesDict?[acTID] ?? [Activity]()
		}
		configureCollectionView()
	}
	
	func configureCollectionView() {
		collectionView.register(UINib(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCell")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView.reloadData()
		if(speceficActivityArray.count > 0) {
			collectionView.collectionViewLayout = layout
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return speceficActivityArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 20.0
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionViewCell", for: indexPath) as! ActivityCollectionViewCell
		cell.activity = speceficActivityArray[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width - 60.0, height: frame.height - 40)
	}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
