//
//  CreateProfileViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 25/09/25.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Navigation Title
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your profile"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Main Title
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your profile"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Subtitle
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Just a few details to personalize your Shizen experience."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // First Name Section
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your first name"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .words
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Last Name Section
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your last name"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .words
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Age Section
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your age"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Gender Section
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let maleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Male", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        return button
    }()
    
    private let femaleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        return button
    }()
    
    private let otherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Other", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        return button
    }()
    
    // Phone Number Section
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e.g., 555-123-4567"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Terms & Privacy Label
    private let termsLabel: UILabel = {
        let label = UILabel()
        let text = "By continuing, you agree to our Terms & Privacy."
        let attributedString = NSMutableAttributedString(string: text)
        
        // Make "Terms & Privacy" clickable and blue
        let termsRange = (text as NSString).range(of: "Terms & Privacy")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: termsRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsRange)
        
        // Set the rest of the text to gray
        let fullRange = NSRange(location: 0, length: text.count)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: 0, length: termsRange.location))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: termsRange.location + termsRange.length, length: text.count - termsRange.location - termsRange.length))
        
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Continue Button
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Add arrow icon
        let arrowImage = UIImage(systemName: "arrow.right")
        button.setImage(arrowImage, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }()
    
    // MARK: - Properties
    private var selectedGender: Int = 0 // 0: Male, 1: Female, 2: Other
    
    // Keyboard handling properties
    private var activeTextField: UITextField?
    private var originalScrollViewContentInset: UIEdgeInsets = .zero
    private var originalScrollViewIndicatorInsets: UIEdgeInsets = .zero
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupNavigationBar()
        setupKeyboardObservers()
        setupTextFieldDelegates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        // Hide default navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Add subviews
        view.addSubview(navigationTitleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(ageLabel)
        contentView.addSubview(ageTextField)
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderStackView)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(phoneNumberContainerView)
        contentView.addSubview(termsLabel)
        contentView.addSubview(continueButton)
        
        // Add gender buttons to stack view
        genderStackView.addArrangedSubview(maleButton)
        genderStackView.addArrangedSubview(femaleButton)
        genderStackView.addArrangedSubview(otherButton)
        
        // Add phone container subviews
        phoneNumberContainerView.addSubview(phoneIconImageView)
        phoneNumberContainerView.addSubview(phoneNumberTextField)
        
        // Add separator line below navigation title
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.systemGray5
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: navigationTitleLabel.bottomAnchor, constant: 16),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Navigation Title
            navigationTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            navigationTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: navigationTitleLabel.bottomAnchor, constant: 32),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Main Title
            mainTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // First Name
            firstNameLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Last Name
            lastNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 24),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Age
            ageLabel.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 24),
            ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 8),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Gender
            genderLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 24),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            genderStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            genderStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            genderStackView.heightAnchor.constraint(equalToConstant: 44),
            
            // Gender buttons
            maleButton.widthAnchor.constraint(equalToConstant: 80),
            femaleButton.widthAnchor.constraint(equalToConstant: 80),
            otherButton.widthAnchor.constraint(equalToConstant: 80),
            
            // Phone Number
            phoneNumberLabel.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 24),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            phoneNumberContainerView.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            phoneNumberContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            phoneNumberContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            phoneNumberContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            // Phone Icon
            phoneIconImageView.leadingAnchor.constraint(equalTo: phoneNumberContainerView.leadingAnchor, constant: 16),
            phoneIconImageView.centerYAnchor.constraint(equalTo: phoneNumberContainerView.centerYAnchor),
            phoneIconImageView.widthAnchor.constraint(equalToConstant: 20),
            phoneIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Phone TextField
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneIconImageView.trailingAnchor, constant: 12),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneNumberContainerView.trailingAnchor, constant: -16),
            phoneNumberTextField.centerYAnchor.constraint(equalTo: phoneNumberContainerView.centerYAnchor),
            
            // Terms Label
            termsLabel.topAnchor.constraint(equalTo: phoneNumberContainerView.bottomAnchor, constant: 40),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // Continue Button
            continueButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 24),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupActions() {
        maleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        otherButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        // Add tap gesture to terms label
        let termsTapGesture = UITapGestureRecognizer(target: self, action: #selector(termsLabelTapped))
        termsLabel.addGestureRecognizer(termsTapGesture)
    }
    
    private func setupTextFieldDelegates() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        ageTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let activeTextField = activeTextField,
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return
        }
        
        // Store original insets if not already stored
        if originalScrollViewContentInset == .zero {
            originalScrollViewContentInset = scrollView.contentInset
            originalScrollViewIndicatorInsets = scrollView.scrollIndicatorInsets
        }
        
        let keyboardHeight = keyboardFrame.height
        let safeAreaBottom = view.safeAreaInsets.bottom
        let adjustedKeyboardHeight = keyboardHeight - safeAreaBottom
        
        // Calculate the bottom inset needed
        let contentInset = UIEdgeInsets(
            top: originalScrollViewContentInset.top,
            left: originalScrollViewContentInset.left,
            bottom: adjustedKeyboardHeight,
            right: originalScrollViewContentInset.right
        )
        
        // Animate the scroll view adjustment
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: animationCurve.uintValue),
            animations: {
                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset
                
                // Scroll to make the active text field visible
                self.scrollToTextField(activeTextField)
            },
            completion: nil
        )
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return
        }
        
        // Animate back to original state
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: animationCurve.uintValue),
            animations: {
                self.scrollView.contentInset = self.originalScrollViewContentInset
                self.scrollView.scrollIndicatorInsets = self.originalScrollViewIndicatorInsets
            },
            completion: { _ in
                // Reset stored insets
                self.originalScrollViewContentInset = .zero
                self.originalScrollViewIndicatorInsets = .zero
            }
        )
    }
    
    private func scrollToTextField(_ textField: UITextField) {
        // Convert the text field frame to the scroll view's coordinate system
        let textFieldFrame = textField.convert(textField.bounds, to: scrollView)
        
        // Add some padding above the text field
        let padding: CGFloat = 20
        let targetRect = CGRect(
            x: textFieldFrame.origin.x,
            y: textFieldFrame.origin.y - padding,
            width: textFieldFrame.width,
            height: textFieldFrame.height + (padding * 2)
        )
        
        // Scroll to make the text field visible
        scrollView.scrollRectToVisible(targetRect, animated: true)
    }
    
    // MARK: - Actions
    @objc private func genderButtonTapped(_ sender: UIButton) {
        selectedGender = sender.tag
        updateGenderButtonsAppearance()
    }
    
    private func updateGenderButtonsAppearance() {
        let buttons = [maleButton, femaleButton, otherButton]
        
        for (index, button) in buttons.enumerated() {
            if index == selectedGender {
                button.backgroundColor = UIColor.systemGreen
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.systemGray6
                button.setTitleColor(.systemGray, for: .normal)
            }
        }
    }
    
    @objc private func continueButtonTapped() {
        print("Continue button tapped")
        
        // Collect form data
        let profileData = [
            "firstName": firstNameTextField.text ?? "",
            "lastName": lastNameTextField.text ?? "",
            "age": ageTextField.text ?? "",
            "gender": ["Male", "Female", "Other"][selectedGender],
            "phoneNumber": phoneNumberTextField.text ?? ""
        ]
        
        print("Profile Data: \(profileData)")
        
        // Add your continue logic here
        // For example, navigate to next screen or save data
    }
    
    @objc private func termsLabelTapped() {
        print("Terms & Privacy tapped")
        // Add your terms & privacy logic here
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextField Delegate
extension CreateProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            ageTextField.becomeFirstResponder()
        case ageTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Age field validation - only allow numbers
        if textField == ageTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
