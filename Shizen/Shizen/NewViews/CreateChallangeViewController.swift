//
//  CreateChallangeViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 25/09/25.
//

import UIKit

class CreateChallengeViewController: UIViewControllerExtensions {
    
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
        label.text = "Create a Challenge"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Select Category Section
    private let selectCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let tagIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "tag")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let selectCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Category"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dropdownArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Visibility Section
    private let visibilityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Visibility"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let visibilityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let publicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Public", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        
        // Add globe icon
        let globeIcon = UIImage(systemName: "globe")
        button.setImage(globeIcon, for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }()
    
    private let privateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Private", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        
        // Add lock icon
        let lockIcon = UIImage(systemName: "lock")
        button.setImage(lockIcon, for: .normal)
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }()
    
    // Pricing Section
    private let pricingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pricing"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pricingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let freeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Free", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        return button
    }()
    
    private let paidButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Paid", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        return button
    }()
    
    // Price Section
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "How much do you want to charge"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 8
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    // Create Challenge Button
    private let createChallengeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Challenge", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Footer Label
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "You can edit or delete your challenge later."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    private var selectedVisibility: Int = 0 // 0: Public, 1: Private
    private var selectedPricing: Int = 0 // 0: Free, 1: Paid
    private var selectedCategory: String = ""
    
    // Category dropdown properties
    private let categoryOptions = ["Reading Book", "Running", "Push Ups", "Meditation", "Journaling", "+ Add New Challenge Type"]
    private var dropdownTableView: UITableView?
    private var isDropdownVisible = false
    private var dropdownHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupNavigationBar()
        setupCategoryDropdown()
        updatePriceFieldVisibility()
        configureRoundedButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update corner radius for fully rounded pill shape
        updateButtonCornerRadius()
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
        
        contentView.addSubview(selectCategoryButton)
        contentView.addSubview(visibilityTitleLabel)
        contentView.addSubview(visibilityStackView)
        contentView.addSubview(pricingTitleLabel)
        contentView.addSubview(pricingStackView)
        contentView.addSubview(priceTitleLabel)
        contentView.addSubview(priceTextField)
        contentView.addSubview(createChallengeButton)
        contentView.addSubview(footerLabel)
        
        // Add category button subviews
        selectCategoryButton.addSubview(tagIconImageView)
        selectCategoryButton.addSubview(selectCategoryLabel)
        selectCategoryButton.addSubview(dropdownArrowImageView)
        
        // Add visibility buttons to stack view
        visibilityStackView.addArrangedSubview(publicButton)
        visibilityStackView.addArrangedSubview(privateButton)
        
        // Add pricing buttons to stack view
        pricingStackView.addArrangedSubview(freeButton)
        pricingStackView.addArrangedSubview(paidButton)
        
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
            
            // Select Category Button
            selectCategoryButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            selectCategoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            selectCategoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            selectCategoryButton.heightAnchor.constraint(equalToConstant: 56),
            
            // Tag Icon
            tagIconImageView.leadingAnchor.constraint(equalTo: selectCategoryButton.leadingAnchor, constant: 16),
            tagIconImageView.centerYAnchor.constraint(equalTo: selectCategoryButton.centerYAnchor),
            tagIconImageView.widthAnchor.constraint(equalToConstant: 20),
            tagIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Select Category Label
            selectCategoryLabel.leadingAnchor.constraint(equalTo: tagIconImageView.trailingAnchor, constant: 12),
            selectCategoryLabel.centerYAnchor.constraint(equalTo: selectCategoryButton.centerYAnchor),
            
            // Dropdown Arrow
            dropdownArrowImageView.trailingAnchor.constraint(equalTo: selectCategoryButton.trailingAnchor, constant: -16),
            dropdownArrowImageView.centerYAnchor.constraint(equalTo: selectCategoryButton.centerYAnchor),
            dropdownArrowImageView.widthAnchor.constraint(equalToConstant: 16),
            dropdownArrowImageView.heightAnchor.constraint(equalToConstant: 16),
            
            // Visibility Title
            visibilityTitleLabel.topAnchor.constraint(equalTo: selectCategoryButton.bottomAnchor, constant: 32),
            visibilityTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            // Visibility Stack View
            visibilityStackView.topAnchor.constraint(equalTo: visibilityTitleLabel.bottomAnchor, constant: 16),
            visibilityStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            visibilityStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            visibilityStackView.heightAnchor.constraint(equalToConstant: 44),
            
            // Visibility buttons
            publicButton.widthAnchor.constraint(equalToConstant: 100),
            privateButton.widthAnchor.constraint(equalToConstant: 100),
            
            // Pricing Title
            pricingTitleLabel.topAnchor.constraint(equalTo: visibilityStackView.bottomAnchor, constant: 32),
            pricingTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            // Pricing Stack View
            pricingStackView.topAnchor.constraint(equalTo: pricingTitleLabel.bottomAnchor, constant: 16),
            pricingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pricingStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            pricingStackView.heightAnchor.constraint(equalToConstant: 44),
            
            // Pricing buttons
            freeButton.widthAnchor.constraint(equalToConstant: 80),
            paidButton.widthAnchor.constraint(equalToConstant: 80),
            
            // Price Title
            priceTitleLabel.topAnchor.constraint(equalTo: pricingStackView.bottomAnchor, constant: 32),
            priceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            // Price TextField
            priceTextField.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 16),
            priceTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            priceTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            priceTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Create Challenge Button
            createChallengeButton.topAnchor.constraint(greaterThanOrEqualTo: priceTextField.bottomAnchor, constant: 60),
            createChallengeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            createChallengeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            createChallengeButton.heightAnchor.constraint(equalToConstant: 52),
            
            // Footer Label
            footerLabel.topAnchor.constraint(equalTo: createChallengeButton.bottomAnchor, constant: 16),
            footerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            footerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            footerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupActions() {
        selectCategoryButton.addTarget(self, action: #selector(selectCategoryTapped), for: .touchUpInside)
        publicButton.addTarget(self, action: #selector(visibilityButtonTapped(_:)), for: .touchUpInside)
        privateButton.addTarget(self, action: #selector(visibilityButtonTapped(_:)), for: .touchUpInside)
        freeButton.addTarget(self, action: #selector(pricingButtonTapped(_:)), for: .touchUpInside)
        paidButton.addTarget(self, action: #selector(pricingButtonTapped(_:)), for: .touchUpInside)
        createChallengeButton.addTarget(self, action: #selector(createChallengeTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func selectCategoryTapped() {
        toggleCategoryDropdown()
    }
    
    @objc private func visibilityButtonTapped(_ sender: UIButton) {
        selectedVisibility = sender.tag
        updateVisibilityButtonsAppearance()
        handlePrivateVisibilityLogic()
    }
    
    @objc private func pricingButtonTapped(_ sender: UIButton) {
        // Don't allow pricing changes if private is selected
        if selectedVisibility == 1 { return }
        
        selectedPricing = sender.tag
        updatePricingButtonsAppearance()
        updatePriceFieldVisibility()
    }
    
    @objc private func createChallengeTapped() {
        print("Create Challenge tapped")
        
        // Collect challenge data
        let challengeData: [String: Any] = [
            "category": selectedCategory.isEmpty ? "Not selected" : selectedCategory,
            "visibility": selectedVisibility == 0 ? "Public" : "Private",
            "pricing": selectedPricing == 0 ? "Free" : "Paid",
            "price": selectedPricing == 1 ? (priceTextField.text ?? "0") : "0"
        ]
        
        print("Challenge Data: \(challengeData)")
        
        // Add your create challenge logic here
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Helper Methods
    
    // MARK: - Category Dropdown Methods
    private func setupCategoryDropdown() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.isHidden = true
        tableView.alpha = 0
        
        contentView.addSubview(tableView)
        dropdownTableView = tableView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: selectCategoryButton.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: selectCategoryButton.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: selectCategoryButton.trailingAnchor),
        ])
        
        dropdownHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        dropdownHeightConstraint?.isActive = true
    }
    
    private func toggleCategoryDropdown() {
        guard let tableView = dropdownTableView else { return }
        
        isDropdownVisible.toggle()
        
        let targetHeight: CGFloat = isDropdownVisible ? CGFloat(categoryOptions.count * 44) : 0
        let targetAlpha: CGFloat = isDropdownVisible ? 1.0 : 0.0
        
        // Rotate arrow
        let rotationAngle: CGFloat = isDropdownVisible ? .pi : 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: [.curveEaseInOut],
            animations: {
                self.dropdownHeightConstraint?.constant = targetHeight
                tableView.alpha = targetAlpha
                tableView.isHidden = !self.isDropdownVisible
                
                self.dropdownArrowImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
                
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                if !self.isDropdownVisible {
                    tableView.isHidden = true
                }
            }
        )
    }
    
    private func selectCategory(_ category: String) {
        if category == "+ Add New Challenge Type" {
            // Handle add new category logic
            print("Add new category type tapped")
            // You can present an alert or new view controller here
        } else {
            selectedCategory = category
            selectCategoryLabel.text = category
            selectCategoryLabel.textColor = .black
        }
        
        // Close dropdown
        if isDropdownVisible {
            toggleCategoryDropdown()
        }
    }
    
    // MARK: - Button Styling Methods
    private func configureRoundedButtons() {
        // Set initial corner radius (will be updated in viewDidLayoutSubviews)
        updateButtonCornerRadius()
    }
    
    private func updateButtonCornerRadius() {
        // Make buttons fully rounded (pill shape)
        publicButton.layer.cornerRadius = publicButton.frame.height / 2
        privateButton.layer.cornerRadius = privateButton.frame.height / 2
        freeButton.layer.cornerRadius = freeButton.frame.height / 2
        paidButton.layer.cornerRadius = paidButton.frame.height / 2
    }
    
    // MARK: - Private Challenge Logic
    private func handlePrivateVisibilityLogic() {
        if selectedVisibility == 1 { // Private selected
            // Force pricing to Free
            selectedPricing = 0
            updatePricingButtonsAppearance()
            updatePriceFieldVisibility()
            
            // Disable pricing buttons
            setPricingButtonsEnabled(false)
        } else { // Public selected
            // Re-enable pricing buttons
            setPricingButtonsEnabled(true)
        }
    }
    
    private func setPricingButtonsEnabled(_ enabled: Bool) {
        freeButton.isEnabled = enabled
        paidButton.isEnabled = enabled
        
        UIView.animate(withDuration: 0.2) {
            self.freeButton.alpha = enabled ? 1.0 : 0.6
            self.paidButton.alpha = enabled ? 1.0 : 0.6
        }
    }
    private func updateVisibilityButtonsAppearance() {
        let buttons = [publicButton, privateButton]
        
        for (index, button) in buttons.enumerated() {
            if index == selectedVisibility {
                button.backgroundColor = UIColor.systemGreen
                button.setTitleColor(.white, for: .normal)
                button.tintColor = .white
                button.layer.borderWidth = 0
            } else {
                button.backgroundColor = UIColor.white
                button.setTitleColor(.black, for: .normal)
                button.tintColor = .black
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.systemGray5.cgColor
            }
        }
    }
    
    private func updatePricingButtonsAppearance() {
        let buttons = [freeButton, paidButton]
        
        for (index, button) in buttons.enumerated() {
            if index == selectedPricing {
                button.backgroundColor = UIColor.systemGreen
                button.setTitleColor(.white, for: .normal)
                button.layer.borderWidth = 0
            } else {
                button.backgroundColor = UIColor.white
                button.setTitleColor(.black, for: .normal)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.systemGray5.cgColor
            }
        }
    }
    
    private func updatePriceFieldVisibility() {
        // Show price field only when "Paid" is selected
        let shouldShowPriceField = selectedPricing == 1
        
        UIView.animate(withDuration: 0.3) {
            self.priceTitleLabel.alpha = shouldShowPriceField ? 1.0 : 0.3
            self.priceTextField.alpha = shouldShowPriceField ? 1.0 : 0.3
        }
        
        priceTextField.isEnabled = shouldShowPriceField
        if !shouldShowPriceField {
            priceTextField.text = ""
        }
    }
}

// MARK: - UITextField Delegate
extension CreateChallengeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Price field validation - only allow numbers and decimal point
        if textField == priceTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            
            // Check for valid characters
            guard allowedCharacters.isSuperset(of: characterSet) else {
                return false
            }
            
            // Check for multiple decimal points
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let decimalCount = newText.components(separatedBy: ".").count - 1
            return decimalCount <= 1
        }
        return true
    }
}

// MARK: - UITableView Delegate & DataSource
extension CreateChallengeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryOptions[indexPath.row]
        
        cell.textLabel?.text = category
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.selectionStyle = .none
        
        // Style the "Add New" option differently
        if category == "+ Add New Challenge Type" {
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        } else {
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        
        // Add background color on selection
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categoryOptions[indexPath.row]
        selectCategory(selectedCategory)
        
        // Brief highlight effect
        if let cell = tableView.cellForRow(at: indexPath) {
            UIView.animate(withDuration: 0.1, animations: {
                cell.backgroundColor = UIColor.systemGray6
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    cell.backgroundColor = .clear
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
