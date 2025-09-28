//
//  ChallengesViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 25/09/25.
//

import UIKit

// MARK: - Models (File Level Scope)
struct Challenge {
    let emoji: String
    let title: String
    let description: String
    let price: String?
    let participants: String
    let isFree: Bool
}

struct MyChallenge {
    let emoji: String
    let title: String
    let description: String
    let participants: String
    let status: ChallengeStatus
    let isPrivate: Bool
}

enum ChallengeStatus {
    case active
    case ongoing
    case completed
    
    var title: String {
        switch self {
        case .active: return "Active"
        case .ongoing: return "Ongoing"
        case .completed: return "Completed"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .active, .ongoing: return UIColor.systemGreen
        case .completed: return UIColor.systemBlue
        }
    }
}

class ChallengesViewController: UIViewController {
    
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
    
    // Container views for different challenge types
    private let notJoinedContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myChallengesContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // My Challenges Table View
    private let myChallengesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var myChallenges: [MyChallenge] = []
    private var publicChallenges: [MyChallenge] = []
    private var privateChallenges: [MyChallenge] = []
    
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
        setupMyChallengesTableView()
        loadMyChallengesData()
        setupScrollViewInsets()
        
        // Set initial tab state
        updateTabButtonsAppearance()
        updateViewVisibility()
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
    
    private func setupMyChallengesTableView() {
        myChallengesTableView.delegate = self
        myChallengesTableView.dataSource = self
        myChallengesTableView.register(MyChallengeTableViewCell.self, forCellReuseIdentifier: "MyChallengeCell")
    }
    
    private func loadMyChallengesData() {
        myChallenges = [
            MyChallenge(
                emoji: "🧘‍♀️",
                title: "Daily Meditation",
                description: "Practice mindfulness for 10 minutes every day",
                participants: "45 participants",
                status: .active,
                isPrivate: false
            ),
            MyChallenge(
                emoji: "🥗",
                title: "Healthy Eating Challenge",
                description: "Eat 5 servings of fruits and vegetables daily",
                participants: "128 participants",
                status: .ongoing,
                isPrivate: false
            ),
            MyChallenge(
                emoji: "🌳",
                title: "Nature Walk",
                description: "Take a 30-minute walk in nature every day",
                participants: "67 participants",
                status: .active,
                isPrivate: false
            ),
            MyChallenge(
                emoji: "💪",
                title: "Personal Fitness Goals",
                description: "Complete daily workout routine for strength",
                participants: "3 participants",
                status: .ongoing,
                isPrivate: true
            ),
            MyChallenge(
                emoji: "🧠",
                title: "Memory Training",
                description: "Practice memory exercises and brain games",
                participants: "8 participants",
                status: .active,
                isPrivate: true
            )
        ]
        
        // Separate challenges into public and private
        publicChallenges = myChallenges.filter { !$0.isPrivate }
        privateChallenges = myChallenges.filter { $0.isPrivate }
        
        myChallengesTableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add main components to view
        view.addSubview(headerView)
        view.addSubview(tabToggleContainer)  // Move switcher to main view - stays fixed
        view.addSubview(notJoinedContainerView)
        view.addSubview(myChallengesContainerView)
        view.addSubview(createChallengeButton)  // Add to main view for floating effect
        
        // Setup Not Joined container (original scroll view)
        notJoinedContainerView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Setup My Challenges container
        myChallengesContainerView.addSubview(myChallengesTableView)
        
        headerView.addSubview(navigationTitleLabel)
        headerView.addSubview(profileImageView)
        
        // Move tab buttons to the fixed switcher
        tabToggleContainer.addSubview(myChallengesButton)
        tabToggleContainer.addSubview(notJoinedButton)
        
        // Add challenges to scroll view content (without switcher)
        contentView.addSubview(challengesStackView)
        
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
            
            // Fixed Tab Toggle Container (stays visible)
            tabToggleContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            tabToggleContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabToggleContainer.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            tabToggleContainer.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
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
            
            // Not Joined Container View (below fixed switcher)
            notJoinedContainerView.topAnchor.constraint(equalTo: tabToggleContainer.bottomAnchor, constant: 16),
            notJoinedContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notJoinedContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notJoinedContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // My Challenges Container View (below fixed switcher)
            myChallengesContainerView.topAnchor.constraint(equalTo: tabToggleContainer.bottomAnchor, constant: 16),
            myChallengesContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myChallengesContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myChallengesContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Scroll View (inside Not Joined container)
            scrollView.topAnchor.constraint(equalTo: notJoinedContainerView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: notJoinedContainerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: notJoinedContainerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: notJoinedContainerView.bottomAnchor),
            
            // My Challenges Table View (inside My Challenges container)
            myChallengesTableView.topAnchor.constraint(equalTo: myChallengesContainerView.topAnchor),
            myChallengesTableView.leadingAnchor.constraint(equalTo: myChallengesContainerView.leadingAnchor),
            myChallengesTableView.trailingAnchor.constraint(equalTo: myChallengesContainerView.trailingAnchor),
            myChallengesTableView.bottomAnchor.constraint(equalTo: myChallengesContainerView.bottomAnchor),
            
            // Content View (now without switcher)
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Challenges Stack View (content starts immediately)
            challengesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
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
        // Prevent redundant taps
        guard selectedTab != sender.tag else { return }
        
        selectedTab = sender.tag
        updateTabButtonsAppearance()
        
        // Animate transition between views (switcher stays fixed)
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.selectedTab == 0 {
                // Show My Challenges table view
                self.notJoinedContainerView.isHidden = true
                self.myChallengesContainerView.isHidden = false
            } else {
                // Show Not Joined global challenges scroll view
                self.notJoinedContainerView.isHidden = false
                self.myChallengesContainerView.isHidden = true
            }
        }, completion: nil)
    }
    
    private func updateViewVisibility() {
        if selectedTab == 0 {
            // Show My Challenges - switcher stays visible
            notJoinedContainerView.isHidden = true
            myChallengesContainerView.isHidden = false
        } else {
            // Show Not Joined (global challenges) - switcher stays visible
            notJoinedContainerView.isHidden = false
            myChallengesContainerView.isHidden = true
        }
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
        
        // Animate button state changes
        UIView.animate(withDuration: 0.2, animations: {
            for (index, button) in buttons.enumerated() {
                if index == self.selectedTab {
                    button.backgroundColor = UIColor.systemGreen
                    button.setTitleColor(.white, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    button.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                } else {
                    button.backgroundColor = UIColor.clear
                    button.setTitleColor(.systemGray, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                    button.transform = CGAffineTransform.identity
                }
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension ChallengesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Public and Private sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? publicChallenges.count : privateChallenges.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Public" : "Private"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChallengeCell", for: indexPath) as? MyChallengeTableViewCell else {
            return UITableViewCell()
        }
        
        let challenge = indexPath.section == 0 ? publicChallenges[indexPath.row] : privateChallenges[indexPath.row]
        cell.configure(with: challenge)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChallengesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = section == 0 ? "Public" : "Private"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let challenge = indexPath.section == 0 ? publicChallenges[indexPath.row] : privateChallenges[indexPath.row]
        print("Selected challenge: \(challenge.title)")
        // Handle challenge selection here
    }
}

// MARK: - Custom Table View Cell
class MyChallengeTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let participantsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let participantsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.2")
        imageView.tintColor = .tertiaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statusBadge: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(emojiLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(participantsIcon)
        containerView.addSubview(participantsLabel)
        containerView.addSubview(statusBadge)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // Emoji Label (Left side)
            emojiLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            emojiLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            emojiLabel.widthAnchor.constraint(equalToConstant: 40),
            emojiLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Title Label (Middle section)
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: statusBadge.leadingAnchor, constant: -12),
            
            // Description Label (Middle section)
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Participants Icon (Middle section)
            participantsIcon.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            participantsIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            participantsIcon.widthAnchor.constraint(equalToConstant: 14),
            participantsIcon.heightAnchor.constraint(equalToConstant: 14),
            
            // Participants Label (Middle section)
            participantsLabel.centerYAnchor.constraint(equalTo: participantsIcon.centerYAnchor),
            participantsLabel.leadingAnchor.constraint(equalTo: participantsIcon.trailingAnchor, constant: 4),
            participantsLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusBadge.leadingAnchor, constant: -12),
            
            // Status Badge (Right side)
            statusBadge.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusBadge.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            statusBadge.heightAnchor.constraint(equalToConstant: 24),
            statusBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    // MARK: - Configuration
    func configure(with challenge: MyChallenge) {
        emojiLabel.text = challenge.emoji
        titleLabel.text = challenge.title
        descriptionLabel.text = challenge.description
        
        // Hide status badges in My Challenges
        statusBadge.isHidden = true
        statusBadge.text = ""
        
        // Hide participants info for private challenges
        if challenge.isPrivate {
            participantsIcon.isHidden = true
            participantsLabel.isHidden = true
            participantsLabel.text = ""
        } else {
            participantsIcon.isHidden = false
            participantsLabel.isHidden = false
            participantsLabel.text = challenge.participants
        }
    }
}
