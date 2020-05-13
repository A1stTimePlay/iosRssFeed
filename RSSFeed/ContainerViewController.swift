//
//  ContainerViewController.swift
//  RSSFeed
//
//  Created by Hackintosh on 5/9/20.
//  Copyright © 2020 Hackintosh. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var viewController: UISplitViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setEmbeddedViewController(splitViewController: UISplitViewController!){
        if splitViewController != nil{
            viewController = splitViewController
            
            self.addChild(viewController)
            self.view.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height{
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.regular), forChild: viewController)
        }
        else{
            self.setOverrideTraitCollection(nil, forChild: viewController)
        }
        
        super.viewWillTransition(to: size, with: coordinator)
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
