//
//  ListImages.swift
//  NVHboutique
//
//  Created by Hùng Nguyễn  on 7/25/16.
//  Copyright © 2016 MobileSoftware. All rights reserved.
//

import UIKit

class ListImages: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onTouch(sender: UIButton) {
        switch sender.tag {
        case 101:   
            pushView(1)
        case 102:
            pushView(2)
        case 103:
            pushView(3)
        case 104:
            pushView(4)
        case 105:
            pushView(5)
        case 106:
            pushView(6)
        case 107:
            pushView(7)
        case 108:
            pushView(0)
        default:
            break
        }
    }

    func pushView(index :Int) -> Void {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewScroll") as? ViewScroll
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
