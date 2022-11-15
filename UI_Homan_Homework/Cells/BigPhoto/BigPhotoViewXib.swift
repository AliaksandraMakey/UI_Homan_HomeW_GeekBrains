//
//  BigPhotoViewXib.swift
//  UI_Homan_Homework
//
//  Created by aaa on 24.06.22.
//

import UIKit
//@IBDesignable
class BigPhotoViewXib: UIView {

    @IBInspectable var inactivIndicatorColor: UIColor = UIColor.lightGray
    @IBInspectable var activeIndicatorColor: UIColor = UIColor.black
    
    private var view: UIView?
    private var interactiveAnimator: UIViewPropertyAnimator!
    
    private var mainImageView = UIImageView() //UIView()
    private var secondaryImageView = UIImageView() //UIView()
    private var images = [UIImage]()
    private var isLeftSwipe = false
    private var isRightSwipe = false
    private var chooseFlag = false
    private var currentIndex = 0
    private var customPageView  = UIPageControl()
    
    // достаем view с xib файла
    override init(frame: CGRect) {
        super.init(frame: frame)
                setup()
    }
    // достаем view с xib файла
    required init?(coder: NSCoder) {
        super.init(coder: coder)
                setup()
    }
    // достаем view с xib файла
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BigPhotoViewXib", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }
    // достаем view с xib файла
    private func setup() {
        view = loadFromNib()
        guard let view = view else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        // для считывания движения пальца используем метод UIPanGestureRecognizer ( отслеживает движение пальца в любую из сторон). UITapGestureRecognizer считывает нажатие на экран.  #selector(onPan(_:) это функция, которая будет выполняться при движении пальца

        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.addGestureRecognizer(recognizer)
        
        // создаем mainImageView
        mainImageView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        // frame = bounds - это значит, что mainImage раскрываетс на весь экран
        mainImageView.frame = self.bounds
        // добавляем mainImageView
        addSubview(mainImageView)
        
        //создаем secondaryImageView
        secondaryImageView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        secondaryImageView.frame = self.bounds
        // secondaryImage уезжает на ширину экрана (UIScreen.main.bounds.width)
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        // добавляем secondaryImageView
        addSubview(secondaryImageView)
        
        // точки внизу - customPageView
        customPageView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = 1
        customPageView.currentPage = 0
        customPageView.pageIndicatorTintColor = self.inactivIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        // добавляем customPageView
        addSubview(customPageView)
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.bounds.height).isActive = true
    }
    
    private func onChange(isLeft: Bool) {
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        self.mainImageView.image = images[currentIndex]
        
        if isLeft {
            self.secondaryImageView.image = images[self.currentIndex + 1]
            self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }
        else {
            self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            self.secondaryImageView.image = images[currentIndex - 1]
        }
    }
    
    private func onChangeCompletion(isLeft: Bool) {
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        if isLeft {
            self.currentIndex += 1
        }
        else {
            self.currentIndex -= 1
        }
        self.mainImageView.image = self.images[self.currentIndex]
        self.bringSubviewToFront(self.mainImageView)
        self.customPageView.currentPage = self.currentIndex
    }
    
    // функция, которая будет выполняться при движении пальца и считывает координаты движений. ВАЖНО! у UIPanGestureRecognizer система координат начинается там, где палец коснулся экрана. x = 0, y = 0 - координаты касания пальца до экрана
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        // обьявляем animator, экземпляр класса UIViewPropertyAnimator
        if let animator = interactiveAnimator,
           // если animator уже запущен - возвращаемся и выходим из функции
           animator.isRunning {
            return
        }
        // используем switch для распознования состояний касания и вызова дейтсвиф
        switch recognizer.state {
            // момент, когда пользователь коснулся экрана
        case .began:
            // возвращаем mainImageView в исх состояние
            self.mainImageView.transform = .identity
            // добавляем на mainImageView image из массива images с текущим индексом (currentIndex)
            self.mainImageView.image = images[currentIndex]
            // возвращаем secondaryImageView в исх состояние
            self.secondaryImageView.transform = .identity
            // кладем mainImageView на верхний слой, а secondaryImageView будет находиться под ней
            self.bringSubviewToFront(self.mainImageView)
            
            
            //стартуем анимацию
            interactiveAnimator?.startAnimation()
            // инициализируем UIViewPropertyAnimator
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         curve: .easeInOut,
                                                         animations: { [weak self] in
                self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            })
            // после присвоения анимации сразу ставим на паузу, так как нам нужна была инициализация только условная
            interactiveAnimator.pauseAnimation()
            
            // левый свайп
            isLeftSwipe = false
            // правый свайп
            isRightSwipe = false
            // выбор сделан
            chooseFlag = false
            
            //
        case .changed:
            // обьявляем переменную перемещения translation
            var translation = recognizer.translation(in: self.view)
            print(translation)
            // если перемещения по оси x меньше 0
            if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) {
                
                // при свайпе isLeftSwipeесли следущий элемент в массиве заходим в условие и ->
                if self.currentIndex == (images.count - 1) {
                    // ->останавливаем анимацию.
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                // определяемся с выбором
                chooseFlag = true
                onChange(isLeft: true)
                // стопаем действующую анимацию ->
                interactiveAnimator.stopAnimation(true)
                // -> и добавляем новую
                interactiveAnimator.addAnimations {
                    [weak self] in
                    // отправляем за границы экрана в лево
                    self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    // а secondaryImageView отправляем в центр
                    self?.secondaryImageView.transform = .identity
                }
                //добавлем действие, которое будет выполнено при завершении анимации
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: true)
                })
                // внов стартуем анимацию ->
                interactiveAnimator.startAnimation()
                // -> и ставим ее на паузу
                interactiveAnimator.pauseAnimation()
                isLeftSwipe = true
            }
            // аналогично с правым свайпом
            if translation.x > 0 && (!isRightSwipe) && (!chooseFlag) {
                if self.currentIndex == 0 {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                chooseFlag = true
                onChange(isLeft: false)
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: false)
                })
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isRightSwipe = true
            }
            
            if isRightSwipe && (translation.x < 0) {return}
            if isLeftSwipe && (translation.x > 0) {return}
            
            // конвертируем отрицательное число в положительное, чтобы воспользоваться fractionComplete, который принимает только от 0 до 1
            if translation.x < 0 {
                translation.x = -translation.x
            }
            // fractionComplete - процент завершения анимации. translation.x  делим на ширину экрана (UIScreen.main.bounds.width)
            interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
            
            // когда палец оторвался от экрана
        case .ended:
            //проверяем, если анимация запущена - ничего не делаем
            if let animator = interactiveAnimator,
               animator.isRunning {
                return
            }
            // оприделяем translation
            var translation = recognizer.translation(in: self.view)
            // конвертируем, если вдруг translation был отрицательный
            if translation.x < 0 {translation.x = -translation.x}
            
            // если translation деленный на ширину экрана (UIScreen.main.bounds.width) больше, чем половина экрана
            if (translation.x / (UIScreen.main.bounds.width)) > 0.5 {
                // стратуем анимацию
                interactiveAnimator.startAnimation()
            } else {
                // если нет, стопаем анимацию и возврашаем на место
                interactiveAnimator.stopAnimation(true)
                // финишируем действие прошлой анимации
                interactiveAnimator.finishAnimation(at: .start)
               //  возврашаем на место mainImageView
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = .identity
                    
                    guard let weakSelf = self else {return}
                    // при isLeftSwipe secondaryImageView уходит соответственно в лево
                    if weakSelf.isLeftSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    }
                    // при isRightSwipe secondaryImageView уходит соответственно в право
                    if weakSelf.isRightSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    }
                }
                //добавляем Completion метод (что будет после завершения предыдущей логики)
                interactiveAnimator.addCompletion({ [weak self] _ in
                    // mainImageView в исходное положение
                    self?.mainImageView.transform = .identity
                    // secondaryImageView в исходное положение
                    self?.secondaryImageView.transform = .identity
                })
                // стартуем анимацию
                interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }
    
    func setImages(images: [UIImage]) {
        self.images = images
        if self.images.count > 0 {
            self.mainImageView.image = self.images.first
        }
        customPageView.numberOfPages = self.images.count
    }
    
}
