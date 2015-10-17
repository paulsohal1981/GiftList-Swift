//
//  GiftListIntro.swift
//  Papoose
//
//  Created by paul sohal on 7/28/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import UIKit

class GiftListIntroController : UIViewController, BWWalkthroughViewControllerDelegate
{
    var dataContext = DataContext()
    //var parseAnalyticUtility = ParseAnalyticUtility()
    var introHasShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           }
    
    override func viewDidAppear(animated: Bool) {
        
        if(introHasShow == false)
        {
            let gifts = self.dataContext.GetAllGifts()
        
            if (gifts.count > 0)
            {
                performSegueWithIdentifier("GiftListSegue", sender: self)
                //launch segue into the app
            }
            else
            {
                //performSegueWithIdentifier("GiftListSegue", sender: self)
                StartWalkThrough()
            }
        }
        else
        {
            performSegueWithIdentifier("GiftListSegue", sender: self)
        }
    }
    
    func StartWalkThrough()
    {
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let walkthrough = stb.instantiateViewControllerWithIdentifier("walk0") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("walk1") 
        let page_two = stb.instantiateViewControllerWithIdentifier("walk2")
        let page_three = stb.instantiateViewControllerWithIdentifier("walk3")
        
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
        
        //parseAnalyticUtility.TourStarted();
        self.presentViewController(walkthrough, animated: true, completion: nil)
    }
    
    func walkthroughCloseButtonPressed()
    {
         //parseAnalyticUtility.TourEnded();
         introHasShow = true
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walkthroughPageDidChange(currentPage: Int)
    {
        if(currentPage == 2)
        {
            //Enable Get Started button
           // sleep(2)
            //walkthroughCloseButtonPressed()
        }
    }
    
}
