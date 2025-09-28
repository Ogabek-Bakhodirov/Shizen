import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTagView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let participantsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        contentView.addSubview(cardView)
        cardView.addSubview(emojiLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(priceTagView)
        cardView.addSubview(participantsLabel)
        
        priceTagView.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Card View
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Emoji Label
            emojiLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            emojiLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            emojiLabel.widthAnchor.constraint(equalToConstant: 50),
            emojiLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            // Price Tag View
            priceTagView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            priceTagView.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 16),
            priceTagView.heightAnchor.constraint(equalToConstant: 24),
            priceTagView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            
            // Price Label
            priceLabel.topAnchor.constraint(equalTo: priceTagView.topAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: priceTagView.leadingAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: priceTagView.trailingAnchor, constant: -12),
            priceLabel.bottomAnchor.constraint(equalTo: priceTagView.bottomAnchor, constant: -4),
            
            // Participants Label
            participantsLabel.centerYAnchor.constraint(equalTo: priceTagView.centerYAnchor),
            participantsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            participantsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: priceTagView.trailingAnchor, constant: 16)
        ])
    }
    
    // MARK: - Configuration
    func configure(with challenge: Challenge) {
        emojiLabel.text = challenge.emoji
        titleLabel.text = challenge.title
        descriptionLabel.text = challenge.description
        participantsLabel.text = challenge.participants
        
        // Configure price tag
        if challenge.isFree {
            priceLabel.text = \"Free\"
            priceLabel.textColor = .systemGreen
            priceTagView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        } else {
            priceLabel.text = \"Paid - \\(challenge.price ?? \"\")\"
            priceLabel.textColor = .systemOrange
            priceTagView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        }
    }
}