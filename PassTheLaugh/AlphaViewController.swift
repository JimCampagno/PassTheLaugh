//
//  AlphaViewController.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 8/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

protocol UpdateAlphaDelegate {
    
    func updateAlpha(to alpha: CGFloat)
    
}

class AlphaViewController: UIViewController {
    
    var slider: UISlider!
    var widthOfSideBar: CGFloat!
    var currentColor: UIColor! {
        didSet { colorDidChange() }
    }
    var currentAlphaValue: CGFloat!
    var dummyView: UIView!
    var updateAlphaDelegate: UpdateAlphaDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSlider()
        setupDummyView()
        setupOKButton()
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
    }
    
}

// MARK: - Color Change Methods
extension AlphaViewController {
    
    private func colorDidChange() {
        if slider != nil {
            slider.thumbTintColor = currentColor
            slider.tintColor = currentColor
            dummyView.backgroundColor = currentColor
        }
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
    }
    
    
}

// MARK: - Dummy View Methods
extension AlphaViewController {
    
    private func setupDummyView() {
        let height = view.bounds.size.height * 0.30
        let width = height
        dummyView = UIView(frame: CGRectZero)
        dummyView.backgroundColor = currentColor.colorWithAlphaComponent(currentAlphaValue)
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dummyView)
        dummyView.widthAnchor.constraintEqualToConstant(width).active = true
        dummyView.heightAnchor.constraintEqualToConstant(height).active = true
        let centerX = dummyView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.active = true
        let centerY = dummyView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
        centerY.constant -= view.frame.size.height / 4
        centerY.active = true
    }
    
}

// MARK: - OK Button
extension AlphaViewController {
    
    private func setupOKButton() {
        
        let button = UIButton(type: .System)
        button.addTarget(self, action: #selector(okTapped), forControlEvents: .TouchUpInside)
        button.setTitle("🚀", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(45.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.heightAnchor.constraintEqualToConstant(60).active = true
        button.widthAnchor.constraintEqualToConstant(60).active = true
        let centerX = button.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.active = true
        let centerY = button.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
        centerY.constant += view.frame.size.height / 4
        centerY.active = true
    }
    
    func okTapped(sender: UIButton) {
        updateAlphaDelegate.updateAlpha(to: currentAlphaValue)
        dismissViewControllerAnimated(true) { [unowned self] _ in
            self.updateAlphaDelegate = nil
        }
    }
    
}

