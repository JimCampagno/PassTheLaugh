//
//  ViewController.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 7/31/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Test Out Image Download Methods
extension ViewController {
    
    private func test() {
        setupImageView()
        displayTestImage()
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: CGRectZero)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        imageView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        imageView.contentMode = .ScaleAspectFit
    }
    
    private func displayTestImage() {
        FirebaseAPIclient.downloadImageAtURL(Constants.testimage) { [unowned self] image in
            guard let image = image else { return }
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView.image = image
            }
        }
    }
    
}