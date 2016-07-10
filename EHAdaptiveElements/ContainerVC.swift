//
//  ContainerVC.swift
//  EHAdaptiveElements
//
//  Created by Eric Ho on 9/7/2016.
//  Copyright © 2016 Eric Ho. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    var elementViewControllers: [UIViewController?] = [nil, nil, nil]
    var displayedDesign: Design? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        /*
         In viewWillLayoutSubviews, we are guaranteed that our view's size, traits, etc. are up to date.
         It's a good place to update anything that affects the layout of our subviews.
         However, be careful, because this method is called frequently!
         Do as little work as possible, and don't invalidate the layout of any superviews.
         */
        
        // Step 1: Find our size.
        let size = view.bounds.size
        
        // Step 2: Decide what design to use, based on our rules.
        let newDesign = decideDesign(size)
        
        // Step 3: If the design is different than what is displayed, change the UI.
        if displayedDesign != newDesign {
            applyDesign(newDesign)
            displayedDesign = newDesign
        }
    }
    
    func decideDesign(size: CGSize) -> Design {
        /*
         Decide which Design is appropriate, given the size of our view, by applying rules.
         
         Note that these rules are _examples_, which produce good results in this particular sample app,
         but they are not general rules that would automatically work in other apps.
         */
        
        /*
         Decision #1: Should our elements be laid out horizontally or vertically?
         Rule: If the width is greater that the height, be horizontal, otherwise be vertical.
         */
        let axis: UILayoutConstraintAxis
        if size.width > size.height {
            axis = .Horizontal
        }
        else {
            axis = .Vertical
        }
        
        /*
         Decision #2: Should our elements be small or large?
         Rule: If the width is less than a threshold value, be small, otherwise be large.
         (We chose 750 as a threshold value since it produces reasonable results for this example,
         but there is nothing special about that number.)
         */
        let widthThreshold = CGFloat(750)
        
        let elementKind: Design.ElementKind
        if size.width < widthThreshold {
            elementKind = .small
        }
        else {
            elementKind = .large
        }
        
        // Return a Design encapsulating the results of those decisions.
        return Design(axis: axis, elementKind: elementKind)
    }
    
    func applyDesign(newDesign: Design) {
        /*
         Change the view controllers and views to display the new design.
         Be careful to only change properties that need to be changed.
         */
        
        // Set the stack view's layout axis to horizontal or vertical.
        if displayedDesign?.axis != newDesign.axis {
            stackView.axis = newDesign.axis
        }
        
        // Change the view controllers to the small or large kind.
        if displayedDesign?.elementKind != newDesign.elementKind {
            // Repeat these steps for each of the element view controllers:
            for (index, elementViewController) in self.elementViewControllers.enumerate() {
                // If an old view controller exists, then remove it from this container's child view controllers.
                if let oldElementViewController = elementViewController {
                    removeOldElementViewController(oldElementViewController)
                }
                
                // Create the new view controller.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newElementViewController = storyboard.instantiateViewControllerWithIdentifier(newDesign.elementIdentifier)
                
                // Add it as a child view controller of this container.
                addNewElementViewController(newElementViewController)
                
                // And remember it, so we can remove it later.
                elementViewControllers[index] = newElementViewController
            }
        }
    }
    
    
    /*
     Helper functions to be a well-behaved container view controller:
     */
    func addNewElementViewController(elementViewController: UIViewController)
    {
        // Step 1: Add this view controller to our list of child view controllers.
        //         This will call elementViewController.willMove(toParentViewController: self).
        addChildViewController(elementViewController)
        
        // Step 2: Add the view controller's view to our view hierarchy.
        stackView.addArrangedSubview(elementViewController.view)
        
        // Step 3: Tell the view controller that it has moved, and `self` is the new parent.
        elementViewController.didMoveToParentViewController(self)
    }
    
    func removeOldElementViewController(elementViewController: UIViewController)
    {
        // Step 1: Tell the view controller that it will move to having no parent view controller.
        elementViewController.willMoveToParentViewController(nil)
        
        // Step 2: Remove the view controller's view from our view hierarchy.
        elementViewController.view.removeFromSuperview()
        
        // Step 3: Remove the view controller from our list of child view controllers.
        //         This will call elementViewController.didMove(toParentViewController: nil).
        elementViewController.removeFromParentViewController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
