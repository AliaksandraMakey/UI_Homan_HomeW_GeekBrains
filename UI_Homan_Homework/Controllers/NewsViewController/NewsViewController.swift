//
//  NewsViewController.swift
//  UI_Homan_Homework
//
//  Created by aaa on 07.06.22.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    var newsArray = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNewsArray()
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
}

//MARK: Extension
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }

        cell.configure(news: newsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight * 3)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
