//
//  ViewController.swift
//  day03
//
//  Created by Oleksandr MALTSEV on 6/27/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var imageView: UIImageView?
    var image: UIImage?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    let queue = DispatchQueue.global(qos: DispatchQoS.userInteractive.qosClass)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionCell
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        let alert = UIAlertController.init(title: "Error", message: "Cannot access to \(String(describing: images.image[indexPath.row]))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        let url = URL(string: images.image[indexPath.row])
        cell.activityIndicator.startAnimating()
        queue.async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    cell.imageView.image = self.image
                }
            } else {
                self.present(alert, animated: true, completion: nil)
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SecondViewClassViewController {
        let vc = segue.destination as? SecondViewClassViewController
            if let collectionView = self.collectionView,
                let indexPath = collectionView.indexPathsForSelectedItems?.first,
                let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionCell,
                let data = cell.imageView.image {
                vc?.imageToPut = data
            }
        }
}

}
