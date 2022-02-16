//
//  ViewController.swift
//  stromviewer in collectionview
//
//  Created by Akay Prince on 16/02/22.
//

import UIKit

class ViewController: UICollectionViewController {

    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                images.append(item)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCell else{fatalError()}
        cell.imageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        vc.selectedImage = images[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Image \(indexPath.row + 1) of \(images.count)"
    }
}

