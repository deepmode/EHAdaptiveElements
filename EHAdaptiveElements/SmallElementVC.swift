//
//  SmallElementVC.swift
//  EHAdaptiveElements
//
//  Created by Eric Ho on 9/7/2016.
//  Copyright © 2016 Eric Ho. All rights reserved.
//

import UIKit

class SmallElementVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add a constraint to make this view always square.
        //let constraint = view.widthAnchor.constraint(equalTo: view.heightAnchor)
        let constraint = view.widthAnchor.constraintEqualToAnchor(view.heightAnchor)
        
        constraint.active = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.view.addGestureRecognizer(tapGR)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(gestureRecognizer:UITapGestureRecognizer) {
        if gestureRecognizer.state == .Ended {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("SBID_LargeElement")
            vc.modalPresentationStyle = .OverFullScreen
            self.presentViewController(vc, animated: true, completion: {})
        }
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        /*
         When we are removed from our parent view controller
         (which could happen when the parent changes to a different Design),
         if we presented the ElementViewController, then dismiss it.
         */
        if parent == nil && presentedViewController != nil {
            self.dismissViewControllerAnimated(false, completion: {})
        }
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
