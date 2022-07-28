//
//  WebViewTwoController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 28.07.22.
//

import UIKit
import WebKit

class WebViewTwoController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let token = Session.instance.token
    let userID =  Session.instance.userId
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        webView.navigationDelegate = self
        friendsGetRequests ()
        groupsGetRequests()
        photosGetRequests()
      
    }
    
    /// MARK: URLRequest friendsID
    func friendsGetRequests() {
    var components = URLComponents(string: "https://api.vk.com/method/friends.get")
        components?.queryItems = [
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "v", value: "5.131") ]
    //        ?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
        guard
            let url = components?.url
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response -- > \(response)")
            print("error -- > \(error)")
            guard
                let data = data
            else {return}
            print("FriendsID --> \(String(data: data, encoding: .utf8))")
        }.resume()
    }
    
    /// MARK: URLRequest groups
    func groupsGetRequests() {
    var components = URLComponents(string: "https://api.vk.com/method/groups.get")
        components?.queryItems = [
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "v", value: "5.131") ]
        guard
            let url = components?.url
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response -- > \(response)")
            print("error -- > \(error)")
            guard
                let data = data
            else { return }
            print("Groups --> \(String(data: data, encoding: .utf8))")
        }.resume()
    }
    
    func photosGetRequests() {
    var components = URLComponents(string: "https://api.vk.com/method/photos.get")
        components?.queryItems = [
        URLQueryItem(name: "access_token", value: token),
        URLQueryItem(name: "album_id", value: "wall"),
        URLQueryItem(name: "album_id", value: "profile"),
        URLQueryItem(name: "album_id", value: "saved"),
        URLQueryItem(name: "v", value: "5.131") ]
        guard
            let url = components?.url
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response -- > \(response)")
            print("error -- > \(error)")
            guard
                let data = data
            else {return}
            print("Photos --> \(String(data: data, encoding: .utf8))")
        }.resume()
    }
}

