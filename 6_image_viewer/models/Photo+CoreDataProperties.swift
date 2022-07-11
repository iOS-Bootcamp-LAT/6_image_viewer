//
//  Photo+CoreDataProperties.swift
//  6_image_viewer
//
//  Created by David Granado Jordan on 6/14/22.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var file: Data?
    @NSManaged public var path: String?
    @NSManaged public var photoDescription: String?

}

extension Photo : Identifiable {

}
