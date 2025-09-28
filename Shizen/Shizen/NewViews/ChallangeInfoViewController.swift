//
//  ChallangeInfoViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 29/09/25.
//

import UIKit

class ChallangeInfoViewController: UIViewControllerExtensions {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Header
    private let heroImageView = UIImageView()
    private let challengeTitleLabel = UILabel()
    
    // Challenge Info Section
    private let challengeInfoLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let paidBadge = UILabel()
    private let participantsLabel = UILabel()
    private let joinButton = UIButton()
    
    // Participants Section
    private let participantsHeaderLabel = UILabel()
    private let participantAvatarsStackView = UIStackView()
    private let participantsTableView = UITableView()
    
    // Additional Info Section
    private let additionalInfoLabel = UILabel()
    private let infoStackView = UIStackView()
    
    // Data
    private let participants = [
        Participant(name: "Elena K.", rank: 1, isCreator: true, trophy: .gold),
        Participant(name: "Mark T.", rank: 2, isCreator: false, trophy: .gold),
        Participant(name: "Sofia P.", rank: 3, isCreator: false, trophy: .silver),
        Participant(name: "David L.", rank: 4, isCreator: false, trophy: .bronze),
        Participant(name: "Anna B.", rank: 5, isCreator: false, trophy: nil),
        Participant(name: "Omar H.", rank: 6, isCreator: false, trophy: nil),
        Participant(name: "Chloe W.", rank: 7, isCreator: false, trophy: nil),
        Participant(name: "Liam J.", rank: 8, isCreator: false, trophy: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Setup navigation
        navigationItem.title = "Challenge Info"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Hero image
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 12
        heroImageView.backgroundColor = .systemOrange
        
        // Challenge title
        challengeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        challengeTitleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        challengeTitleLabel.textColor = .white
        challengeTitleLabel.numberOfLines = 0
        
        // Challenge info header
        challengeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        challengeInfoLabel.font = UIFont.boldSystemFont(ofSize: 22)
        challengeInfoLabel.text = "Challenge Info"
        
        // Description
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        
        // Paid badge
        paidBadge.translatesAutoresizingMaskIntoConstraints = false
        paidBadge.font = UIFont.boldSystemFont(ofSize: 12)
        paidBadge.textColor = .white
        paidBadge.backgroundColor = .systemTeal
        paidBadge.layer.cornerRadius = 12
        paidBadge.clipsToBounds = true
        paidBadge.textAlignment = .center
        
        // Participants count
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        participantsLabel.font = UIFont.systemFont(ofSize: 14)
        participantsLabel.textColor = .secondaryLabel
        
        // Join button
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.backgroundColor = .systemGreen
        joinButton.setTitleColor(.white, for: .normal)
        joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        joinButton.layer.cornerRadius = 25
        
        // Participants header
        participantsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        participantsHeaderLabel.font = UIFont.boldSystemFont(ofSize: 22)
        participantsHeaderLabel.text = "Participants"
        
        // Participants avatars
        participantAvatarsStackView.translatesAutoresizingMaskIntoConstraints = false
        participantAvatarsStackView.axis = .horizontal
        participantAvatarsStackView.spacing = 8
        participantAvatarsStackView.distribution = .fillEqually
        
        // Participants table
        participantsTableView.translatesAutoresizingMaskIntoConstraints = false
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
        participantsTableView.register(ParticipantTableViewCell.self, forCellReuseIdentifier: "ParticipantCell")
        participantsTableView.isScrollEnabled = false
        participantsTableView.separatorStyle = .none
        
        // Additional info header
        additionalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalInfoLabel.font = UIFont.boldSystemFont(ofSize: 22)
        additionalInfoLabel.text = "Additional Info"
        
        // Info stack view
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.spacing = 16
        
        // Add to view hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(heroImageView)
        heroImageView.addSubview(challengeTitleLabel)
        contentView.addSubview(challengeInfoLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(paidBadge)
        contentView.addSubview(participantsLabel)
        contentView.addSubview(joinButton)
        contentView.addSubview(participantsHeaderLabel)
        contentView.addSubview(participantAvatarsStackView)
        contentView.addSubview(participantsTableView)
        contentView.addSubview(additionalInfoLabel)
        contentView.addSubview(infoStackView)
        
        setupParticipantAvatars()
        setupAdditionalInfo()
    }
    
    private func setupParticipantAvatars() {
        let avatarNames = ["Elena K.", "Mark T.", "Sofia P.", "David L.", "Anna B."]
        
        for name in avatarNames {
            let avatarView = UIView()
            avatarView.translatesAutoresizingMaskIntoConstraints = false
            avatarView.backgroundColor = .systemBlue
            avatarView.layer.cornerRadius = 25
            avatarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            avatarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            let initialsLabel = UILabel()
            initialsLabel.translatesAutoresizingMaskIntoConstraints = false
            initialsLabel.text = String(name.prefix(1))
            initialsLabel.textColor = .white
            initialsLabel.font = UIFont.boldSystemFont(ofSize: 18)
            initialsLabel.textAlignment = .center
            
            avatarView.addSubview(initialsLabel)
            NSLayoutConstraint.activate([
                initialsLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
                initialsLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
            ])
            
            participantAvatarsStackView.addArrangedSubview(avatarView)
        }
    }
    
    private func setupAdditionalInfo() {
        let infoItems = [
            ("Category:", "Health & Fitness"),
            ("Frequency:", "Daily"),
            ("Duration:", "30 Days"),
            ("Creator:", "FitLife Studios")
        ]
        
        for (title, value) in infoItems {
            let itemView = createInfoRow(title: title, value: value)
            infoStackView.addArrangedSubview(itemView)
        }
    }
    
    private func createInfoRow(title: String, value: String) -> UIView {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .label
        valueLabel.text = value
        valueLabel.textAlignment = .right
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 16)
        ])
        
        return containerView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Hero image
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            heroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heroImageView.heightAnchor.constraint(equalToConstant: 180),
            
            // Challenge title (overlay on hero image)
            challengeTitleLabel.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 20),
            challengeTitleLabel.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: -20),
            challengeTitleLabel.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -20),
            
            // Challenge info header
            challengeInfoLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 24),
            challengeInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            challengeInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Description
            descriptionLabel.topAnchor.constraint(equalTo: challengeInfoLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Paid badge
            paidBadge.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            paidBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            paidBadge.widthAnchor.constraint(equalToConstant: 120),
            paidBadge.heightAnchor.constraint(equalToConstant: 24),
            
            // Participants count
            participantsLabel.centerYAnchor.constraint(equalTo: paidBadge.centerYAnchor),
            participantsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Join button
            joinButton.topAnchor.constraint(equalTo: paidBadge.bottomAnchor, constant: 20),
            joinButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            joinButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            joinButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Participants header
            participantsHeaderLabel.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 32),
            participantsHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            participantsHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Participant avatars
            participantAvatarsStackView.topAnchor.constraint(equalTo: participantsHeaderLabel.bottomAnchor, constant: 16),
            participantAvatarsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            participantAvatarsStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            participantAvatarsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Participants table
            participantsTableView.topAnchor.constraint(equalTo: participantAvatarsStackView.bottomAnchor, constant: 20),
            participantsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            participantsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            participantsTableView.heightAnchor.constraint(equalToConstant: CGFloat(participants.count * 60)),
            
            // Additional info header
            additionalInfoLabel.topAnchor.constraint(equalTo: participantsTableView.bottomAnchor, constant: 32),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            additionalInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Info stack view
            infoStackView.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    private func configureData() {
        challengeTitleLabel.text = "30-Day Fitness Blast Challenge"
        descriptionLabel.text = "Join our 30-day fitness challenge designed to boost your energy, improve your strength, and enhance overall well-being. Each day brings a new workout focus, from cardio to strength training."
        paidBadge.text = "Paid - 25,000 UZS"
        participantsLabel.text = "👥 128 participants"
        joinButton.setTitle("Join Challenge", for: .normal)
    }
}

// MARK: - TableView DataSource & Delegate
extension ChallangeInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantTableViewCell
        let participant = participants[indexPath.row]
        cell.configure(with: participant)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - Models
struct Participant {
    let name: String
    let rank: Int
    let isCreator: Bool
    let trophy: TrophyType?
}

enum TrophyType {
    case gold
    case silver
    case bronze
    
    var emoji: String {
        switch self {
        case .gold: return "🏆"
        case .silver: return "🥈"
        case .bronze: return "🥉"
        }
    }
}

// MARK: - Custom Cell
class ParticipantTableViewCell: UITableViewCell {
    private let avatarView = UIView()
    private let nameLabel = UILabel()
    private let rankLabel = UILabel()
    private let creatorLabel = UILabel()
    private let trophyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        // Avatar
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.backgroundColor = .systemBlue
        avatarView.layer.cornerRadius = 20
        
        // Name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Rank
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.font = UIFont.systemFont(ofSize: 14)
        rankLabel.textColor = .secondaryLabel
        
        // Creator badge
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorLabel.font = UIFont.systemFont(ofSize: 12)
        creatorLabel.textColor = .systemRed
        creatorLabel.text = "Creator"
        
        // Trophy
        trophyLabel.translatesAutoresizingMaskIntoConstraints = false
        trophyLabel.font = UIFont.systemFont(ofSize: 20)
        
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(trophyLabel)
        
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            avatarView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            rankLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            rankLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            
            creatorLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8),
            creatorLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            
            trophyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trophyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with participant: Participant) {
        nameLabel.text = participant.name
        rankLabel.text = "Rank #\(participant.rank)"
        creatorLabel.isHidden = !participant.isCreator
        trophyLabel.text = participant.trophy?.emoji ?? ""
        
        // Set avatar color based on name
        let colors: [UIColor] = [.systemBlue, .systemGreen, .systemPurple, .systemOrange, .systemPink]
        avatarView.backgroundColor = colors[participant.rank % colors.count]
    }
}
