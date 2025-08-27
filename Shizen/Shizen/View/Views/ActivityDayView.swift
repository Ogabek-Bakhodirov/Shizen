//
//
//import UIKit
//
//// MARK: - Cell
//
//final class ActivityDayCell: UICollectionViewCell {
//    static let reuseID = "ActivityDayCell"
//
//    private let label = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.layer.cornerRadius = 6
//        contentView.layer.masksToBounds = true
//
//        label.font = .systemFont(ofSize: 12, weight: .semibold)
//        label.textAlignment = .center
//        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
//            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
//            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
//        ])
//    }
//
//    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//
//    func configure(dayNumber: Int?, inMonth: Bool, color: UIColor, outColor: UIColor) {
//        if let day = dayNumber, inMonth {
//            label.text = "\(day)"
//            contentView.backgroundColor = color
//            label.textColor = .white
//        } else {
//            label.text = ""
//            contentView.backgroundColor = outColor
//        }
//    }
//}
//
//// MARK: - Calendar View
//
//final class ActivityCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    var month: Date = Date() { didSet { rebuildGrid() } }
//
//    var activeColor: UIColor = .activeColor
//    var proActiveColor: UIColor = .proActiveColor
//    var ultraActive: UIColor = .ultraActiveColor
//    var maxActive: UIColor = .maxActiveColor
//    var inactiveColor: UIColor = .systemRed
//    var outOfMonthColor: UIColor = UIColor.systemGray5
//    var itemSpacing: CGFloat = 6
//    var cornerRadius: CGFloat = 6
//
//    private var calendar: Calendar = Calendar.current
//    private var daysInMonth = 30
//    private var leadingBlanks = 0
//    private var totalCells = 0
//
//    private var dayColors: [Int: UIColor] = [:] // 1-based day -> color
//
//    private let header = UIStackView()
//    private let collection: UICollectionView
//    private let flow = UICollectionViewFlowLayout()
//
//    override init(frame: CGRect) {
//        collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
//        super.init(coder: coder)
//        setup()
//    }
//
//    private func setup() {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        header.axis = .horizontal
//        header.alignment = .fill
//        header.distribution = .fillEqually
//        header.spacing = 4
//        header.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(header)
//
//        flow.minimumInteritemSpacing = itemSpacing
//        flow.minimumLineSpacing = itemSpacing
//
//        collection.backgroundColor = .clear
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.dataSource = self
//        collection.delegate = self
//        collection.register(ActivityDayCell.self, forCellWithReuseIdentifier: ActivityDayCell.reuseID)
//        addSubview(collection)
//
//        NSLayoutConstraint.activate([
//            header.topAnchor.constraint(equalTo: topAnchor),
//            header.leadingAnchor.constraint(equalTo: leadingAnchor),
//            header.trailingAnchor.constraint(equalTo: trailingAnchor),
//            header.heightAnchor.constraint(equalToConstant: 18),
//
//            collection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
//            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//
//        buildHeader()
//        rebuildGrid()
//    }
//
//    private func buildHeader() {
//        header.arrangedSubviews.forEach { $0.removeFromSuperview() }
//        let symbols = rotatedWeekdaySymbols()
//        for s in symbols {
//            let lbl = UILabel()
//            lbl.text = s
//            lbl.font = .systemFont(ofSize: 11, weight: .medium)
//            lbl.textAlignment = .center
//            lbl.textColor = .secondaryLabel
//            header.addArrangedSubview(lbl)
//        }
//    }
//
//    private func rotatedWeekdaySymbols() -> [String] {
//        let symbols = calendar.shortWeekdaySymbols
//        let start = calendar.firstWeekday - 1
//        return Array(symbols[start...] + symbols[..<start])
//    }
//
//    private func rebuildGrid() {
//        daysInMonth = calendar.range(of: .day, in: .month, for: month)?.count ?? 30
//        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
//        let weekdayOfFirst = calendar.component(.weekday, from: firstOfMonth)
//        leadingBlanks = ((weekdayOfFirst - calendar.firstWeekday) + 7) % 7
//        let filled = leadingBlanks + daysInMonth
//        totalCells = Int(ceil(Double(filled) / 7.0)) * 7
//        collection.reloadData()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        totalCells
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityDayCell.reuseID, for: indexPath) as! ActivityDayCell
//        let dayIndex = indexPath.item - leadingBlanks
//        if dayIndex >= 0 && dayIndex < daysInMonth {
//            let dayNumber = dayIndex + 1
//            let color = dayColors[dayNumber] ?? outOfMonthColor
//            cell.configure(dayNumber: dayNumber, inMonth: true, color: color, outColor: outOfMonthColor)
//            cell.contentView.layer.cornerRadius = cornerRadius
//        } else {
//            cell.configure(dayNumber: nil, inMonth: false, color: outOfMonthColor, outColor: outOfMonthColor)
//            cell.contentView.layer.cornerRadius = cornerRadius
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cols: CGFloat = 7
//        let totalSpacing = itemSpacing * (cols - 1)
//        let w = collectionView.bounds.width
//        let side = floor((w - totalSpacing) / cols)
//        return CGSize(width: side, height: side)
//    }
//
//    // MARK: - Traction History
//
//    func applyTractionHistory(_ history: [Date: Int]) {
//        dayColors.removeAll()
//        let comp = calendar.dateComponents([.year, .month], from: month)
//
//        for (date, value) in history {
//            let dc = calendar.dateComponents([.year, .month, .day], from: date)
//            if dc.year == comp.year, dc.month == comp.month, let day = dc.day {
//                if (value > 0) {
//                    if value > 8 {dayColors[day] = .ultraActiveColor}
//                    else if value > 5 {dayColors[day] = .maxActiveColor}
//                    else if value > 2 {dayColors[day] = .proActiveColor}
//                    else if value > 0 {dayColors[day] = .activeColor}
//                } else {
//                    dayColors[day] = inactiveColor
//                }
//            }
//        }
//
//        collection.reloadData()
//    }
//}
import UIKit

// MARK: - Colors
//extension UIColor {
//    static let activeColor = UIColor.systemGreen
//    static let proActiveColor = UIColor.green
//    static let ultraActiveColor = UIColor.systemTeal
//    static let maxActiveColor = UIColor.systemBlue
//}

// MARK: - UserModel & FocusSession (demo)
//struct FocusSession {
//    let id: UUID
//    let title: String
//    var dailyScore: Int
//    var totalScore: Int
//    var tractionHistory: [Date: Int]
//}

//class UserModel {
//    static let shared = UserModel()
//    var focusSession: [FocusSession] = [
//        FocusSession(
//            id: UUID(),
//            title: "Kunlik fokus rejimi",
//            dailyScore: 0,
//            totalScore: 0,
//            tractionHistory: [
//                Calendar.current.date(byAdding: .day, value: -2, to: Date())!: 1,
//                Calendar.current.date(byAdding: .day, value: -1, to: Date())!: 0,
//                Date(): 2
//            ]
//        )
//    ]
//}

// MARK: - ActivityDayCell
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
    
    func configure(dayNumber: Int?, inMonth: Bool, color: UIColor, outColor: UIColor) {
        if let day = dayNumber, inMonth {
            label.text = "\(day)"
            contentView.backgroundColor = color
        } else {
            label.text = ""
            contentView.backgroundColor = outColor
        }
    }
}

// MARK: - ActivityCalendarView
final class ActivityCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var month: Date = Date() { didSet { rebuildGrid() } }
    private var calendar: Calendar = Calendar.current
    private var daysInMonth = 30
    private var leadingBlanks = 0
    private var totalCells = 0
    private var dayColors: [Int: UIColor] = [:]
    
    private let flow = UICollectionViewFlowLayout()
    let collection: UICollectionView
    private let header = UIStackView()
    private let prevButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    
    private let activeColor: UIColor = .activeColor
    private let proActiveColor: UIColor = .proActiveColor
    private let ultraActive: UIColor = .ultraActiveColor
    private let maxActive: UIColor = .maxActiveColor
    private let inactiveColor: UIColor = .systemRed
    private let outOfMonthColor: UIColor = .systemGray5
    private let itemSpacing: CGFloat = 6
    private let cornerRadius: CGFloat = 6
    
    override init(frame: CGRect) {
        collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        super.init(frame: frame)
        setup()
        applyTractionHistory(UserModel.shared.focusSession.first!.tractionHistory)
    }
    
    required init?(coder: NSCoder) {
        collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        super.init(coder: coder)
        setup()
        applyTractionHistory(UserModel.shared.focusSession.first!.tractionHistory)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Header
        header.axis = .horizontal
        header.alignment = .fill
        header.distribution = .fillEqually
        header.spacing = 4
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        
        // Buttons
        prevButton.setTitle("<", for: .normal)
        nextButton.setTitle(">", for: .normal)
        prevButton.addTarget(self, action: #selector(prevMonth), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        addSubview(prevButton)
        addSubview(nextButton)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Collection
        flow.minimumInteritemSpacing = itemSpacing
        flow.minimumLineSpacing = itemSpacing
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ActivityDayCell.self, forCellWithReuseIdentifier: ActivityDayCell.reuseID)
        addSubview(collection)
        
        // Layout
        NSLayoutConstraint.activate([
            prevButton.topAnchor.constraint(equalTo: topAnchor),
            prevButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            prevButton.widthAnchor.constraint(equalToConstant: 40),
            prevButton.heightAnchor.constraint(equalToConstant: 30),
            
            nextButton.topAnchor.constraint(equalTo: topAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            nextButton.heightAnchor.constraint(equalToConstant: 30),
            
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: prevButton.trailingAnchor, constant: 5),
            header.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -5),
            header.heightAnchor.constraint(equalToConstant: 20),
            
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
        let symbols = calendar.shortWeekdaySymbols
        let start = calendar.firstWeekday - 1
        return Array(symbols[start...] + symbols[..<start])
    }
    
    private func rebuildGrid() {
        daysInMonth = calendar.range(of: .day, in: .month, for: month)?.count ?? 30
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let weekdayOfFirst = calendar.component(.weekday, from: firstOfMonth)
        leadingBlanks = ((weekdayOfFirst - calendar.firstWeekday) + 7) % 7
        let filled = leadingBlanks + daysInMonth
        totalCells = Int(ceil(Double(filled) / 7.0)) * 7
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { totalCells }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityDayCell.reuseID, for: indexPath) as! ActivityDayCell
        let dayIndex = indexPath.item - leadingBlanks
        if dayIndex >= 0 && dayIndex < daysInMonth {
            let dayNumber = dayIndex + 1
            let color = dayColors[dayNumber] ?? outOfMonthColor
            cell.configure(dayNumber: dayNumber, inMonth: true, color: color, outColor: outOfMonthColor)
            cell.contentView.layer.cornerRadius = cornerRadius
        } else {
            cell.configure(dayNumber: nil, inMonth: false, color: outOfMonthColor, outColor: outOfMonthColor)
            cell.contentView.layer.cornerRadius = cornerRadius
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cols: CGFloat = 7
        let totalSpacing = itemSpacing * (cols - 1)
        let w = collection.bounds.width
        let side = floor((w - totalSpacing) / cols)
        return CGSize(width: side, height: side)
    }
    
    // MARK: - Month Buttons
    @objc private func prevMonth() {
        month = calendar.date(byAdding: .month, value: -1, to: month) ?? month
        applyTractionHistory(UserModel.shared.focusSession.first!.tractionHistory)
    }
    
    @objc private func nextMonth() {
        month = calendar.date(byAdding: .month, value: 1, to: month) ?? month
        applyTractionHistory(UserModel.shared.focusSession.first!.tractionHistory)
    }
    
    // MARK: - Apply Traction History
    func applyTractionHistory(_ history: [Date: Int]) {
        dayColors.removeAll()
        let comp = calendar.dateComponents([.year, .month], from: month)
        for (date, value) in history {
            let dc = calendar.dateComponents([.year, .month, .day], from: date)
            if dc.year == comp.year, dc.month == comp.month, let day = dc.day {
                if value > 0 {
                    if value > 8 { dayColors[day] = ultraActive }
                    else if value > 5 { dayColors[day] = maxActive }
                    else if value > 2 { dayColors[day] = proActiveColor }
                    else { dayColors[day] = activeColor }
                } else {
                    dayColors[day] = inactiveColor
                }
            }
        }
        collection.reloadData()
    }
}

// MARK: - Demo ViewController
class CalendarDemoVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let calendarView = ActivityCalendarView()
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}
