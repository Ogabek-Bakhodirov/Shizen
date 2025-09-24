


import UIKit

class ProfileViewControllerr: UIViewController, UICollectionViewDataSource, UITableViewDataSource {
    
    // Mock Data
    private let badgesData = [
        ("star.fill", UIColor.systemYellow, "Star Performer"),
        ("sun.max.fill", UIColor.systemOrange, "Early Riser"),
        ("crown.fill", UIColor.systemPurple, "Consistency King"),
        ("leaf.fill", UIColor.systemGreen, "Zen Master"),
        ("mountain.2.fill", UIColor.systemBrown, "Mountain Climber"),
        ("flame.fill", UIColor.systemRed, "Fire Starter"),
        ("heart.fill", UIColor.systemPink, "Health Hero"),
        ("moon.fill", UIColor.systemIndigo, "Night Owl")
    ]
    
    private let activityData = [
        ("flame.fill", UIColor.systemRed, "Completed Meditation", "Challenge complete", "2 days ago"),
        ("target", UIColor.systemBlue, "Achieved 30-day streak", "Milestone reached", "5 days ago")
    ]
    
    // MARK: - DataSource (TableView)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as? ActivityCell else {
            return UITableViewCell()
        }
        let activity = activityData[indexPath.row]
        cell.configure(
            icon: activity.0,
            iconColor: activity.1,
            title: activity.2,
            subtitle: activity.3,
            timeAgo: activity.4
        )
        return cell
    }
    
    // MARK: - DataSource (CollectionView)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badgesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCell", for: indexPath) as? BadgeCell else {
            return UICollectionViewCell()
        }
        let badge = badgesData[indexPath.item]
        cell.configure(icon: badge.0, color: badge.1, title: badge.2)
        return cell
    }
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Header
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    
    // Stats stack
    private let statsStack = UIStackView()
    
    // Progress
    private let progressCircleView = UIView()
    private let progressLabel = UILabel()
    private let progressDescriptionLabel = UILabel()
    
    // Badges
    private let badgesLabel = UILabel()
    private var badgesCollectionView: UICollectionView!
    
    // Activity
    private let activityLabel = UILabel()
    private let activityTableView = UITableView()
    
    // Buttons
    private let startChallengeButton = UIButton(type: .system)
    private let inviteFriendsButton = UIButton(type: .system)
    
    // Tab bar
    private let tabBarView = UIView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Header
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemBlue
        profileImageView.contentMode = .scaleAspectFit
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Jane Doe"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.text = "Cultivating good habits!"
        bioLabel.textColor = .secondaryLabel
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        
        // Stats
        statsStack.axis = .horizontal
        statsStack.distribution = .fillEqually
        statsStack.alignment = .center
        statsStack.spacing = 20
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        
        statsStack.addArrangedSubview(makeStatView(icon: "flame.fill", value: "34", label: "Streak", color: .systemRed))
        statsStack.addArrangedSubview(makeStatView(icon: "trophy.fill", value: "12", label: "Challenges", color: .systemGreen))
        statsStack.addArrangedSubview(makeStatView(icon: "chart.line.uptrend.xyaxis", value: "85%", label: "Retention", color: .systemPurple))
        
        contentView.addSubview(statsStack)
        
        // Progress
        progressCircleView.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        progressLabel.text = "75%"
        progressLabel.font = UIFont.boldSystemFont(ofSize: 32)
        progressLabel.textColor = .systemGreen
        progressLabel.textAlignment = .center
        
        progressDescriptionLabel.text = "Day 15 streak"
        progressDescriptionLabel.textColor = .secondaryLabel
        progressDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        progressDescriptionLabel.textAlignment = .center
        
        contentView.addSubview(progressCircleView)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressDescriptionLabel)
        
        // Badges
        badgesLabel.translatesAutoresizingMaskIntoConstraints = false
        badgesLabel.text = "Badges"
        badgesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        badgesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        badgesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        badgesCollectionView.backgroundColor = .clear
        badgesCollectionView.dataSource = self
        badgesCollectionView.register(BadgeCell.self, forCellWithReuseIdentifier: "BadgeCell")
        badgesCollectionView.showsHorizontalScrollIndicator = false
        badgesCollectionView.decelerationRate = .fast
        
        contentView.addSubview(badgesLabel)
        contentView.addSubview(badgesCollectionView)
        
        // Activity
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.text = "Recent Activity"
        activityLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        activityTableView.translatesAutoresizingMaskIntoConstraints = false
        activityTableView.dataSource = self
        activityTableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        activityTableView.isScrollEnabled = false
        
        contentView.addSubview(activityLabel)
        contentView.addSubview(activityTableView)
        
        // Buttons
        startChallengeButton.translatesAutoresizingMaskIntoConstraints = false
        startChallengeButton.setTitle("Start Challenge", for: .normal)
        startChallengeButton.backgroundColor = .systemGreen
        startChallengeButton.setTitleColor(.white, for: .normal)
        startChallengeButton.layer.cornerRadius = 12
        
        inviteFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        inviteFriendsButton.setTitle("Invite Friends", for: .normal)
        inviteFriendsButton.backgroundColor = .systemPurple
        inviteFriendsButton.setTitleColor(.white, for: .normal)
        inviteFriendsButton.layer.cornerRadius = 12
        
        contentView.addSubview(startChallengeButton)
        contentView.addSubview(inviteFriendsButton)
        
        // Tab bar
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
//        tabBarView.backgroundColor = .systemBackground
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOpacity = 0.1
        tabBarView.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBarView.layer.shadowRadius = 2
        
        // Add a border for debugging
        tabBarView.layer.borderWidth = 1
        tabBarView.layer.borderColor = UIColor.clear.cgColor
        
        setupTabBarButtons()
        view.addSubview(tabBarView)
    }
    
    private func setupTabBarButtons() {
        print("Setting up tab bar buttons...")
        
        let homeButton = createTabBarButton(icon: "house.fill", title: "Home", isSelected: true)
        let challengesButton = createTabBarButton(icon: "trophy.fill", title: "Challenges", isSelected: false)
        let profileButton = createTabBarButton(icon: "person.fill", title: "Profile", isSelected: false)
        let settingsButton = createTabBarButton(icon: "gearshape.fill", title: "Settings", isSelected: false)
        
        // Add action targets
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        challengesButton.addTarget(self, action: #selector(challengesButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        let tabStackView = UIStackView(arrangedSubviews: [homeButton, challengesButton, profileButton, settingsButton])
        tabStackView.translatesAutoresizingMaskIntoConstraints = false
        tabStackView.axis = .horizontal
        tabStackView.distribution = .fillEqually
        tabStackView.alignment = .center
        
        tabBarView.addSubview(tabStackView)
        
        NSLayoutConstraint.activate([
            tabStackView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 20),
            tabStackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -20),
            tabStackView.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 8),
            tabStackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -8)
        ])
    }
    
    private func createTabBarButton(icon: String, title: String, isSelected: Bool) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Add debug background color
//        button.backgroundColor = UIColor./*systemGray6*/
        button.layer.cornerRadius = 8
        
        // Create a vertical stack for icon and title
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView(image: UIImage(systemName: icon))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = isSelected ? .systemGreen : .secondaryLabel
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        titleLabel.textColor = isSelected ? .systemGreen : .secondaryLabel
        titleLabel.textAlignment = .center
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor, constant: -4)
        ])
        
        return button
    }
    
    // MARK: - Tab Bar Actions
    @objc private func homeButtonTapped() {
        print("Home button tapped")
        // Handle home navigation
    }
    
    @objc private func challengesButtonTapped() {
        print("Challenges button tapped")
        // Handle challenges navigation
    }
    
    @objc private func profileButtonTapped() {
        print("Profile button tapped")
        // Handle profile navigation
    }
    
    @objc private func settingsButtonTapped() {
        print("Settings button tapped")
        // Handle settings navigation
    }
    
    private func makeStatView(icon: String, value: String, label: String, color: UIColor) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.spacing = 4
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = color
        iconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.textColor = .secondaryLabel
        
        container.addArrangedSubview(iconView)
        container.addArrangedSubview(valueLabel)
        container.addArrangedSubview(textLabel)
        
        return container
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Header
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            bioLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // Stats
            statsStack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            statsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Progress
            progressCircleView.topAnchor.constraint(equalTo: statsStack.bottomAnchor, constant: 30),
            progressCircleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progressCircleView.widthAnchor.constraint(equalToConstant: 120),
            progressCircleView.heightAnchor.constraint(equalToConstant: 120),
            
            progressLabel.centerXAnchor.constraint(equalTo: progressCircleView.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: progressCircleView.centerYAnchor),
            
            progressDescriptionLabel.topAnchor.constraint(equalTo: progressCircleView.bottomAnchor, constant: 12),
            progressDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Badges
            badgesLabel.topAnchor.constraint(equalTo: progressDescriptionLabel.bottomAnchor, constant: 30),
            badgesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            badgesCollectionView.topAnchor.constraint(equalTo: badgesLabel.bottomAnchor, constant: 12),
            badgesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            badgesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            badgesCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            // Activity
            activityLabel.topAnchor.constraint(equalTo: badgesCollectionView.bottomAnchor, constant: 30),
            activityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            activityTableView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 12),
            activityTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            activityTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            activityTableView.heightAnchor.constraint(equalToConstant: 160),
            
            // Buttons
            startChallengeButton.topAnchor.constraint(equalTo: activityTableView.bottomAnchor, constant: 20),
            startChallengeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            startChallengeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            startChallengeButton.heightAnchor.constraint(equalToConstant: 50),
            
            inviteFriendsButton.topAnchor.constraint(equalTo: startChallengeButton.bottomAnchor, constant: 12),
            inviteFriendsButton.leadingAnchor.constraint(equalTo: startChallengeButton.leadingAnchor),
            inviteFriendsButton.trailingAnchor.constraint(equalTo: startChallengeButton.trailingAnchor),
            inviteFriendsButton.heightAnchor.constraint(equalToConstant: 50),
            inviteFriendsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            // Tab bar
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
