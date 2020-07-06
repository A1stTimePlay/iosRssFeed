//
//  TutorialViewController.swift
//  RSSFeed
//
//  Created by Hackintosh on 5/9/20.
//  Copyright © 2020 Hackintosh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // Second view of Split view
    
    var tutorialUrl: URL!
    
    var tutorialsButtonItem : UIBarButtonItem!
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.isHidden = true
        toolbar.isHidden = true
        
        tutorialsButtonItem = UIBarButtonItem(
            title: "Tutorials",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(showTutorialsViewController))

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFirstViewControllerDisplayModeChangeWithNotification(notification:)),
            name: NSNotification.Name(rawValue: "PrimaryVCDisplayModeChangeNotification"),
            object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if tutorialUrl != nil {
            let request = URLRequest(url: tutorialUrl)
            webview.load(request)
            
            if webview.isHidden {
                webview.isHidden = false
                toolbar.isHidden = false
            }
            
            if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact {
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem, at: 0)
                
            }
        }
    }
    
    // Full screen mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.compact{
            let firstItem = toolbar.items?[0]
            if firstItem?.title == "Tutorials"{
                toolbar.items?.remove(at: 0)
            }
        }
        else if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.regular{
            if toolbar.items?.count == 3{
                toolbar.items?.remove(at: 0)
            }
            
            if splitViewController?.displayMode == UISplitViewController.DisplayMode.primaryHidden {
                toolbar.items?.insert(tutorialsButtonItem, at: 0)
            }
            else{
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem, at: 0)
            }
        }
    }
    
    //MARK: function
    @objc func showTutorialsViewController(){
        splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
    }
    
    @objc func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification){
        let displayModeObject = notification.object as? NSNumber
        let nextDisplayMode = displayModeObject?.intValue
        
        if toolbar.items?.count == 3{
            toolbar.items?.remove(at: 0)
        }
        
        if nextDisplayMode == UISplitViewController.DisplayMode.primaryHidden.rawValue {
            toolbar.items?.insert(tutorialsButtonItem, at: 0)
        }
        else{
            toolbar.items?.insert(splitViewController!.displayModeButtonItem, at: 0)
        }
    }
    
    //MARK: action
    @IBAction func showPublishDate(sender: AnyObject) {
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
}
