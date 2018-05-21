//
//  TaskAttachedVC.swift
//  ToDo
//
//  Created by Nikola Popovic on 5/16/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

protocol TaskAttachedDelegate {
    func getImages(images: [UIImage])
}

class TaskAttachedVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var overlayLabel: UILabel!
    
    public var imagesData = [UIImage]()
    public var delegate: TaskAttachedDelegate?
    
    private var cellIdentifier = "TaskGalleryCollectionViewCell"
    private var indexPath = IndexPath(item: 0, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImageAction))
        setCollectionView()
        setOverlayLabel()
    }
    
    func setCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize =  CGSize.init(width: self.view.frame.size.width, height: collectionView.frame.size.height)
        self.self.automaticallyAdjustsScrollViewInsets = false
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 0
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0
        print("Width: \(collectionView.frame.size.width)")
        print("Height: \(collectionView.frame.size.height)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.getImages(images: self.imagesData)
    }
    
    func setOverlayLabel(){
        if imagesData.count == 0 {
            self.overlayLabel.isHidden = false
        } else {
            self.overlayLabel.isHidden = true
        }
    }
    
    @objc func addImageAction(){
        popUpForImagePicker()
    }
}

// MARK: Collection View Data Source
extension TaskAttachedVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TaskGalleryCollectionViewCell
        cell.photo.image = imagesData[indexPath.row]
        return cell
    }
}


// MARK UIIMagePickerContorllerDelegate
extension TaskAttachedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagesData.append(chosenImage)
            self.collectionView.reloadData()
            setOverlayLabel()
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func popUpForImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let popUp = UIAlertController(title: "Choose image", message: "", preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        popUp.addAction(photoLibraryAction)
        popUp.addAction(cameraAction)
        popUp.addAction(cancelAction)
        present(popUp, animated: true, completion: nil)
    }
}

//PRAGMA SCROLL VIEW DELEGATE
extension TaskAttachedVC : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollToItemByX(x: scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollToItemByX(x: scrollView.contentOffset.x)
    }
    
    func scrollToItemByX(x : CGFloat) {
        let item = x/self.view.frame.size.width
        let selectedItem = Int(item.rounded())
        indexPath.item = selectedItem
        self.collectionView.scrollToItem(at: IndexPath.init(row:selectedItem , section: 0), at: UICollectionViewScrollPosition.left, animated: true)
    }
}

