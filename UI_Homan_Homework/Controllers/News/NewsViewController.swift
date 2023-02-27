
import UIKit

//TODO: upgrede tableViewCell
class NewsViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var newsTableView: UITableView!
    var newsArray = [NewsPost]()
    
    /// fillNewsArray
    func fillNewsArray(){
        newsGetRequests{ news in
            self.newsArray = news
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
            newsAvatarGetRequests(news:  self.newsArray){ resultNews in
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
        }
    }
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNewsArray()
        /// register cell
        newsTableView.register(TextNewsTableCellXib.nib(), forCellReuseIdentifier: TextNewsTableCellXib.identifier)
        newsTableView.register(OnePhotoTextNewsTableCellXib.nib(), forCellReuseIdentifier: OnePhotoTextNewsTableCellXib.identifier)
        newsTableView.register(TwoPhotosTextTableCellXib.nib(), forCellReuseIdentifier: TwoPhotosTextTableCellXib.identifier)
        newsTableView.register(FewPhotosTableCellXib.nib(), forCellReuseIdentifier: FewPhotosTableCellXib.identifier)
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
}
//MARK: Extension NewsViewController
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
/// numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
//FIXME: upgrede this metod
    /// cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCount = newsArray[indexPath.row].photosImage.count
        if photoCount == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextNewsTableCellXib.identifier, for: indexPath) as? TextNewsTableCellXib else { return UITableViewCell() }
            cell.configure(news: newsArray[indexPath.row])
            return cell
        } else if photoCount == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OnePhotoTextNewsTableCellXib.identifier, for: indexPath) as? OnePhotoTextNewsTableCellXib else { return UITableViewCell() }
            cell.configure(news: newsArray[indexPath.row])
            return cell
        } else if photoCount == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TwoPhotosTextTableCellXib.identifier, for: indexPath) as? TwoPhotosTextTableCellXib else { return UITableViewCell() }
            cell.configure(news: newsArray[indexPath.row])
            return cell
        } else if photoCount >= 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FewPhotosTableCellXib.identifier, for: indexPath) as? FewPhotosTableCellXib else { return UITableViewCell() }
            cell.configure(news: newsArray[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    /// heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if newsArray[indexPath.row].photosImage.count == 0 {
            return CGFloat(200)
        }
        return CGFloat(450)
    }
    /// didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
    
}


