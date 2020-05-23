import UIKit

class ContainerViewController: UIViewController {
    
    var viewController: UISplitViewController!
    
    var menuViewController: UIViewController!
    
    var homeViewController: HomeViewController!

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
}
