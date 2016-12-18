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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    }
    
}

// MARK: - Color Change Methods
extension AlphaViewController {
    
    fileprivate func colorDidChange() {
        if slider != nil {
            slider.thumbTintColor = currentColor
            slider.tintColor = currentColor
            dummyView.backgroundColor = currentColor
        }
    }
    
}

// MARK: - Slider Methods
extension AlphaViewController {
    
    fileprivate func createSlider() {
        slider = UISlider(frame: CGRect.zero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changeAlpha), for: .valueChanged)
        slider.minimumValue = 0.1
        slider.maximumValue = 1.0
        view.addSubview(slider)
        let centerX = slider.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.isActive = true
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        slider.value = Float(currentAlphaValue)
        slider.thumbTintColor = currentColor
        slider.tintColor = currentColor
    }
    
    func changeAlpha(_ sender: UISlider) {
        currentColor = currentColor.withAlphaComponent(CGFloat(sender.value))
        currentAlphaValue = CGFloat(sender.value)
    }
    
    
}

// MARK: - Dummy View Methods
extension AlphaViewController {
    
    fileprivate func setupDummyView() {
        let height = view.bounds.size.height * 0.30
        let width = height
        dummyView = UIView(frame: CGRect.zero)
        dummyView.backgroundColor = currentColor.withAlphaComponent(currentAlphaValue)
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dummyView)
        dummyView.widthAnchor.constraint(equalToConstant: width).isActive = true
        dummyView.heightAnchor.constraint(equalToConstant: height).isActive = true
        let centerX = dummyView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.isActive = true
        let centerY = dummyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerY.constant -= view.frame.size.height / 4
        centerY.isActive = true
        
        dummyView.clipsToBounds = true
        dummyView.layer.cornerRadius = height / 2
    }
    
}

// MARK: - OK Button
extension AlphaViewController {
    
    fileprivate func setupOKButton() {
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        button.setTitle("🚀", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 45.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        let centerX = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.isActive = true
        let centerY = button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerY.constant += view.frame.size.height / 4
        centerY.isActive = true
    }
    
    func okTapped(_ sender: UIButton) {
        updateAlphaDelegate.updateAlpha(to: currentAlphaValue)
        dismiss(animated: true) { [unowned self] _ in
            self.updateAlphaDelegate = nil
        }
    }
    
}

