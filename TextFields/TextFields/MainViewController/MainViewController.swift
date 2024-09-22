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
        stackView.axis = .vertical /// Вісь стек вʼю вертикальна.
        stackView.spacing = 30 /// Відсутп між елементами 30 пікселів.
        
        [noDigitsView, limitView, onlyCharactersView, linkView, passwordView].forEach {
            stackView.addArrangedSubview($0) /// Додаю до стеквʼю вʼюшки з масива за допомогою цикла і одразу задаю однакову висоту для всіх
            /// addArrangedSubview бере властивості які указані вище, якби використовував addSubView прийшлось би до кожної вʼюшки задавати констрейнт
            $0.snp.makeConstraints { $0.height.equalTo(66) } /// висота кожної вʼю
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(30) /// відсутп від заголовка на 30px
            $0.leading.trailing.equalTo(contentView).inset(16) /// відступ з обох сторін 16px
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20) /// нижня частина стеквʼю має відступ 20px від нижньої частини контент вʼю
        }
    }
    
    func setupButton() {
        view.addSubview(button)
        button.setTitle("Show Tab Bar", for: .normal)
        button.layer.cornerRadius = 11
        button.backgroundColor = .systemBlue

        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        button.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
    }

    // MARK: - Setup Gestures
    
    @objc private func showTabBar() {
        let tabBarVC = TabBarViewController()
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
}
