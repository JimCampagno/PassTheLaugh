//
//  ChangeColorViewController.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 8/2/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

protocol UpdateColorDelegate {
    
    func updateColor(to color: UIColor)
    
}

final class ChangeColorViewController: UIViewController {
    
    var tableView: UITableView!
    var colorPalettes: [ColorPalette] = ColorPalette.dummyData()
    var updateColorDelegate: UpdateColorDelegate!
    let rowHeight: CGFloat = 106
    var widthOfSideBar: CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
    }
    
}

// MARK: - ColorChangeView Delegate Methods
extension ChangeColorViewController: ColorChangeViewDelegate {
    
    func colorChanged(to color: UIColor) {
        updateColorDelegate.updateColor(to: color)
        dismissViewControllerAnimated(true) { [unowned self] _ in
            self.updateColorDelegate = nil
        }
    }
    
}

// MARK: - Setup TableView
extension ChangeColorViewController {
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let centerX = tableView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.active = true
        tableView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        tableView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.7).active = true
        tableView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(ColorChangeCell.self, forCellReuseIdentifier: ColorChangeCell.identifier)
        tableView.separatorStyle = .None
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
    
}

// MARK: - TableView Datasource Methods
extension ChangeColorViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorPalettes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ColorChangeCell.identifier, forIndexPath: indexPath) as! ColorChangeCell
        cell.colorChangeView.colorDelegate = self
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }

}


// MARK: - TableView Delegate Methods
extension ChangeColorViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let colorCell = cell as! ColorChangeCell
        colorCell.colorPalette = colorPalettes[indexPath.row]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
}