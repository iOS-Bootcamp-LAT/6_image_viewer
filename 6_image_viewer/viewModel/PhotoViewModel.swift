//
//  PhotoViewModel.swift
//  image_viewer
//
//  Created by David Granado Jordan on 6/27/22.
//

import Foundation
import CoreData

class PhotoViewModel {
    private var photos = [Photo]()
    
    var numberOfItemsInSection: Int {
        return photos.count
    }
   
    
    func loadPhotos(completion: ( () -> Void )? ) {
        let context = CoreDataManager.shared.getContext()
        
        let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")

        
        do {
            let dbPhotos = try context.fetch(fetchRequest)
            photos = dbPhotos
            // collectionView.reloadData()
            completion?()
            
        } catch(let error) {
            print("Error", error)
        }
    }
    
    
    func saveSelectedImageInCoreData(withName: String, withExtension: String, data: Data, caption: String, completion: ( () -> Void )?) {
        let context = CoreDataManager.shared.getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context) else { return }
        
        guard let photo = NSManagedObject(entity: entity, insertInto: context) as? Photo else { return }
        
        photo.id = Int16.random(in: 1...1000)
        photo.name = withName
        photo.photoDescription = caption
        photo.path = ""
        photo.file = data
        photo.createdAt = Date()
        
        photos.append(photo)
        CoreDataManager.shared.saveContext()
        
        
        completion?()
    }
    
    
    func getPhotoBy(index: Int) -> Photo {
        return photos[index]
    }
    

    
    func deletePhoto(photo: Photo) -> Int? {
        guard let index = photos.firstIndex(where: { photo.id == $0.id} ) else {
            
            
            return nil
        }
        photos.remove(at: index)
        
        return index
    }
    
    func getIdexBy(photo: Photo) -> Int? {
        return photos.firstIndex(where: { photo.id == $0.id} )
    }
    
    func getTitleBy(photo: Photo) -> String {
        return "Photo Name: \(photo.name ?? "")"
    }
    
}
