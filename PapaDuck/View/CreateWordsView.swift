//
//  CreateWordsView.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//

import Foundation
import UIKit
import SnapKit
class CreateWordsView: UIView{
    let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 44))
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 44))
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "단어장 추가"
        label.font = FontNames.mainFont.font()
        label.textAlignment = .center
        return label
    }()
    let wordsBookLabel: UILabel = {
        let label = UILabel()
        label.text = "단어장 이름"
        label.font = FontNames.subFont2.font()
        label.textColor = .lightGray
        return label
    }()
    let wordsBookNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "단어장 이름을 입력하세요"
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        return label
    }()
    let explanationLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = FontNames.subFont2.font()
        label.textColor = .lightGray
        return label
    }()
    let explanationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "단어장에 대한 설명을 적어주세요"
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontNames.subFont2.font()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 238/255, green: 223/255, blue: 88/255, alpha: 1.0)
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        [titleLabel, wordsBookLabel, wordsBookNameTextField, explanationLabel, explanationTextField, saveButton, errorLabel, deleteButton].forEach {
            addSubview($0)
        }
        wordsBookNameTextField.leftView = paddingView1
        wordsBookNameTextField.leftViewMode = .always
        explanationTextField.leftView = paddingView2
        explanationTextField.leftViewMode = .always
        deleteButton.isHidden = true
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.height.equalTo(50)
        }
        wordsBookLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(80)
        }
        wordsBookNameTextField.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.top.equalTo(wordsBookLabel.snp.bottom).offset(15)
            $0.height.equalTo(60)
        }
        explanationLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.top.equalTo(wordsBookNameTextField.snp.bottom).offset(50)
        }
        explanationTextField.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.top.equalTo(explanationLabel.snp.bottom).offset(15)
            $0.height.equalTo(60)
        }
        deleteButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.height.equalTo(60)
        }
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(deleteButton.snp.top).offset(-10)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            $0.height.equalTo(60)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(wordsBookNameTextField.snp.bottom).offset(5)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
