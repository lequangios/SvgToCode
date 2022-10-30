//
//  MainSplitViewController.swift
//  SVG2Code
//
//  Created by Le Quang on 5/24/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

class MainSplitViewController : NSSplitViewController {
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        addLoadingListener(event: .modelChange)
    }

    override var representedObject: Any? {
        didSet{
            
        }
    }
    
    // MARK: - View Controller UI
    func setupUI(){
        // Loading placeholder with spiner
        let placeholder = NSView(frame: view.frame)
        placeholder.backgroundColor = AppTheme.organce
        let spiner = NSProgressIndicator(default: CGSize(width: 80, height: 80), color: AppTheme.yellow)
        createLoading(spiner: spiner, placeholder: placeholder)
    }
    
    // MARK: - NSSplitViewController Delegate
    override func splitViewDidResizeSubviews(_ notification: Notification) {
        layoutLoading()
        for item in splitViewItems {
            item.viewController.updateViewConstraints()
        }
    }

        
    deinit {
        removeLoadingListener(event: .modelChange)
    }
    
}

