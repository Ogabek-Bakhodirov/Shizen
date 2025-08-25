//
//  ChatViewController.swift
//  Focus
//
//  Created by Ogabek Bakhodirov on 28/11/24.
//

import UIKit
import UserNotifications

class ChatViewController: UIViewController {
    
    private var startTime: Date?
    
//    let model = GenerativeModel(name: "gemini-2.0-flash", apiKey: APIKey.default)
    let model = ""
    
    let awardManager = AwardManager()
    
    let center = UNUserNotificationCenter.current()
    
//    private let openAIService = OpenAIService()
//    private let huggingFaceService = HuggingFaceService()
    
    private var isKeyboardShown = false
    var font = UIFont.systemFont(ofSize: 16)
    var maxWidth = windowWidth - universalWidth(98)
    
//    private let shieldManager = ShieldManager()
    
        
//    private lazy var chatViewTop: ChatView = {
//        let view = ChatView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.gotoappButtonClousure = { [weak self] in
//            if let selectedApp = URL(string: SELECTED_APP?.app_url ?? "")  {
//                print(UserModel.shared.printAll())
//                var result = self?.awardManager.checkAward()
//                
//                if result != nil { self?.sendLocalNotification(title: result?.award.awardTitle ?? "Qalaysiiiiz )") }
//                
//                AppSharedManager.shared.setAppWindowState(window: .root)
//                UIApplication.shared.open(selectedApp)
////                self?.dismiss(animated: false)
//            }
//        }
//        return view 
//    }()
    
    private lazy var mainBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainBackgroundColor
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(AIMessageCell.self, forCellReuseIdentifier: AIMessageCell.cellName)
        view.register(UserMessageCell.self, forCellReuseIdentifier: UserMessageCell.cellName)
        let hideKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(hideKeyboard))
        hideKeyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(hideKeyboardTap)
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    //    QuizView
//    private lazy var quizView: QuizView = {
//        let view = QuizView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .mainBackgroundColor
//        return view
//    }()
    
    private lazy var customTextField: CustomTextField = {
       let view = CustomTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onKeyboardTapped = { [weak self] tapped in
            self?.isKeyboardShown = tapped 
            self?.textFieldUpWhenKeyboardOpened()
        }
        view.sentMessage = { [weak self] user in
            self?.tableView.reloadData()
            Task {
                    await self?.geminiGenerateResponse(userMessage: user.conversationHistory.last?.content ?? "")
                    self?.tableView.reloadData()
                    print(user)
                }
        }
        return view
    }()
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("ChatViewController INIT - Instance Created 🚀")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - Make Dark Safe Area
    override var preferredStatusBarStyle: UIStatusBarStyle { return .darkContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: .appDidEnterBackground, object: nil)
        Task {
                print("geminiGenerateQuiz")
                await self.geminiGenerateQuiz(userQuizHistory: ["English, degree b1"])
            }

        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTime = Date()
        print("******************* view Will Appear *******************")
    }
 
        
    func textFieldUpWhenKeyboardOpened(){
        if isKeyboardShown{
            customTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: universalHeight(-50)).isActive = false
            self.customTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: universalHeight(-300)).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: customTextField.topAnchor).isActive = true
//            self.tableView.topAnchor.constraint(equalTo: chatViewTop.bottomAnchor).isActive = true
           
        } else if isKeyboardShown == false {
            customTextField.removeFromSuperview()
            tableView.removeFromSuperview()
            view.addSubview(tableView)
//            view.addSubview(quizView)
            view.addSubview(customTextField)
            
            self.customTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: universalHeight(-300)).isActive = false
            
            NSLayoutConstraint.activate([
                customTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: universalHeight(-50)),
                customTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(20)),
                customTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
                customTextField.heightAnchor.constraint(equalToConstant: universalHeight(46)),
                
//                tableView.topAnchor.constraint(equalTo:  chatViewTop.bottomAnchor),
                tableView.bottomAnchor.constraint(equalTo: customTextField.topAnchor),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                
            ])
        }
                
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()  // Forces the layout to update
        }
    }
    


    func setupSubviews(){
        view.addSubview(mainBackgroundView)
//        view.addSubview(chatViewTop)
//        quizViewSetup()
//        view.addSubview(quizView)
//        view.addSubview(tableView)
//        view.addSubview(customTextField)
        
        NSLayoutConstraint.activate([
            
            mainBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            mainBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            
//            chatViewTop.topAnchor.constraint(equalTo: view.topAnchor),
//            chatViewTop.leftAnchor.constraint(equalTo: view.leftAnchor),
//            chatViewTop.rightAnchor.constraint(equalTo: view.rightAnchor),
//            chatViewTop.heightAnchor.constraint(equalToConstant: universalHeight(102)),
            
//            customTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: universalHeight(-50)),
//            customTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(20)),
//            customTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(40)),
//            customTextField.heightAnchor.constraint(equalToConstant: universalHeight(46)),
            
//            quizView.topAnchor.constraint(equalTo: chatViewTop.bottomAnchor),
//            quizView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            quizView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            quizView.rightAnchor.constraint(equalTo: view.rightAnchor),

        ])
    }
    
//    func quizViewSetup(){
//        view.addSubview(quizView)
//        
//        NSLayoutConstraint.activate([
//            quizView.topAnchor.constraint(equalTo: chatViewTop.bottomAnchor),
//            quizView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            quizView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            quizView.rightAnchor.constraint(equalTo: view.rightAnchor),
//        ])
//    }
    
    func stopTimeIntervalAndUpdateUserModel() {
        if let startTime = self.startTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            UserModel.shared.changeQuizUsageTime(time: elapsedTime)
            self.startTime = nil
            print("User spent \(elapsedTime) seconds on quiz.")
        }
    }
    
    @objc func appDidEnterBackground(_ notification: Notification) {
        self.stopTimeIntervalAndUpdateUserModel()
        print("app Did Enter Background: ===============")
        print(UserModel.shared.printAll())
        print(AwardBase.shared.getAwardBase())
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self) // Cleanup observer
        print("ChatViewController deinitialized")
    }
    
    private func sendLocalNotification(title: String){
        let content = UNMutableNotificationContent ()
        content.title = title
        content.body = String(describing: "Yangi yutuq bilan tabriklayman") //
        
        let date = Date().addingTimeInterval (5)
        let dateComponents = Calendar.current.dateComponents ([.year, .month, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger (dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error { print("notification error: \(error)") } else { print("Notification scheduled successfully") }
        }
    }
}




extension ChatViewController {
    
    // Dismiss the keyboard
    @objc func hideKeyboard() {
        if isKeyboardShown {
            isKeyboardShown = false
            textFieldUpWhenKeyboardOpened()  // Reset the layout when the keyboard disappears
        }
    }

    
//    @objc private func buttonTapped() {
        //MARK: - Open AI
        //        guard let prompt = mainBackgroundView.resposeFromAILabel.text, !prompt.isEmpty else {
        ////               mainBackgroundView.text = "Please enter a prompt."
        //               return
        //           }
        //
        //        print(prompt)
        //        openAppButton.setTitle("Loadeing>>>>", for: .normal)
        //           openAIService.fetchResponse(for: prompt) { [weak self] response in
        //               DispatchQueue.main.async {
        //                   self?.mainBackgroundView.resposeFromAILabel.text = response ?? "No response received."
        //                   print(response)
        //        }
        //    }
//    }
    
    //MARK: - Hugging Face Service
//    func huggingFaceQA(question: String){
//        huggingFaceService.fetchResponse(for: question) { response in
//            if let response = response {
//                DispatchQueue.main.async {
//                    UserModel.shared.addMessage(id: "1", sender: .ai, content: response, messageType: .text)
//                    self.tableView.reloadData()
//                }
//            } else {
//                print("Failed to get a response from the model.")
//            }
//        }
//    }
}


//MARK: - YouTube Logic
extension ChatViewController{
    //MARK: - We use it when user wants to open You Tube. That moment we analyze and identify user's interest and return it
        func getUserInterest() -> String?{
            let userInterest = "Math topics"
            let encodedQuery = userInterest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return encodedQuery
        }
        
        
    //MARK: - Opens You Tube with given interest promt and opens You Tube with given research query
        func openApp(){
            if let query = getUserInterest(), let youtubeURL = URL(string: "youtube://results?search_query=\(query)") {
                if UIApplication.shared.canOpenURL(youtubeURL) {
                    UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
                } else if let browserURL = URL(string: "https://www.youtube.com/results?search_query=\(query)") {
                    // Fallback to browser if YouTube app is not installed
                    UIApplication.shared.open(browserURL, options: [:], completionHandler: nil)
                }
            }
        }
}

//MARK: - TableView extensions
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.shared.conversationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = UserModel.shared.conversationHistory[indexPath.row]
        let labelSize = calculateLabelSize(for: message.content, font: font, maxWidth: windowWidth - universalWidth(98))
        if message.sender == .ai {
            let cell = AIMessageCell(chatMessage: message.content, labelSize: labelSize, font: font)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = UserMessageCell(chatMessage: message.content, labelSize: labelSize, font: font)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = UserModel.shared.conversationHistory[indexPath.row]
        let labelSize = calculateLabelSize(for: message.content, font: font, maxWidth: windowWidth - universalWidth(98))
        if message.sender == .ai {
            guard labelSize.height > 52 else { return 65 }
            return labelSize.height + 45
        } else {
            return labelSize.height + 45
        }
    }
}


//MARK: - Gemini Integration
extension ChatViewController{
    func geminiGenerateResponse(userMessage: String) async{
        var response: String = ""
//        do {
//            let result = try await model.generateContent(userMessage)
//            response = result.text ?? "wrong data"
//            DispatchQueue.main.async {
//                UserModel.shared.addMessage(id: "1", sender: .ai, content: response, messageType: .text)
//                self.tableView.reloadData()
//            }
//        } catch { response = "something get wrong" }
    }
    
    func geminiGenerateQuiz(userQuizHistory: [String]) async -> String {
        var response: String = ""
        do {
//            let result = try await model.generateContent(
                """
                Based on the user's quiz history: \(userQuizHistory), generate a quiz (Overall 3 quiz questions not more) in the exact following JSON format: 
                
                
                
                **STRICT RULES:**
                - Only return the JSON data in the above format.
                - Do not include any additional words, spaces, explanations, or formatting.
                - Do not wrap the JSON with ```json or any other characters.
                - Quiz questions should be different every time.
                
                If you add anything extra, the app will crash. Only return valid JSON.
                """
//            )
//            response = result.text ?? "wrong data"
//            DispatchQueue.main.async {
//                self.quizView.questions = GeminiQuestionary.shared.jsonQuizReader(aiResponseData: response) ?? [] 
//            }
//            print(response)
            return "response"
        } catch {
            return "something get wrong"
        }
    }
}

