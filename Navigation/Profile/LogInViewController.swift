
import UIKit

class LogInViewController: UIViewController {
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

    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true

        guard let bluePixel = UIImage(named: "bluePixel") else {
            return loginButton
        }

        let dimmedBluePixel = imageWithAlpha(bluePixel, alpha: 0.8)

        loginButton.setBackgroundImage(bluePixel, for: .normal)
        loginButton.setBackgroundImage(dimmedBluePixel, for: .highlighted)
        loginButton.setBackgroundImage(dimmedBluePixel, for: .selected)
        loginButton.setBackgroundImage(dimmedBluePixel, for: .disabled)

        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return loginButton
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
        loginTextField.font = .systemFont(ofSize: 16)
        loginTextField.textColor = .black
        loginTextField.tintColor = UIColor(named: "VKColor")
        loginTextField.autocapitalizationType = .none
        return loginTextField
    }()

    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.textColor = .black
        passwordTextField.tintColor = UIColor(named: "VKColor")

        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(labelImageView)
        contentView.addSubview(fieldsContainerView)
        contentView.addSubview(containerViewLine)
        fieldsContainerView.addSubview(loginTextField)
        fieldsContainerView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)

        navigationController?.navigationBar.isHidden = true

        setupConstraints()
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
            labelImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            labelImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelImageView.heightAnchor.constraint(equalToConstant: 100),
            labelImageView.widthAnchor.constraint(equalToConstant: 100),

            fieldsContainerView.heightAnchor.constraint(equalToConstant: 100),
            fieldsContainerView.topAnchor.constraint(equalTo: labelImageView.bottomAnchor, constant: 120),
            fieldsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fieldsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            containerViewLine.heightAnchor.constraint(equalToConstant: 1),
            containerViewLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerViewLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerViewLine.topAnchor.constraint(equalTo: fieldsContainerView.topAnchor, constant: 50),

            loginButton.topAnchor.constraint(equalTo: fieldsContainerView.bottomAnchor, constant: 16),
            loginButton.widthAnchor.constraint(equalTo: fieldsContainerView.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -20),

            loginTextField.topAnchor.constraint(equalTo: fieldsContainerView.topAnchor, constant: 5),
            loginTextField.bottomAnchor.constraint(equalTo: containerViewLine.topAnchor, constant: -5),
            loginTextField.leadingAnchor.constraint(equalTo: fieldsContainerView.leadingAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: fieldsContainerView.trailingAnchor, constant: -15),

            passwordTextField.topAnchor.constraint(equalTo: containerViewLine.bottomAnchor, constant: 5),
            passwordTextField.bottomAnchor.constraint(equalTo: fieldsContainerView.bottomAnchor, constant: -5),
            passwordTextField.leadingAnchor.constraint(equalTo: fieldsContainerView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: fieldsContainerView.trailingAnchor, constant: -15),

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
        ])
    }

    @objc func loginButtonPressed() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
