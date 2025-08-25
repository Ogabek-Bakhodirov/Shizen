import UIKit

// MARK: - Cell

final class ActivityDayCell: UICollectionViewCell {
    static let reuseID = "ActivityDayCell"

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true

        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(dayNumber: Int?, inMonth: Bool, active: Bool,
                   activeColor: UIColor, inactiveColor: UIColor, outColor: UIColor) {
        if let day = dayNumber, inMonth {
            label.text = "\(day)"
            contentView.backgroundColor = active ? activeColor : inactiveColor
            label.textColor = .white
            isAccessibilityElement = true
            accessibilityLabel = "Day \(day)"
            accessibilityValue = active ? "Active" : "Inactive"
        } else {
            label.text = ""
            contentView.backgroundColor = outColor
            isAccessibilityElement = false
        }
    }
}

// MARK: - View

final class ActivityCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Public API
    var month: Date = Date() { didSet { rebuildGrid() } }
    /// 1-based days in month that were active
    var activeDays: Set<Int> = [] { didSet { collection.reloadData() } }

    var activeColor: UIColor = .systemGreen { didSet { collection.reloadData() } }
    var inactiveColor: UIColor = .systemRed { didSet { collection.reloadData() } }
    var outOfMonthColor: UIColor = UIColor.systemGray5 { didSet { collection.reloadData() } }
    var itemSpacing: CGFloat = 6 { didSet { flow.minimumInteritemSpacing = itemSpacing; flow.minimumLineSpacing = itemSpacing; collection.collectionViewLayout.invalidateLayout() } }
    var cornerRadius: CGFloat = 6 { didSet { collection.visibleCells.forEach { $0.contentView.layer.cornerRadius = cornerRadius } } }

    // Internals
    private let calendar: Calendar = {
        var cal = Calendar.current
        // Uncomment next line to force Monday as first weekday regardless of locale:
        // cal.firstWeekday = 2
        return cal
    }()
    private var daysInMonth = 30
    private var leadingBlanks = 0
    private var totalCells = 0

    private let header = UIStackView()
    private let collection: UICollectionView
    private let flow = UICollectionViewFlowLayout()

    override init(frame: CGRect) {
        collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // Header: weekday symbols
        header.axis = .horizontal
        header.alignment = .fill
        header.distribution = .fillEqually
        header.spacing = 4
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)

        // Collection
        flow.minimumInteritemSpacing = itemSpacing
        flow.minimumLineSpacing = itemSpacing

        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ActivityDayCell.self, forCellWithReuseIdentifier: ActivityDayCell.reuseID)
        addSubview(collection)

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 18),

            collection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        buildHeader()
        rebuildGrid()
    }

    private func buildHeader() {
        header.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let symbols = rotatedWeekdaySymbols()
        for s in symbols {
            let lbl = UILabel()
            lbl.text = s
            lbl.font = .systemFont(ofSize: 11, weight: .medium)
            lbl.textAlignment = .center
            lbl.textColor = .secondaryLabel
            header.addArrangedSubview(lbl)
        }
    }

    private func rotatedWeekdaySymbols() -> [String] {
        // shortWeekdaySymbols starts on Sunday for most locales; rotate to match calendar.firstWeekday
        let symbols = calendar.shortWeekdaySymbols // e.g. ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        let start = calendar.firstWeekday - 1 // make it 0-based
        return Array(symbols[start...] + symbols[..<start])
    }

    private func rebuildGrid() {
        daysInMonth = calendar.range(of: .day, in: .month, for: month)?.count ?? 30
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let weekdayOfFirst = calendar.component(.weekday, from: firstOfMonth) // 1..7 (Sun=1)
        // leading blanks relative to calendar.firstWeekday
        leadingBlanks = ((weekdayOfFirst - calendar.firstWeekday) + 7) % 7
        let filled = leadingBlanks + daysInMonth
        totalCells = Int(ceil(Double(filled) / 7.0)) * 7
        collection.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityDayCell.reuseID, for: indexPath) as! ActivityDayCell

        let dayIndex = indexPath.item - leadingBlanks // 0-based within month
        if dayIndex >= 0 && dayIndex < daysInMonth {
            let dayNumber = dayIndex + 1
            let isActive = activeDays.contains(dayNumber)
            cell.configure(dayNumber: dayNumber,
                           inMonth: true,
                           active: isActive,
                           activeColor: activeColor,
                           inactiveColor: inactiveColor,
                           outColor: outOfMonthColor)
            cell.contentView.layer.cornerRadius = cornerRadius
        } else {
            cell.configure(dayNumber: nil,
                           inMonth: false,
                           active: false,
                           activeColor: activeColor,
                           inactiveColor: inactiveColor,
                           outColor: outOfMonthColor)
            cell.contentView.layer.cornerRadius = cornerRadius
        }
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cols: CGFloat = 7
        let totalSpacing = itemSpacing * (cols - 1)
        let w = collectionView.bounds.width
        let side = floor((w - totalSpacing) / cols)
        return CGSize(width: side, height: side) // perfect squares
    }
}

