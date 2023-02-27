
import UIKit
import RealmSwift
import Realm

//FIXME: clean viewDidAppear
class HomeViewController: UIViewController {
    //MARK:  IBOutlet
    @IBOutlet weak var loadingOneImage: UIImageView!
    @IBOutlet weak var loadingTwoImage: UIImageView!
    @IBOutlet weak var loadingThreeImage: UIImageView!
    @IBOutlet weak var loadingFourImage: UIImageView!
    
    /// loadingAnimateKeyframe
    func loadingAnimateKeyFrame(exitAfter: Int, currentCount: Int) {
        /// alphaImage
        func alphaImageForAnimateKeyFrame(oneImege: UIImageView?, twoImage: UIImageView?) {
            oneImege?.alpha = 0
            twoImage?.alpha = 0.5
        }
        
        UIImageView.animateKeyframes(withDuration: 0.5,
                                     delay: 0,
                                     options: []) {
            UIImageView.addKeyframe(withRelativeStartTime: 0.2,
                                    relativeDuration: 0.2)  { [weak self] in
                alphaImageForAnimateKeyFrame(oneImege: self?.loadingOneImage, twoImage: self?.loadingTwoImage)
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.4,
                                    relativeDuration: 0.2)  { [weak self] in
                alphaImageForAnimateKeyFrame(oneImege: self?.loadingTwoImage, twoImage: self?.loadingThreeImage)
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.6,
                                    relativeDuration: 0.2)  { [weak self] in
                alphaImageForAnimateKeyFrame(oneImege: self?.loadingThreeImage, twoImage: self?.loadingFourImage)
            }
            UIImageView.addKeyframe(withRelativeStartTime: 0.8,
                                    relativeDuration: 0.2)  { [weak self] in
                alphaImageForAnimateKeyFrame(oneImege: self?.loadingFourImage, twoImage: self?.loadingOneImage)
            }
        } completion: {  [weak self] _ in
            if currentCount < exitAfter {
                self?.loadingAnimateKeyFrame(exitAfter: exitAfter, currentCount: currentCount + 1)
            } else {
                self?.loadingOneImage.alpha = 0
            }
        }
    }

    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    /// loadImageAnimation
    func loadImageAnimation(oneImage: UIImageView?, twoImage: UIImageView?, threeImage: UIImageView?, fourImage: UIImageView?) {
        oneImage?.alpha = 0.2
        twoImage?.alpha = 0.2
        threeImage?.alpha = 0.2
        fourImage?.alpha = 0.2
        loadingAnimateKeyFrame(exitAfter: 3, currentCount: 0)
    }
    //MARK:  viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        loadImageAnimation(oneImage: loadingOneImage, twoImage: loadingTwoImage, threeImage: loadingThreeImage, fourImage: loadingFourImage)
        /// saving user token in realm
        do {
            let realm = try Realm()
            let lastToken = realm.objects(TokenRealm.self).map{$0}.last
            if lastToken != nil && lastToken!.expiresInDate > Date(){
                Session.instance.userId = lastToken?.userId
                Session.instance.token = lastToken?.token
                Session.instance.expiresInDate = lastToken?.expiresInDate
                performSegue(withIdentifier: FromHomeVCToNewsVC, sender: nil)
                print("Token ---> \(String(describing: Session.instance.token))")
                return
            }
        } catch {
            print(error)
        }
        performSegue(withIdentifier: fromHomeVCToWebVC, sender: nil)
    }
}






