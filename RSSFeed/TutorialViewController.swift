//
//  TutorialViewController.swift
//  RSSFeed
//
//  Created by Hackintosh on 5/9/20.
//  Copyright © 2020 Hackintosh. All rights reserved.
//

import UIKit
import WebKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var toolbar: UIToolbar!

    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showPublishDate(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
