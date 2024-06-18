//
//  ViewController.swift
//  DragAndDrop
//
//  Created by 根岸智也 on 2024/06/18.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  
  @IBOutlet weak var collection: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    collection.delegate = self
    collection.dataSource = self
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    12
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let label = cell.contentView.viewWithTag(1) as! UILabel
    label.text = String(indexPath.row + 1)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let horizontalSpace:CGFloat = 5
    
    let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace * 2
    
    return CGSize(width: cellSize, height: cellSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
  }
}
