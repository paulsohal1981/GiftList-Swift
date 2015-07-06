//
//  ImageZoomController.swift
//  GiftList
//
//  Created by paul sohal on 6/21/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import UIKit

class ImageZoomController : UIViewController, UIScrollViewDelegate {
        var image: UIImage? = nil
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Image
        self.mainImage.image = self.image
        
        //Set zoom for scroll view
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 50
        self.scrollView.delegate = self
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.mainImage
    }
}