//
//  ViewController.swift
//  DragAndDrop
//
//  Created by 根岸智也 on 2024/06/18.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collection: UICollectionView!
  
  var numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    collection.delegate = self
    collection.dataSource = self
    collection.dropDelegate = self
    collection.dragDelegate = self
    collection.dragInteractionEnabled = true
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.layer.cornerRadius = 8
    let label = cell.contentView.viewWithTag(1) as! UILabel
    label.text = String(numberList[indexPath.row])
    return cell
  }
  

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let horizontalSpace:CGFloat = 5
    let cellSize:CGFloat = self.view.bounds.width / 3 - horizontalSpace * 2
    return CGSize(width: cellSize, height: cellSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let tapItem = numberList[indexPath.row]
    print("タップ: \(tapItem)")
  }
}

extension ViewController: UICollectionViewDragDelegate {
  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let item = "\(numberList[indexPath.row])" as NSString
    let itemProvider = NSItemProvider(object: item)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = item
    print("ドラッグ: \(item)")
    return [dragItem]
  }
}

extension ViewController: UICollectionViewDropDelegate {
  
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: any UICollectionViewDropCoordinator) {
    if coordinator.proposal.operation == .move {
      guard let item = coordinator.items.first else { return }
      guard let sourceIndex = item.sourceIndexPath else { return }
      guard let destinationIndex = coordinator.destinationIndexPath else { return }
      
      guard let stringItem = item.dragItem.localObject as? String else { return }
      guard let intItem = Int(stringItem) else { return }
      
      collectionView.performBatchUpdates({
        self.numberList.remove(at: sourceIndex.item)
        self.numberList.insert(intItem, at: destinationIndex.item)
        collectionView.deleteItems(at: [sourceIndex])
        collectionView.insertItems(at: [destinationIndex])
      })
      
      coordinator.drop(item.dragItem, toItemAt: destinationIndex)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    if collectionView.hasActiveDrag {
      return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    } else {
      return UICollectionViewDropProposal(operation: .forbidden)
    }
  }
}
