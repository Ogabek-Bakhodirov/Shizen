//
//  EditInfoViewController.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 09/03/25.
//

import UIKit

class EditInfoViewController: UIViewControllerExtensions {
    
    
    let nameTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Ismningizni kiriting")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let surnameTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Familiyangizni kiriting")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let numberTextField: CustomTextFieldForRegistration = {
        let textField = CustomTextFieldForRegistration(placeHolder: "Telefon raqamingizni kiriting")
        textField.textFieldView.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Saqlash", for: .normal)
        button.addTarget(EditInfoViewController.self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = .colorBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        enableBackButton(ViewController: self)
        setupSubviews()
    }
    
    private func setupSubviews(){

        
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(numberTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([

            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: universalHeight(170)),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(15)),
            nameTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            nameTextField.heightAnchor.constraint(equalToConstant: universalHeight(60)),
            
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: universalHeight(20)),
            surnameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(15)),
            surnameTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            surnameTextField.heightAnchor.constraint(equalToConstant: universalHeight(60)),
            
            numberTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: universalHeight(20)),
            numberTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: universalWidth(15)),
            numberTextField.widthAnchor.constraint(equalToConstant: windowWidth - universalWidth(30)),
            numberTextField.heightAnchor.constraint(equalToConstant: universalHeight(60)),
            
            saveButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: universalHeight(20)),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: universalWidth(-15)),
            saveButton.widthAnchor.constraint(equalToConstant: universalWidth(100)),
            saveButton.heightAnchor.constraint(equalToConstant: universalHeight(40)),
             
        ])
    }
    
    @objc func saveButtonTapped(){
        UserModel.shared.changeName(name: nameTextField.textFieldView.text ?? "")
        UserModel.shared.changeSurname(surname: surnameTextField.textFieldView.text ?? "")
        UserModel.shared.changeNumber(number: numberTextField.textFieldView.text ?? "")
        NotificationCenter.default.post(name: .userInfoUpdated, object: nil)
        self.dismiss(animated: true)
    }
}
