//
//  SVGCodeViewController.swift
//  SVG2Code
//
//  Created by Le Quang on 5/17/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa
import WebKit
import Sourceful

class SVGCodeViewController: NSViewController {
    @IBOutlet weak var toucheventBtn: NSButton!
    @IBOutlet weak var extensionBtn: NSButton!
    @IBOutlet weak var codeView: NSView!
    
    private var syntaxTextView:SyntaxTextView!
    
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
        settingUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDataListener()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLayout(){
        super.viewDidLayout()
    }
    
    // MARK: - View Controller UI Setting
    func settingUI(){
        syntaxTextView = SyntaxTextView(frame: .zero)
        syntaxTextView.translatesAutoresizingMaskIntoConstraints = false
        codeView.addSubview(syntaxTextView)
        syntaxTextView.backgroundColor  = AppTheme.organce
        syntaxTextView.contentTextView.delegate = syntaxTextView
        syntaxTextView.theme = DefaultSourceCodeTheme()
        codeView.addConstraints([syntaxTextView.top(toView: codeView), syntaxTextView.bottom(toView: codeView), syntaxTextView.leading(toView: codeView), syntaxTextView.trailing(toView: codeView)])
       
    }
}

// MARK: - View Controller Data Binding
extension SVGCodeViewController {
    @objc func map(notification: NSNotification){
        if let data = notification.userInfo as? [String:String] {
            if let code = data["code"] {
                syntaxTextView.text = code
            }
        }
    }
    
    func addDataListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(map(notification:)), name: DataEvent.svgCodeChange.notification(), object: nil)
    }
}
