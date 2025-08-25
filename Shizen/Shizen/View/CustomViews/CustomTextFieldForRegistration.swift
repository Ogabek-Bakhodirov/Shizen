//
//  CustomTextFieldForRegistration.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 03/02/25.
//

import UIKit

class CustomTextFieldForRegistration: UIView{
    
    private var showEyeButton: Bool = false
    
    private var placeHolder: String = ""
        
    var isKeyboardShown = false
        
    var onKeyboardTapped: ((Bool) -> Void)?
    
    var sentMessage: ((UserModel) -> Void)?
        
    private lazy var mainBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var bottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        return view
    }()
    
    lazy var textFieldView: UITextField = {
        let view = UITextField()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let textFieldTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(isKeyboardTapped))
        textFieldTap.cancelsTouchesInView = false
//        view.isSecureTextEntry = /*closedEye*/
        view.textColor = .black
        view.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3411764706, green: 0.3882352941, blue: 0.4235294118, alpha: 1) ])
        view.placeholder = placeHolder
        view.addGestureRecognizer(textFieldTap)
        return view
    }()
    
    lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = #colorLiteral(red: 0.3411764706, green: 0.3882352941, blue: 0.4235294118, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(eyeTapped) , for: .touchUpInside)
        return button
    }()
    
    init(placeHolder: String, _ frame: CGRect = .zero, showEyeButton: Bool = false) {
        super.init(frame: frame)
        self.placeHolder = placeHolder
        self.showEyeButton = showEyeButton
        setupSubviews()
    }
    
    func setupSubviews(){
        
        self.addSubview(mainBackground)
        mainBackground.addSubview(textFieldView)
        mainBackground.addSubview(bottomLineView)
        
        
        
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: self.topAnchor),
            mainBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainBackground.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainBackground.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            textFieldView.topAnchor.constraint(equalTo: mainBackground.topAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: mainBackground.bottomAnchor),
            textFieldView.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: 15),
            textFieldView.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: -15),
            
            bottomLineView.bottomAnchor.constraint(equalTo: mainBackground.bottomAnchor),
            bottomLineView.leftAnchor.constraint(equalTo: mainBackground.leftAnchor, constant: 0),
            bottomLineView.rightAnchor.constraint(equalTo: mainBackground.rightAnchor, constant: 0),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        setUpEyeButton()
    }
    
    func setUpEyeButton(){
        if showEyeButton {
            mainBackground.addSubview(eyeButton)
        }
        
        if showEyeButton {
            NSLayoutConstraint.activate([
                eyeButton.topAnchor.constraint(equalTo: mainBackground.topAnchor, constant: -((mainBackground.frame.height / 2) - universalHeight(25))),
                eyeButton.rightAnchor.constraint(equalTo: mainBackground.rightAnchor),
                eyeButton.widthAnchor.constraint(equalToConstant: 18),
                eyeButton.heightAnchor.constraint(equalToConstant: 18),
            ])
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    @objc func isKeyboardTapped(){
        textFieldView.becomeFirstResponder()
        isKeyboardShown = true
        onKeyboardTapped?(isKeyboardShown)
    }

    
    @objc func buttonTapped(){
//        if textFieldView.text != "" {
//            USER.addMessage(id: "1", sender: .user, content: (textFieldView.text ?? ""), messageType: .text)
//            sentMessage?(USER)
//            textFieldView.text = ""
//        }
    }
}
