//
//  EventTableViewCell.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    var labelName:UILabel!
    var labelDescription:UILabel!
    var imageViewThumb:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setViewComponents()
        _setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No coder, no problem.")
    }
    
    fileprivate func _setViewComponents(){
        labelName = UILabel()
        labelName.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        labelName.textColor = UIColor.black
        
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        labelDescription.textColor = UIColor.black
        labelDescription.numberOfLines = 0
        
        
        
        imageViewThumb = UIImageView()
        imageViewThumb.contentMode = .scaleAspectFit
        
        contentView.addSubview(labelName)
        contentView.addSubview(labelDescription)
        contentView.addSubview(imageViewThumb)
        
    }
    
    fileprivate func _setViewConstraints(){
        
        imageViewThumb.translatesAutoresizingMaskIntoConstraints = false
        imageViewThumb.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageViewThumb.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageViewThumb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imageViewThumb.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true

        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.leadingAnchor.constraint(equalTo: imageViewThumb.trailingAnchor, constant: 5).isActive = true
        labelName.topAnchor.constraint(equalTo: imageViewThumb.topAnchor, constant: 0).isActive = true
        labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.leadingAnchor.constraint(equalTo: imageViewThumb.trailingAnchor, constant: 5).isActive = true
        labelDescription.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
}
