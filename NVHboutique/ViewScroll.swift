//
//  ViewScroll.swift
//  NVHboutique
//
//  Created by Hùng Nguyễn  on 7/21/16.
//  Copyright © 2016 MobileSoftware. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var pageImages: [String] = []
    var first = false
    var currentPage = 0
    var photo:  [UIImageView] = []
    var newScrollView:  [UIScrollView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["pic1","pic2","pic3","pic4","pic5","pic6","pic7","pic8"]
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
    }
    
    override func viewDidLayoutSubviews() {
        if (!first) {
             first = true
            let pageScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSizeMake( pageScrollViewSize.width * CGFloat(pageImages.count), 0)
            scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
            for (var i = 0; i < pageImages.count;i++)
            {
                let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
                imgView.frame = CGRectMake( 0 , 0, scrollView.frame.size.width, scrollView.frame.size.height)
                
                imgView.contentMode = .ScaleAspectFit
                // set userInteractionEnabled = true user can interacte with imgView
                imgView.userInteractionEnabled = true
                // can double tap imgView
                imgView.multipleTouchEnabled = true
                
                // tap gesture
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg))
                tap.numberOfTapsRequired = 1 // need 1 tap
                imgView.addGestureRecognizer(tap) // add tap GestureRecognizer to imgView
                
                // double tap
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dobleTapImg))
                doubleTap.numberOfTapsRequired = 2 // need 2 tap
                
                // nhan tap ,sau do doubleTap ,neu doubleTap fail -> tap
                tap.requireGestureRecognizerToFail(doubleTap)
                imgView.addGestureRecognizer(doubleTap)
                
               
                    photo.append(imgView)
                              //
                let frontScollView = UIScrollView(frame: CGRectMake(CGFloat(i) * scrollView.frame.size.width , 0, scrollView.frame.size.width, scrollView.frame.size.height))
                frontScollView.minimumZoomScale = 0.5
                frontScollView.maximumZoomScale = 3
                frontScollView.delegate = self
                frontScollView.addSubview(imgView)
                newScrollView.append(frontScollView)
                self.scrollView.addSubview(frontScollView)
                
            }

        }
    }
    
    //  tap vao pageController thi chuyen content
    @IBAction func changePage(sender: AnyObject) {
        scrollView.contentOffset = CGPointMake((CGFloat(pageController.currentPage) * scrollView.frame.size.width), 0)
        
        
    }
    
    @IBAction func previousButton(sender: UIButton) {
        if pageController.currentPage == 0
        {
            pageController.currentPage = pageController.numberOfPages
            scrollView.contentOffset = CGPointMake((CGFloat(pageController.currentPage) * scrollView.frame.size.width), 0)
        } else
        {
            pageController.currentPage -= 1
            scrollView.contentOffset = CGPointMake((CGFloat(pageController.currentPage) * scrollView.frame.size.width), 0)
        }
        
    }
    
    @IBAction func nextButton(sender: UIButton) {
       if pageController.currentPage == pageController.numberOfPages - 1
       {
            pageController.currentPage = 0
            scrollView.contentOffset = CGPointMake((CGFloat(pageController.currentPage) * scrollView.frame.size.width), 0)
       } else
       {
            pageController.currentPage += 1
        scrollView.contentOffset = CGPointMake((CGFloat(pageController.currentPage) * scrollView.frame.size.width), 0)
        }
       
    }
    
    
    
    func tapImg(gesture: UITapGestureRecognizer) -> Void {
        // lay toa do cua diem tap
        let position = gesture.locationInView(photo[pageController.currentPage])
        // call zoomRectForScale to zoom
        zoomRectForScale(newScrollView[pageController.currentPage].zoomScale * 1.5, center: position)
        
    }
    
    func dobleTapImg(gesture: UITapGestureRecognizer) -> Void {
        let position = gesture.locationInView(photo[pageController.currentPage])
        zoomRectForScale(newScrollView[pageController.currentPage].zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> Void {
        // khoi tao 1 hinh  Rect de zoom
        var zoomRect = CGRect()
        // lay scrollViewSize
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        
        // fetch origin of zoomRect
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        // zoom  scrollView to Rect
        newScrollView[pageController.currentPage].zoomToRect(zoomRect, animated: true)
    }

    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo[pageController.currentPage]
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        switch scrollView.contentOffset {
        case CGPointMake(0, 0):
            pageController.currentPage = 0
        case CGPointMake(scrollView.frame.size.width, 0):
            pageController.currentPage = 1
        case CGPointMake(2 * scrollView.frame.size.width, 0):
            pageController.currentPage = 2
        case CGPointMake(3 * scrollView.frame.size.width, 0):
            pageController.currentPage = 3
        case CGPointMake(4 * scrollView.frame.size.width, 0):
            pageController.currentPage = 4
        case CGPointMake(5 * scrollView.frame.size.width, 0):
            pageController.currentPage = 5
        case CGPointMake(6 * scrollView.frame.size.width, 0):
            pageController.currentPage = 6
        case CGPointMake(7 * scrollView.frame.size.width, 0):
            pageController.currentPage = 7
        default:
            break
        }
   }
    
}
