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
    
    private func commonInit() {
        contentView.backgroundColor = UIColor.clearColor()
        
        colorChangeView = ColorChangeView(frame: CGRectZero)
        colorChangeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorChangeView)
        colorChangeView.leftAnchor.constraintEqualToAnchor(contentView.leftAnchor).active = true
        colorChangeView.rightAnchor.constraintEqualToAnchor(contentView.rightAnchor).active = true
        colorChangeView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor).active = true
        colorChangeView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}