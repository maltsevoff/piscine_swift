//
//  SecondViewClassViewController.swift
//  day03
//
//  Created by Oleksandr MALTSEV on 6/28/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class SecondViewClassViewController: UIViewController, UIScrollViewDelegate {

    var imageToPut: UIImage?
    var imageView: UIImageView?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: imageToPut)
        scrollView.addSubview(imageView!)
        scrollView.contentSize = imageView!.frame.size
        scrollView.maximumZoomScale = 100
        scrollView.minimumZoomScale = 0.3
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func setZoomScale() {
        var minZoom = min(self.view.bounds.size.width / imageView!.bounds.size.width, self.view.bounds.size.height / imageView!.bounds.size.height)
        if (minZoom > 1.0) {
            minZoom = 1.0
        }
        scrollView.minimumZoomScale = minZoom
        scrollView.zoomScale = minZoom
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
}
