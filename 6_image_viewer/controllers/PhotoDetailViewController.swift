//
//  PhotoDetailViewController.swift
//  6_image_viewer
//
//  Created by David Granado Jordan on 6/23/22.
//

import UIKit

protocol PhotoDetailViewControllerDelegate {
    func photoUpdated(photo: Photo) -> Void
    func photoDeleted(photo: Photo) -> Void
}


class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var captionTextField: UITextField!
    var photo: Photo!
    
    var delegate: PhotoDetailViewControllerDelegate?
    
    var viewModel : PhotoViewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        let trashImage = UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysOriginal)
        
        let trashButton = UIBarButtonItem(image: trashImage, style: .plain, target: self, action: #selector(trashPhoto))
        
        
        navigationItem.rightBarButtonItem = trashButton
        //navigationItem.rightBarButtonItems = [trashButton, trashButton ]
    }
    
    @objc func trashPhoto() {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete the photo: \(photo.name ?? "")", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:  { action in
            
            let context = CoreDataManager.shared.getContext()
            context.delete(self.photo)
            try? context.save()
            self.delegate?.photoDeleted(photo: self.photo)
            
            self.navigationController?.popViewController(animated: true)
                
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)


    }
    
    
    func setupViews() {
        title = viewModel.getTitleBy(photo: photo)
        
        
        
        if let file = photo.file {
            imageView.image = UIImage(data: file)
        }
        captionTextField.text = photo.photoDescription
    }

    @IBAction func updateCaption(_ sender: Any) {
        let context = CoreDataManager.shared.getContext()
        photo.photoDescription = captionTextField.text
        try? context.save()
        
        
        
        delegate?.photoUpdated(photo: photo)
        
    }
    
}
