
import UIKit


class NewsViewController: UIViewController {
    
    
    @IBOutlet weak var newsTableView: UITableView!
    var newsArray = [NewsPost]()
    
    
    func fillNewsArray(){
        newsGetRequests{ news in
            DispatchQueue.main.async {
                self.newsArray += news
                self.newsTableView.reloadData()
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNewsArray()
        
        newsTableView.register(UINib(nibName: "TextNewsTableCellXib", bundle: nil), forCellReuseIdentifier: "reuseIdentifierCustom")
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
}

//MARK: Extension NewsViewController
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierCustom", for: indexPath) as? TextNewsTableCellXib else { return UITableViewCell() }
        cell.configure(news: newsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(300)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
    
}
