//
//  EventGalleryCollectionViewCell.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import UIKit

class EventGalleryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "Cell Gallery"
    
    var imageView:UIImageView!
    var viewTransparent:UIView!
    var labelCaption: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _setViewComponents()
        _setViewConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("nope")
    }
    
    fileprivate func _setViewComponents(){
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        viewTransparent = UIView()
        viewTransparent.backgroundColor = .black
        viewTransparent.alpha = 0.4
        
        labelCaption = UILabel()
        labelCaption.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        labelCaption.textColor = .white
        labelCaption.numberOfLines = 0
        
        
        contentView.addSubview(imageView)
        contentView.addSubview(viewTransparent)
        contentView.addSubview(labelCaption)
    }
    
    fileprivate func _setViewConstraint(){
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
     
        viewTransparent.translatesAutoresizingMaskIntoConstraints = false
        viewTransparent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        viewTransparent.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3, constant: 0).isActive = true
        viewTransparent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        viewTransparent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        labelCaption.translatesAutoresizingMaskIntoConstraints = false
        labelCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelCaption.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        labelCaption.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
}
