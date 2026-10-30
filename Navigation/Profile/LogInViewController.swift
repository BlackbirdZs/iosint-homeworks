
import UIKit

class LogInViewController: UIViewController {
    weak var coordinator: LoginCoordinator?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white

        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white

        return contentView
    }()

    lazy var labelImageView: UIImageView = {
        let labelImageView = UIImageView()
        labelImageView.translatesAutoresizingMaskIntoConstraints = false
        labelImageView.image = UIImage(named: "VKLogo")

        return labelImageView
    }()

    private func imageWithAlpha(_ image: UIImage, alpha: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)

        return renderer.image { _ in image.draw(at: .zero, blendMode: .normal, alpha: alpha)
        }
    }

    lazy var loginButton: CustomButton = {
        let loginButton = CustomButton(title: "Log in", titleColor: .white)
        loginButton.layer.cornerRadius = 10

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return loginButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        loginButton.setBackgroundImage(bluePixel, for: .normal)
        loginButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        loginButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        loginButton.setBackgroundImage(dimmedBluePixel, for: .disabled)

        loginButton.tapOnButton = { [weak self] in self?.loginButtonPressed() }

        return loginButton
    }()

    lazy var generatePasswordButton: CustomButton = {
        let generatePasswordButton = CustomButton(title: "Generate random password", titleColor: .white)
        generatePasswordButton.layer.cornerRadius = 10

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return loginButton
        }
        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)
        generatePasswordButton.setBackgroundImage(bluePixel, for: .normal)
        generatePasswordButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        generatePasswordButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        generatePasswordButton.setBackgroundImage(dimmedBluePixel, for: .disabled)
        generatePasswordButton.tapOnButton = { [weak self] in self?.randomPassButtonPressed() }

        return generatePasswordButton
    }()

    lazy var fieldsContainerView: UIView = {
        let fieldsContainerView = UIView()
        fieldsContainerView.translatesAutoresizingMaskIntoConstraints = false
        fieldsContainerView.backgroundColor = .systemGray6
        fieldsContainerView.layer.borderColor = UIColor.lightGray.cgColor
        fieldsContainerView.layer.borderWidth = 0.5
        fieldsContainerView.layer.cornerRadius = 10
        fieldsContainerView.clipsToBounds = true

        return fieldsContainerView
    }()

    lazy var containerViewLine: UIView = {
        let containerViewLine = UIView()
        containerViewLine.translatesAutoresizingMaskIntoConstraints = false
        containerViewLine.backgroundColor = .systemGray4

        return containerViewLine
    }()

    lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Email or phone"
        loginTextField.text = "admin"
        loginTextField.font = .systemFont(ofSize: 16)
        loginTextField.textColor = .black
        loginTextField.tintColor = UIColor(named: "VKColor")
        loginTextField.autocapitalizationType = .none

        return loginTextField
    }()

    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        passwordTextField.rightView = paddingView
        passwordTextField.rightViewMode = .always
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.text = "admin"
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.textColor = .black
        passwordTextField.tintColor = UIColor(named: "VKColor")
        passwordTextField.isSecureTextEntry = true

        return passwordTextField
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .vk

        return indicator
    }()

    var loginDelegate: LoginViewControllerDelegate?

    private let someUser = User(
        login: "admin",
        fullName: "Tony Smith",
        status: "All good",
        avatar: UIImage(named: "avatar") ?? UIImage()
    )

    private lazy var userService: UserService = {
        #if DEBUG
            return TestUserService()
        #else
            return CurrentUserService(user: someUser)
        #endif
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
    }

    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }

    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(labelImageView)
        contentView.addSubview(fieldsContainerView)
        contentView.addSubview(loginButton)
        contentView.addSubview(generatePasswordButton)
        fieldsContainerView.addSubview(loginTextField)
        fieldsContainerView.addSubview(containerViewLine)
        fieldsContainerView.addSubview(passwordTextField)
        fieldsContainerView.addSubview(activityIndicator)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeKeyboardObservers()
    }

    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }

    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }

    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 10),
            activityIndicator.heightAnchor.constraint(equalToConstant: 10),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: fieldsContainerView.trailingAnchor, constant: -15),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(
                greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),

            labelImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            labelImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelImageView.heightAnchor.constraint(equalToConstant: 100),
            labelImageView.widthAnchor.constraint(equalToConstant: 100),

            fieldsContainerView.heightAnchor.constraint(equalToConstant: 100),
            fieldsContainerView.topAnchor.constraint(equalTo: labelImageView.bottomAnchor, constant: 120),
            fieldsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fieldsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            loginTextField.topAnchor.constraint(equalTo: fieldsContainerView.topAnchor, constant: 5),
            loginTextField.bottomAnchor.constraint(equalTo: containerViewLine.topAnchor, constant: -5),
            loginTextField.leadingAnchor.constraint(equalTo: fieldsContainerView.leadingAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: fieldsContainerView.trailingAnchor, constant: -15),

            containerViewLine.heightAnchor.constraint(equalToConstant: 1),
            containerViewLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerViewLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerViewLine.topAnchor.constraint(equalTo: fieldsContainerView.topAnchor, constant: 50),

            passwordTextField.topAnchor.constraint(equalTo: containerViewLine.bottomAnchor, constant: 5),
            passwordTextField.bottomAnchor.constraint(equalTo: fieldsContainerView.bottomAnchor, constant: -5),
            passwordTextField.leadingAnchor.constraint(equalTo: fieldsContainerView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: fieldsContainerView.trailingAnchor, constant: -15),

            loginButton.topAnchor.constraint(equalTo: fieldsContainerView.bottomAnchor, constant: 16),
            loginButton.widthAnchor.constraint(equalTo: fieldsContainerView.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -20),

            generatePasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            generatePasswordButton.widthAnchor.constraint(equalTo: fieldsContainerView.widthAnchor),
            generatePasswordButton.heightAnchor.constraint(equalToConstant: 50),
            generatePasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            generatePasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Attention",
            message: message,
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(
            title: "Done",
            style: .default
        )
        alert.addAction(doneAction)
        present(alert, animated: true)
    }

    @objc func loginButtonPressed() {
        guard let loginText = loginTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        let cleanedLogin = loginText.trimmingCharacters(in: .whitespaces)
        let cleanedPassword = passwordText.trimmingCharacters(in: .whitespaces)

        if cleanedLogin.isEmpty || cleanedPassword.isEmpty {
            showAlert(message: "Login or password field is empty")
        } else {
            let isValid = loginDelegate?.check(login: cleanedLogin, password: cleanedPassword)
            if isValid != true {
                showAlert(message: "Invalid login or password")
            } else {
                let user = userService.checkLogin(login: cleanedLogin)
                if let user = user {
                    coordinator?.openProfile(user)
                } else {
                    showAlert(message: "User not found")
                }
            }
        }
    }

    @objc func randomPassButtonPressed() {
        passwordTextField.text = ""
        activityIndicator.startAnimating()
        generatePasswordButton.isEnabled = false
        loginButton.isEnabled = false
        let charachters = Array(String().printable)
        let randomPassword = String((0 ..< 4).map { _ in charachters.randomElement()! })
        let queue = OperationQueue()
        queue.addOperation {
            [weak self] in
            let bruteForce = BruteForce()
            bruteForce.bruteForce(passwordToUnlock: randomPassword) { foundPassword in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.passwordTextField.text = foundPassword
                    self?.passwordTextField.isSecureTextEntry = false
                    self?.generatePasswordButton.isEnabled = true
                    self?.loginButton.isEnabled = true
                }
            }
        }
    }
}
