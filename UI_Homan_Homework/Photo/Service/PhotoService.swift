
import Foundation
import WebKit
import RealmSwift
import Realm
import SwiftUI


let getAllPhotoUrl = "https://api.vk.com/method/photos.get"
var getAllPhotoSettings = ["access_token": token,
                           "count": "2",
                           "photo_sizes": "1",
                           "album_id": "wall",
                           "v": "5.131"]

/// MARK: URLRequest photos
func photosGetRequests(id id: Int) -> [UIImage]{
    getAllPhotoSettings["owner_id"] = String(id)
    guard let url =  NetworkManager.getRequest(url: getAllPhotoUrl, settings: getAllPhotoSettings) else { return  [UIImage]()}
    let (data, _, _) = URLSession.shared.syncRequest(with: url)
    guard let json = data,
          let photoResponse = try? JSONDecoder().decode( GetPhotoResponse.self, from: json) else { return [UIImage]()}
    let items = photoResponse.response.items
    let realmPhotos = mapItemsToRealmPhotos(itemPhoto: items)
    savePhotos(items : realmPhotos)
    return mapRealmsToPhotos(realmPhotos: realmPhotos)
}

/// MARK: savePhotos
private func savePhotos(items: [RealmPhotos]) {
    do {
        let realm = try Realm()
        try realm.write {
            items.forEach { item in
                let obj = try? realm.object(ofType: RealmPhotos.self, forPrimaryKey: item.id)
                if obj == nil {
                    realm.add(item)
                }
            }
        }
    } catch {
        print(error)
    }
}

/// MARK: getPhotosByOwnerId
public func getPhotosByOwnerId(id: Int) -> [RealmPhotos] {
    do {
        let realm = try Realm()
        return realm.objects(RealmPhotos.self).filter("ownerId == %@", id).map{$0}
    } catch {
        print(error)
        return [RealmPhotos]()
    }
}

/// MARK: mapRealmsToPhotos
public func mapRealmsToPhotos(realmPhotos: [RealmPhotos]) -> [UIImage]{
    return realmPhotos.map {  item in
        return UIImage(data: item.data!) ?? UIImage()
    }
}

/// MARK: mapItemsToRealmPhotos
func mapItemsToRealmPhotos(itemPhoto: [PhotoItem]) -> [RealmPhotos] {
    return itemPhoto.map { item in
        let realmPhoto = RealmPhotos()
        for size in item.sizes {
            if size.type == "x" {
                let url = URL(string: size.url)
                let image = try? Data(contentsOf: url!)
                realmPhoto.url = size.url
                realmPhoto.data = image
            }
        }
        realmPhoto.id = item.id
        realmPhoto.date = item.date
        realmPhoto.albumId = item.albumId
        realmPhoto.ownerId = item.ownerId
        return realmPhoto
    }
}
