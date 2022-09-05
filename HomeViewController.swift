
import UIKit
import RealmSwift
import Realm

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loadingOneImage: UIImageView!
    @IBOutlet weak var loadingTwoImage: UIImageView!
    @IBOutlet weak var loadingThreeImage: UIImageView!
    @IBOutlet weak var loadingFourImage: UIImageView!
    
    func loadingAnimateKeyframe(exitAfter: Int, currentCount: Int) {
        UIImageView.animateKeyframes(withDuration: 0.5,
                                     delay: 0,
                                     options: []) {
            UIImageView.addKeyframe(withRelativeStartTime: 0.2,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingOneImage.alpha = 0
                self?.loadingTwoImage.alpha = 0.5
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.4,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingTwoImage.alpha = 0
                self?.loadingThreeImage.alpha = 0.5
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.6,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingThreeImage.alpha = 0
                self?.loadingFourImage.alpha = 0.5
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.8,
                                    relativeDuration: 0.2)  { [weak self] in
                self?.loadingFourImage.alpha = 0
                self?.loadingOneImage.alpha = 0.5
            }
        } completion: {  [weak self] _ in
            if currentCount < exitAfter {
                self?.loadingAnimateKeyframe(exitAfter: exitAfter, currentCount: currentCount + 1)
            } else {
                self?.loadingOneImage.alpha = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0949761793, green: 0.1916104257, blue: 0.1280282736, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingOneImage.alpha = 0.2
        loadingTwoImage.alpha = 0.2
        loadingThreeImage.alpha = 0.2
        loadingFourImage.alpha = 0.2
        loadingAnimateKeyframe(exitAfter: 3, currentCount: 0)
        do {
            let realm = try Realm()
            let lastToken = realm.objects(TokenRealm.self).map{$0}.last
            if lastToken != nil && lastToken!.expiresInDate > Date(){
                Session.instance.userId = lastToken?.userId
                Session.instance.token = lastToken?.token
                Session.instance.expiresInDate = lastToken?.expiresInDate
                performSegue(withIdentifier: FromHomeVCToNewsVC, sender: nil)
                return
            }
        } catch {
            print(error)
        }
        
        performSegue(withIdentifier: fromHomeVCToWebVC, sender: nil)
    }
}






