//
//  LargeElementVC.swift
//  EHAdaptiveElements
//
//  Created by Eric Ho on 9/7/2016.
//  Copyright © 2016 Eric Ho. All rights reserved.
//

import UIKit

class LargeElementVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if self.isBeingPresented() {
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
            self.view.addGestureRecognizer(tapGR)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(gestureRecognizer:UITapGestureRecognizer) {
        if gestureRecognizer.state == .Ended {
            self.dismissViewControllerAnimated(true, completion: {})
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
