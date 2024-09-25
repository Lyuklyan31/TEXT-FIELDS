//
//  ViewController.swift
//  TextFields
//
//  Created by admin on 05.08.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let headerTitleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let button = UIButton()
   
    private let noDigitsView = NoDigitsView()
    private let limitView = LimitView(10)
    private let onlyCharactersView = OnlyCharactersView() //Інкапсуляція, зменшення залежності, чистіший код, повторене використання, простота розширення.
    private let linkView = LinkView()
    private let passwordView = PasswordView()
    // Чому я зробив так?
       /// Всі ці TextFields я виніс в окремі класи задля інкапсуляції, якби цього не зробив MainViewController мав би дуже багато логіки і це б ускладнило код.
       /// А з інкапсуляцією кожен клас віповідає за свою власну логіку. Виносячи кожен рядок в окрему вʼю це дозволяє мені легко перевикористовувати код.
       /// MainViewController просто додає ці вʼюшки на екран, не знаючи як працює всередині кожна з них.
       /// MainViewController стає простішим і немає надмірної кількості коду і відповідно стає меншим і легшим для читання, а також легшим для підтримки, оскільки всі зміни будуть локалізовані в одній вʼюшці.
       /// Зменшення залежності в'юшки можуть мати свою власну логіку керування, зменшуючи кількість залежностей між компонентами, що робить код більш зрозумілим.
    
    private var keyboardManager: KeyboardManager? /// Оголошую змінну з опціональним типом KeyboardManager?
     //Чому я зробив так?
       /// Ініціалізація виконується не в момент створення змінної, а пізніше у методі configureDefaults(), це дозволяє спочатку налаштувати всі елементи інтерфейсу, так як я роблю з ScrollView і тільки тоді передати у KeyboardManager.
       /// Чистіший і зрозуміліший код оскільки логіка інкапсульована у окремому класі KeyboardManager, а ініціалізується відбувається тільки коли всі обʼєкти готові.
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDefaults()
      //Чому я зробив так?
        /// Розділив я це для покращення читабельності і підтримки коду, а також зменшення навантаження на метод viewDidLoad().
    }
    
    // MARK: - Default Configuration
    
    private func configureDefaults() {
        keyboardManager = KeyboardManager(viewController: self, scrollView: scrollView)
        setupGestures()
      //Чому я зробив так?
        /// Тут я ізолював налаштування клавіатури.
        /// І тепер коли viewController та scrollView готові до використання я проініціалізовую keyboardManager.
        /// setupGestures() це у мене extension до UIViewController, зробив я це для перевикористовування коду, щоб не прописувати в кожному UIViewController логіку тапу, а просто викликати метод setupGestures(). Відповідно код чистіший і зрозуміліший .
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupHeaderTitleLabel()
        setupStackView()
        setupButton()
        // Чому я зробив так?
            /// Тут я ізолював всі UI компоненти які ініціалізуються і налаштовуються в одному місці. Це дозволяє легко підтримувати і розширювати проект.
    }
    
    // MARK: - Scroll View Setup
    
    private func setupScrollView() {
        view.addSubview(scrollView) /// Додаю до основного представлення(view ) scrollView, щоб дозволити прокрутку, якщо контент виходить за межі екрану.
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide) /// Цей рядок означає, що краї скролвʼю прикріплені до країв safeAreaLayoutGuide головної view. safeAreaLayoutGuide гарантує, що вміст не буде перекритий системними елементами(наприклад таб бар)
        }
        
        scrollView.addSubview(contentView) /// А тут вже в скрол вʼю додаю контейнер який буде містити весь контент і який може прокручуватись у разі потреби.
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)  /// Краї contentView рівні краям scrollView, щоб вміст займав всю доступну область прокрутки.
            make.width.equalTo(scrollView)  /// Ширина contentView рівна ширині scrollView, щоб уникнути горизонтальної прокрутки і забезпечити вертикальну прокрутку.
        }
        // Чому я зробив так?
           /// scrollView потрібен для відображення вмісту, який може бутибільшим за екран, скролл є дуже важливим коли вміст динамічний або може змінитись від введення користувачем.
           /// scrollView рівний межам safeAreaLayoutGuide для того, щоб не перекрився системними елементами типу таб бару, це забезпечуєж правильне відображення на всіх пристроях і орієнтаціяї екрана.
           /// contentView є контейнером для всього прокручуваного контенту. Це дає можливість розміщувати будь-які внутрішні елементи всередині одного контейнера. Додавання контенту безпосередньо до scrollView ускладнило б керування його розмірами та розміщенням.
           /// make.edges.equalTo(scrollView) вирівнювання країв контент займе всю доступну область прокручування, тобто користувач зможе побачити всі елементи, що розміщені у контент вʼю, прокручуючи вниз (якщо вміст перевищує висоту).
           /// make.width.equalTo(scrollView) Це означає що contentView не стане ширшим за scrollView для запобігання появі горизонтальної прокруту.
    }
    
    // MARK: - Header Title Label Setup
    
    private func setupHeaderTitleLabel() {
        contentView.addSubview(headerTitleLabel)
        headerTitleLabel.text = "Text Fields"
        headerTitleLabel.textAlignment = .center
        headerTitleLabel.font = UIFont(name: "Rubik-Medium", size: 34)
        headerTitleLabel.textColor = UIColor.nightRider
        
        headerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(48)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
    }
    
    // MARK: - Stack View Setup
    
    private func setupStackView() {
        contentView.addSubview(stackView) /// У моєму випадку чудово підходить stackView, оскільки елементи мають однакові відсутупи та однакові розміри
        stackView.axis = .vertical /// Вісь стек вʼю вертикальна, тому елементи будуть розташовані один під одним.
        stackView.spacing = 30 /// Відступ між елементами stackView становить 30 пікселів.
        
        [noDigitsView, limitView, onlyCharactersView, linkView, passwordView].forEach {
            stackView.addArrangedSubview($0) /// Додаю до стеквʼю вʼюшки з масива за допомогою цикла і одразу задаю однакову висоту для всіх
            /// Додаю кожну в'юшку до stackView за допомогою методу addArrangedSubview.
            /// StackView автоматично застосовує властивості spacing і axis до елементів.
            /// Якби використовував addSubview, довелося б вручну налаштовувати констрейнти для кожної в'юшки, що потребувало б більше коду і зробило б код менш читабельним.
            $0.snp.makeConstraints { $0.height.equalTo(66) } /// Встановлюю фіксовану висоту для кожної вʼюшки  66 пікселів.
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(30) /// відсутп від заголовка на 30px
            $0.leading.trailing.equalTo(contentView).inset(16) /// відступ з обох сторін 16px
        }
        // Чому я зробив так?
           /// Я використав стек вʼю тому, що вʼюшки(у моєму випадку кастомні текстфілди) мають однакові відступи і висоту і розташовані вертикально один під одним, що робить використання stackView тут доцільним. StackView спрощує управління їхнім розташуванням і відстанями між ними.
    }
    
    func setupButton() {
        contentView.addSubview(button)
        button.setTitle("Show Tab Bar", for: .normal)
        button.layer.cornerRadius = 11
        button.backgroundColor = .systemBlue

        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)  /// нижня частина кнопки має відступ 20px від нижньої частини контент вʼю
        }
        
        button.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        /// Це метод, який додає target та action до кнопки. Він налаштовує кнопку для виконання певної дії коли відбувається зазначена подія.
        /// Це об'єкт, який виступає target для виклику методу. У цьому випадку, self означає, що дію слід виконати в межах поточного екземпляра класу, тобто у тому ж класі, де знаходиться кнопка і метод showTabBar.
        /// action вказує на метод, який потрібно виконати, коли подія спрацює.
        /// selector(showTabBar) — це спосіб сказати Swift/Objective-C runtime, який саме метод треба викликати. У цьому випадку селектор посилається на метод showTabBar. Метод повинени бути позначений @objc так як нижче.
        /// for визначає, для якої події ця дія має бути виконана.
        /// .touchUpInside — це подія, яка спрацьовує, коли користувач натискає на кнопку і відпускає палець всередині її меж.
        /// Коли користувач натисне кнопку і не вийде за її межі під час натискання через подію .touchUpInside, метод showTabBar буде викликаний.
    }

    // MARK: - Setup Gestures
    
    @objc private func showTabBar() { /// функція позначена @objc тому, що #selector приймає тільки такі функції
        let tabBarVC = TabBarViewController()
        navigationController?.pushViewController(tabBarVC, animated: true)
        /// Метод створює екземпляр TabBarViewController і виконує перехід до нього за допомогою навігаційного контролера.
        // Чому використовується navigationController?
           ///У цьому випадку використовується навігаційний контролер, щоб забезпечити перехід від одного екрану до іншогo.
        // Чому використовується pushViewController?
           ///pushViewController використовується для переміщення вперед по навігаційній ієрархії, тобто для переходу до нового екрану.
        
        ///Використання navigationController?.pushViewController дозволяє створювати навігаційні шляхи всередині додатка щоб переходити від одного екрану до іншого, з можливістю повернення.
    }
}

#Preview {
    MainViewController()
}
