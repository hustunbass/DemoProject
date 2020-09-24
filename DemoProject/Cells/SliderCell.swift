//
//  SliderCell.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 22.09.2020.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!{
        
        didSet{
            imageView.image = image
        }
    }
    
}
