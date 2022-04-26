//
//  ImagesCollectionViewCell.swift
//  Assignment4
//
//  Created by Kapil Ganesh Shanbhag on 25/04/22.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collcellimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //collcellimage.image?.size=CGSize(width: 150.0, height: 150.0)
//        collcellimage.heightAnchor.constraint(equalToConstant: 150.0)
//        collcellimage.widthAnchor.constraint(equalToConstant: 150.0)
        
    }

    func setupCell(_ img: UIImage,width: CGFloat, height: CGFloat) {
        collcellimage.frame.size = CGSize(width: width, height: height)
        collcellimage.image = img
        collcellimage.translatesAutoresizingMaskIntoConstraints = true
    }
}
