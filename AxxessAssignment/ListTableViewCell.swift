//
//  ListTableViewCell.swift
//  AxxessAssignment
//
//  Created by Goutham Mac Mini on 22/08/20.
//  Copyright © 2020 goutham. All rights reserved.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy private var stackView: UIStackView = {
        let hsv = UIStackView(arrangedSubviews: [self.labelData, self.imageViewCell])
        hsv.distribution    = .fill
        hsv.axis            = .horizontal
        hsv.alignment       = .center
        hsv.spacing         = 8
        addSubview(hsv)
        return hsv
    }()
    
    
    lazy var labelData: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.textColor     = .black
        return lbl
    }()
    
    lazy var imageViewCell: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        imgView.contentMode     = .scaleAspectFit
        imgView.clipsToBounds   = true
        imgView.backgroundColor = .clear
        imgView.isHidden        = false
        imgView.image = UIImage(named: "")
        return imgView
    }()
    
    // MARK: - Life cycle methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
        self.applyConstraints()
    }
    
    func applyConstraints(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
        
        let imageViewCellConstraint = NSLayoutConstraint(item: self.imageViewCell, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.imageViewCell, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 1)
        self.imageViewCell.addConstraint(imageViewCellConstraint)
        self.imageViewCell.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.imageViewCell.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        layoutSubviews()
        layoutIfNeeded()
    }
    
    //MARK: - Configure Cell Data
    
    func configureCellData(_ listData: ListModel){
        
        if(listData.type == "image"){
            
            imageViewCell.isHidden = false
            labelData.isHidden = true
            
            if let urlData = listData.data{
                
                if let urlString = URL(string: urlData){
                    imageViewCell.kf.setImage(with: urlString, placeholder: UIImage(named: "placeholder_image"))
                }
                else{
                    imageViewCell.image = UIImage(named: "placeholder_image")
                }
            }
        }
        else if(listData.type == "text"){
            
            imageViewCell.isHidden = true
            labelData.isHidden = false
            
            if let data_string = listData.data{
                labelData.text = data_string
            }
        }
        else{
            
            imageViewCell.isHidden = true
            labelData.isHidden = false
            
            if let data_string = listData.data{
                labelData.text = data_string
            }
        }
    }
}
