//
//  ViewController.swift
//  day06
//
//  Created by Oleksandr MALTSEV on 7/2/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var dynamicAnimator: UIDynamicAnimator?
    let gravityBehavior = UIGravityBehavior()
    let collisionBehavior = UICollisionBehavior()
    let itemBehavior = UIDynamicItemBehavior()
    
    let motionManager = CMMotionManager()
    
    override  func viewWillAppear(_ animated: Bool) {
        print("viewillappear")
        super.viewWillAppear(animated)
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            motionManager.startAccelerometerUpdates(to: queue, withHandler: accHandler)
        }
        else {
            print("accelerometer is not available")
        }
    }
    
    func accHandler(data: CMAccelerometerData?, error: Error?) {
        if let myData = data {
            let x = CGFloat(myData.acceleration.x)
            let y = CGFloat(myData.acceleration.y)
            let v = CGVector(dx: x, dy: -y)
            gravityBehavior.gravityDirection = v
            gravityBehavior.magnitude = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicAnimator?.addBehavior(gravityBehavior)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator?.addBehavior(collisionBehavior)
        dynamicAnimator?.addBehavior(itemBehavior)
        itemBehavior.elasticity = 0.5
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        print("tapped")
        let tapLocation = sender.location(in: self.view)
        let shapeClass = ShapeClass(location: tapLocation)
//        currentSubview = ShapeClass(location: tapLocation)
        self.view.addSubview(shapeClass.figure ?? UIView())
        gravityBehavior.magnitude = 10
        collisionBehavior.addItem(shapeClass.figure!)
        gravityBehavior.addItem(shapeClass.figure!)
        itemBehavior.addItem(shapeClass.figure!)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        let rotGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGesture(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(_:)))
        shapeClass.figure?.addGestureRecognizer(gesture)
        shapeClass.figure?.addGestureRecognizer(rotGesture)
        shapeClass.figure?.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinchGesture(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            gravityBehavior.removeItem(gesture.view!)
            collisionBehavior.removeItem(gesture.view!)
            itemBehavior.removeItem(gesture.view!)
        case .changed:
            let height = gesture.view?.bounds.height
            if (height! * gesture.scale <= 300 && gesture.scale > 1) {
                gesture.view?.layer.bounds.size.height *= gesture.scale
                gesture.view?.layer.bounds.size.width *= gesture.scale
            } else if (height! * gesture.scale > 50 && gesture.scale < 1) {
                gesture.view?.layer.bounds.size.height *= gesture.scale
                gesture.view?.layer.bounds.size.width *= gesture.scale
            }
        case .ended:
            gravityBehavior.addItem(gesture.view!)
            collisionBehavior.addItem(gesture.view!)
            itemBehavior.addItem(gesture.view!)
        default:
            print("Default in pinchGesture")
        }
    }
    
    @objc func rotationGesture(_ gesture: UIRotationGestureRecognizer) {
        switch gesture.state {
        case .began:
            gravityBehavior.removeItem(gesture.view!)
            itemBehavior.removeItem(gesture.view!)
        case .changed:
            gesture.view?.transform = view.transform.rotated(by: gesture.rotation)
        case .ended:
            gravityBehavior.addItem(gesture.view!)
            itemBehavior.addItem(gesture.view!)
        default:
            print("Default in rotationGesture")
        }
    }
    
    @objc func panGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            gravityBehavior.removeItem(gesture.view!)
        case .changed:
            gesture.view?.center = gesture.location(in: gesture.view?.superview)
            dynamicAnimator?.updateItem(usingCurrentState: gesture.view!)
        case .ended:
            gravityBehavior.addItem(gesture.view!)
        default:
            print("Default in panGesture")
        }
    }
}

