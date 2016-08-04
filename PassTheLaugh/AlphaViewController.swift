//
//  AlphaViewController.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 8/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class AlphaViewController: UIViewController {
    
    var slider: UISlider!
    var widthOfSideBar: CGFloat!
    var currentColor: UIColor!
    var currentAlphaValue: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        createSlider()
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)

        
        

    }
    
    
    
}

// MARK: - Slider Methods
extension AlphaViewController {
    
    private func createSlider() {
        slider = UISlider(frame: CGRectZero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changeAlpha), forControlEvents: .ValueChanged)
        slider.minimumValue = 0.1
        slider.maximumValue = 1.0
        view.addSubview(slider)
        let centerX = slider.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.active = true
        slider.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        slider.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.7).active = true
        slider.value = Float(currentAlphaValue)
        slider.thumbTintColor = currentColor
        slider.tintColor = currentColor
    }
    
    func changeAlpha(sender: UISlider) {
        currentColor = currentColor.colorWithAlphaComponent(CGFloat(sender.value))
        currentAlphaValue = CGFloat(sender.value)
        slider.thumbTintColor = currentColor
    }
    
    
}

// MARK: - Dummy View Methods
extension AlphaViewController {
    
    private func setupDummyView() {
        
        
    }
    
}

