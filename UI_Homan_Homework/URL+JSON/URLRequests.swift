
import Foundation
import WebKit

let token = Session.instance.token
let userID =  Session.instance.userId

/// MARK: URLRequest friendsID
func friendsGetRequests() {
    var components = URLComponents(string: "https://api.vk.com/method/friends.get")
    components?.queryItems = [
        // параметры запроса
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "count", value: "2"),
        URLQueryItem(name: "fields", value: "sex"),
        URLQueryItem(name: "v", value: "5.131") ]
    guard
        let url = components?.url else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let json = data else { return }
        do {
            let friendResponse = try JSONDecoder().decode( GetFriendResponse.self, from: json)
            print(friendResponse)
        } catch {
            print(error.localizedDescription)
        }
    }.resume()
}

/// MARK: URLRequest groupsID
func groupsGetRequests() {
    var components = URLComponents(string: "https://api.vk.com/method/groups.get")
    components?.queryItems = [
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "count", value: "2") ,
        URLQueryItem(name: "extended", value: "1"),
        URLQueryItem(name: "v", value: "5.131") ]
    guard
        let url = components?.url else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let json = data else { return }
        do {
            let groupResponse = try JSONDecoder().decode( GetGroupResponse.self, from: json)
            print(groupResponse)
        } catch {
            print(error.localizedDescription)
        }
    }.resume()
}



/// MARK: URLRequest photos
func photosGetRequests() {
    var components = URLComponents(string: "https://api.vk.com/method/photos.getAll")
    components?.queryItems = [
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "count", value: "2") ,
        URLQueryItem(name: "photo_sizes", value: "1"),
        URLQueryItem(name: "v", value: "5.131") ]
    guard
        let url = components?.url
    else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let json = data else { return }
        do {
            let photoResponse = try JSONDecoder().decode( GetPhotoResponse.self, from: json)
            print(photoResponse)
        } catch {
            print(error.localizedDescription)
        }
    }.resume()
}

