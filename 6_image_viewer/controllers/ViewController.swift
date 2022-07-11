//
//  ViewController.swift
//  6_image_viewer
//
//  Created by David Granado Jordan on 6/14/22.
//

import UIKit
import CoreData

class ViewController: ImagePickerHelperViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    var viewModel = PhotoViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageButton()
        setupSearbar()
        setupCollectionView()
        viewModel.loadPhotos {
            self.collectionView.reloadData()
        }
    }

    
    func setupImageButton() {
        addImageButton.layer.cornerRadius = addImageButton.bounds.size.width * 0.5
    }

    func setupSearbar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //TODO: - register cell
        
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    

    
    
    @IBAction func showImagePickerOptions(_ sender: Any) {
        // addFakePhotos()
        showAddImageOptionAlert()
    }
    
    override func saveSelectedImageInCoreData(withName: String, withExtension: String, data: Data, caption: String) {
        viewModel.saveSelectedImageInCoreData(withName: withName, withExtension: withExtension, data: data, caption: caption) {
            self.collectionView.reloadData()
        }
    }
    

}

// UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
}

// UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let photo = viewModel.getPhotoBy(index: indexPath.row)
        cell.captionLabel.text = photo.photoDescription
        
        if let data = photo.file, let image = UIImage(data: data) {
            cell.imageView.image = image
            cell.layer.cornerRadius = 10
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 4
        let height = collectionView.frame.width / 4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        vc.photo = viewModel.getPhotoBy(index: indexPath.row)
        vc.delegate = self
        show(vc, sender: nil)
    }
    
    
}

extension ViewController: PhotoDetailViewControllerDelegate {
    func photoDeleted(photo: Photo) {
        if let index = viewModel.deletePhoto(photo: photo) {
           

            let indexPath = IndexPath(row: index, section: 0)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    
    func photoUpdated(photo: Photo) {
        if let index = viewModel.getIdexBy(photo: photo) {
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    
}
