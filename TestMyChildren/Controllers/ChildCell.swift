//
//  ChildCell.swift
//  TestMyChildren
//
//  Created by Дмитрий Сечкаренко on 25.10.2022.
//

import UIKit

class ChildCell: UITableViewCell {
    static let identifier = "id"

    private let nameTextFieldCall = UITextField(placeholder: "Имя")
    private let yearsTextFieldCall = UITextField(placeholder: "Возраст", keyboardType: .numberPad)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(nameTextFieldCall)
        contentView.addSubview(yearsTextFieldCall)

        NSLayoutConstraint.activate([
            nameTextFieldCall.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameTextFieldCall.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextFieldCall.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            nameTextFieldCall.widthAnchor.constraint(equalToConstant: 150),

            yearsTextFieldCall.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            yearsTextFieldCall.leadingAnchor.constraint(equalTo: nameTextFieldCall.trailingAnchor, constant: 30),
            yearsTextFieldCall.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            yearsTextFieldCall.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
}

extension ChildCell {
    func configure(name: String, years: String) {
        nameTextFieldCall.text = name
        yearsTextFieldCall.text = years
    }
}
