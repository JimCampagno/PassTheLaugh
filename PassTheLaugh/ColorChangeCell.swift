//
//  ColorChangeCell.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 8/2/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class ColorChangeCell: UITableViewCell {
    
    var colorChangeView: ColorChangeView!
    var colorPalette: ColorPalette! {
        didSet { colorChangeView.colorPalette = colorPalette }
    }
    static let identifier = "ColorCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        contentView.backgroundColor = UIColor.clear
        
        colorChangeView = ColorChangeView(frame: CGRect.zero)
        colorChangeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorChangeView)
        colorChangeView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        colorChangeView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        colorChangeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        colorChangeView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
