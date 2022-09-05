
import UIKit
import RealmSwift

class GalleryViewController: UIViewController {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var friend = Friend()
    var gateway = PhotoGateway()
    var fullScreenView: UIView?
    
    //MARK: func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fullPhotosArray()
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCollectionCell)
    }
    /// func getPhoto
    func fullPhotosArray() {
        let images = gateway.getPhotos(ownerId: friend.id)
        self.friend.photoAlbum += images
    }
}

//MARK: Extension GalleryViewController
extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.photoAlbum.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierGalleryCollectionCell, for: indexPath) as? GalleryCollectionCell else { return UICollectionViewCell() }
        cell.configure(image: self.friend.photoAlbum[indexPath.item])
        return cell
    }
    func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showView(image: self.friend.photoAlbum[indexPath.item])
    }
}

//MARK: Extension UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let whiteSpace = CGFloat(1)
        let cellWightHeight = collectionViewWidth / 2 - whiteSpace
        // можно было использовать такой синтаксис: CGSize(width: collectionViewWidth / 3 - whiteSpace, height: collectionViewWidth / 3 - whiteSpace)
        return CGSize(width: cellWightHeight, height: cellWightHeight)
    }
}

//MARK: Extension GalleryViewController
extension GalleryViewController {
    func showView(image: UIImage) {
        // добавим проверку. Если fullScreenView = nil - инициализируем его
        if fullScreenView == nil {
            // создаем View на полный экран bounds.исходный вариант fullScreenView = UIView(frame: self.view.bounds) меняем на синтаксис ниже, чтобы уменьшить размер View и показать кнопку закрытия ( в предыдущей версии она не видна )
            fullScreenView = UIView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }
        // задаем цвет. в данном случае прозрачный
        fullScreenView!.backgroundColor = #colorLiteral(red: 0.3681276441, green: 0.5518844128, blue: 0.426200211, alpha: 1)
        // добавляем его поверх self.View
        self.view.addSubview(fullScreenView!)
        //        // добавим tapRecognizer
        //        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        //        // добавляем точку, с которой будет считываться нажатие
        //        fullScreenView?.addGestureRecognizer(tapRecognizer)
        
        // добаляем imageView и даем ему в параметры тот image, который пришел в качестве параметра
        let imageView = UIImageView(image: image)
        // добавим imageView на наш fullScreenView
        fullScreenView?.addSubview(imageView)
        // растянем из кода при помощи якорей наш imageView. Для этого нам нужно отключить translatesAutoresizingMaskIntoConstraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // разметим по центру imageView. для этого центр по х  (XAnchor) imageView приравниваем к fullScreenView
        imageView.centerXAnchor.constraint(equalTo: fullScreenView!.centerXAnchor).isActive = true
        //  и по оси у  устанавливаем ширину и высоту (widthAnchor / heightAnchor) imageView приравниваея их соответствующим значениям fullScreenView
        imageView.centerYAnchor.constraint(equalTo: fullScreenView!.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive = true
        // добавляем параметр, чтобы не растягивал картинки, а оставлял им естественный размеры
        imageView.contentMode = .scaleAspectFit
        
        // добавляем closeButton для закрытия картинки в правый крайний угол (для этого мы выше переназначили размеры View)
        let closeButton = UIButton(frame: CGRect(x: fullScreenView!.bounds.width - 40, y: 0, width: 40, height: 40))
        closeButton.layer.cornerRadius = 15
        closeButton.layer.cornerRadius = 15
        closeButton.layer.shadowColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        closeButton.layer.shadowOffset = CGSize(width: -2, height: -2)
        closeButton.layer.shadowRadius = 10
        closeButton.layer.shadowOpacity = 1
        closeButton.layer.cornerRadius = 20
        //добавляем цвет кнопки
        closeButton.backgroundColor = #colorLiteral(red: 0.3681276441, green: 0.5518844128, blue: 0.426200211, alpha: 1)
        // добавляем реакцию на нажатие
        closeButton.addAction(UIAction(handler: { [weak self] _ in
            // добавляем куда переходим
            self?.fullScreenView!.removeFromSuperview()
            // так как реакция на нажатие кнопки, то нам больше не нужна реакция на нажатие по экрану и мы убираем часть с tapRecognizer
        }), for: .touchUpInside)
        // настраиваем значек крестика на кнопку
        closeButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        fullScreenView?.addSubview(closeButton)
    }
    
    @objc func onTap() {
        // если fullScreenView используем removeFromSuperview
        guard let fullScreenView = self.fullScreenView else {return}
        fullScreenView.removeFromSuperview()
    }
}
