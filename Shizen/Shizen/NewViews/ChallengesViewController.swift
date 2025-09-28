//
//  ChallengesViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 25/09/25.
//

import UIKit

class ChallengesViewController: UIViewController {
    
    // MARK: - Models
    struct Challenge {
        let emoji: String
        let title: String
        let description: String
        let price: String?
        let participants: String
        let isFree: Bool
    }
    
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
    
    // Navigation Header
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Challenges"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.systemGray4
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add placeholder image or set a default profile image
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .white
        
        return imageView
    }()
    
    // Tab Toggle Buttons
    private let tabToggleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myChallengesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My Challenges", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 22
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        return button
    }()
    
    private let notJoinedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not Joined", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 22
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        return button
    }()
    
    // Challenges Stack View
    private let challengesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Create Challenge Button (Floating Action Button)
    private let createChallengeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Challenge", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 28  // Circular for FAB
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Add plus icon
        let plusImage = UIImage(systemName: "plus")
        button.setImage(plusImage, for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }()
    
    // MARK: - Properties
    private var selectedTab: Int = 1 // 0: My Challenges, 1: Not Joined
    
    private let challenges: [Challenge] = [
        Challenge(
            emoji: "🏃‍♀️",
            title: "Daily 5k Run Challenge",
            description: "Join a global community and commit to running 5 kilometers every day for 30 days.",
            price: nil,
            participants: "1,200 Participants",
            isFree: true
        ),
        Challenge(
            emoji: "🧘",
            title: "Mindful Morning Meditation",
            description: "Start your day with guided meditation sessions for 21 days. Enhance focus and mindfulness in your daily routine.",
            price: "UZS 25,000",
            participants: "450 Participants",
            isFree: false
        ),
        Challenge(
            emoji: "📚",
            title: "Read a Book a Week",
            description: "Dive into new worlds. Read one book per week for two months and discuss insights with fellow readers.",
            price: "UZS 15,000",
            participants: "780 Participants",
            isFree: false
        ),
        Challenge(
            emoji: "🥗",
            title: "Healthy Eating Habits",
            description: "Transform your diet with a 4-week challenge focused on whole foods, meal planning, and nutrition awareness.",
            price: nil,
            participants: "900 Participants",
            isFree: true
        )
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupNavigationBar()
        populateChallenges()
        setupScrollViewInsets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update scroll view insets after layout to ensure proper positioning
        setupScrollViewInsets()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        // Hide default navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupScrollViewInsets() {
        // Calculate the space needed for the floating action button
        let fabHeight: CGFloat = 56
        let fabBottomMargin: CGFloat = 24
        let additionalPadding: CGFloat = 20
        let totalBottomInset = fabHeight + fabBottomMargin + additionalPadding
        
        // Set content insets to ensure last cell is visible above FAB
        scrollView.contentInset.bottom = totalBottomInset
        scrollView.scrollIndicatorInsets.bottom = totalBottomInset
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(headerView)
        view.addSubview(scrollView)
        view.addSubview(createChallengeButton)  // Add to main view for floating effect
        scrollView.addSubview(contentView)
        
        headerView.addSubview(navigationTitleLabel)
        headerView.addSubview(profileImageView)
        
        contentView.addSubview(tabToggleContainer)
        contentView.addSubview(challengesStackView)
        
        tabToggleContainer.addSubview(myChallengesButton)
        tabToggleContainer.addSubview(notJoinedButton)
        
        // Add separator line below header
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.systemGray5
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Header View
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            // Navigation Title
            navigationTitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            navigationTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            // Profile Image
            profileImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24),
            profileImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32),
            
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Tab Toggle Container - Made flexible
            tabToggleContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            tabToggleContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tabToggleContainer.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 24),
            tabToggleContainer.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24),
            tabToggleContainer.heightAnchor.constraint(equalToConstant: 50),
            
            // Tab Buttons - Made flexible with equal widths
            myChallengesButton.leadingAnchor.constraint(equalTo: tabToggleContainer.leadingAnchor, constant: 4),
            myChallengesButton.topAnchor.constraint(equalTo: tabToggleContainer.topAnchor, constant: 3),
            myChallengesButton.bottomAnchor.constraint(equalTo: tabToggleContainer.bottomAnchor, constant: -3),
            
            notJoinedButton.leadingAnchor.constraint(equalTo: myChallengesButton.trailingAnchor, constant: 4),
            notJoinedButton.trailingAnchor.constraint(equalTo: tabToggleContainer.trailingAnchor, constant: -4),
            notJoinedButton.topAnchor.constraint(equalTo: tabToggleContainer.topAnchor, constant: 3),
            notJoinedButton.bottomAnchor.constraint(equalTo: tabToggleContainer.bottomAnchor, constant: -3),
            
            // Equal width constraint
            myChallengesButton.widthAnchor.constraint(equalTo: notJoinedButton.widthAnchor),
            
            // Challenges Stack View
            challengesStackView.topAnchor.constraint(equalTo: tabToggleContainer.bottomAnchor, constant: 32),
            challengesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            challengesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            challengesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Floating Action Button (FAB) - Fixed position bottom-right
            createChallengeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            createChallengeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            createChallengeButton.heightAnchor.constraint(equalToConstant: 56),
            createChallengeButton.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupActions() {
        myChallengesButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        notJoinedButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        createChallengeButton.addTarget(self, action: #selector(createChallengeTapped), for: .touchUpInside)
    }
    
    private func populateChallenges() {
        // Clear existing challenges
        challengesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add challenge cards
        for challenge in challenges {
            let challengeCard = createChallengeCard(for: challenge)
            challengesStackView.addArrangedSubview(challengeCard)
        }
    }
    
    private func createChallengeCard(for challenge: Challenge) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.05
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Emoji Label
        let emojiLabel = UILabel()
        emojiLabel.text = challenge.emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 24)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = challenge.title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Description Label
        let descriptionLabel = UILabel()
        descriptionLabel.text = challenge.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Price Label (if paid)
        let priceLabel = UILabel()
        if challenge.isFree {
            priceLabel.text = "Free"
            priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            priceLabel.textColor = .white
        } else {
            priceLabel.text = "Paid - \(challenge.price!)"
            priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            priceLabel.textColor = .white
        }
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Participants Container
        let participantsContainer = UIView()
        participantsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Participants Emoji
        let participantsEmojiLabel = UILabel()
        participantsEmojiLabel.text = "👥"
        participantsEmojiLabel.font = UIFont.systemFont(ofSize: 14)
        participantsEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Participants Label
        let participantsLabel = UILabel()
        participantsLabel.text = challenge.participants
        participantsLabel.font = UIFont.systemFont(ofSize: 12)
        participantsLabel.textColor = .systemGray
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Join Button
        let joinButton = UIButton(type: .system)
        joinButton.setTitle("Join", for: .normal)
        joinButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        joinButton.setTitleColor(.white, for: .normal)
        joinButton.backgroundColor = UIColor.systemGreen
        joinButton.layer.cornerRadius = 20
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.addTarget(self, action: #selector(joinChallengeTapped(_:)), for: .touchUpInside)
        
        // Add subviews
        cardView.addSubview(emojiLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(participantsContainer)
        cardView.addSubview(priceLabel)
        cardView.addSubview(joinButton)
        
        // Add participants components to container
        participantsContainer.addSubview(participantsEmojiLabel)
        participantsContainer.addSubview(participantsLabel)
        
        // Add padding to price label by using a container
        let priceLabelContainer = UIView()
        if challenge.isFree {
            priceLabelContainer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        } else {
            priceLabelContainer.backgroundColor = UIColor.systemOrange
        }
        priceLabelContainer.layer.cornerRadius = 14
        priceLabelContainer.clipsToBounds = true
        priceLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(priceLabelContainer)
        priceLabelContainer.addSubview(priceLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Card height
            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 160),
            
            // Emoji
            emojiLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            emojiLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            // Description
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            // Participants Container
            participantsContainer.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            participantsContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            participantsContainer.heightAnchor.constraint(equalToConstant: 20),
            
            // Participants Emoji
            participantsEmojiLabel.leadingAnchor.constraint(equalTo: participantsContainer.leadingAnchor),
            participantsEmojiLabel.centerYAnchor.constraint(equalTo: participantsContainer.centerYAnchor),
            
            // Participants Label
            participantsLabel.leadingAnchor.constraint(equalTo: participantsEmojiLabel.trailingAnchor, constant: 6),
            participantsLabel.centerYAnchor.constraint(equalTo: participantsContainer.centerYAnchor),
            participantsLabel.trailingAnchor.constraint(lessThanOrEqualTo: participantsContainer.trailingAnchor),
            
            // Price Label Container
            priceLabelContainer.topAnchor.constraint(equalTo: participantsContainer.bottomAnchor, constant: 12),
            priceLabelContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            priceLabelContainer.heightAnchor.constraint(equalToConstant: 28),
            
            // Price Label (inside container)
            priceLabel.topAnchor.constraint(equalTo: priceLabelContainer.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceLabelContainer.leadingAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: priceLabelContainer.trailingAnchor, constant: -12),
            priceLabel.bottomAnchor.constraint(equalTo: priceLabelContainer.bottomAnchor),
            
            // Join Button
            joinButton.centerYAnchor.constraint(equalTo: priceLabelContainer.centerYAnchor),
            joinButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            joinButton.heightAnchor.constraint(equalToConstant: 40),
            joinButton.widthAnchor.constraint(equalToConstant: 70),
            joinButton.bottomAnchor.constraint(greaterThanOrEqualTo: cardView.bottomAnchor, constant: -20)
        ])
        
        return cardView
    }
    
    // MARK: - Actions
    @objc private func tabButtonTapped(_ sender: UIButton) {
        selectedTab = sender.tag
        updateTabButtonsAppearance()
    }
    
    @objc private func joinChallengeTapped(_ sender: UIButton) {
        print("Join challenge tapped")
        // Add join challenge logic here
    }
    
    @objc private func createChallengeTapped() {
        print("Create challenge tapped")
        // Navigate to create challenge screen
    }
    
    // MARK: - Helper Methods
    private func updateTabButtonsAppearance() {
        let buttons = [myChallengesButton, notJoinedButton]
        
        for (index, button) in buttons.enumerated() {
            if index == selectedTab {
                button.backgroundColor = UIColor.systemGreen
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            } else {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(.systemGray, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            }
        }
    }
}
