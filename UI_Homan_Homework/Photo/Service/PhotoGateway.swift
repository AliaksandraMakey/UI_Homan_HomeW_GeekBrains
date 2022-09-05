import UIKit
import SwiftUI


class PhotoGateway {
    
    public func getPhotos(ownerId: Int) -> [UIImage] {
        let realmPhotos = getPhotosByOwnerId(id: ownerId)
        if !realmPhotos.isEmpty {
            return realmPhotos.map { photo in
                UIImage(data: photo.data!) ?? UIImage()
            }
        } else {
            return photosGetRequests(id: ownerId)
        }
    }
    
}
