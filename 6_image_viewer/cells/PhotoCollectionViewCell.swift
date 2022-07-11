//
//  PhotoCollectionViewCell.swift
//  6_image_viewer
//
//  Created by David Granado Jordan on 6/15/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
