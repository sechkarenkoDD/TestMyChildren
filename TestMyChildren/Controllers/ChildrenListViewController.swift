//
//  MyChildren.swift
//  TestMyChildren
//
//  Created by Дмитрий Сечкаренко on 25.10.2022.
//

import UIKit

class ChildrenListViewController: UIViewController {
    
    private let personalDateLabel = UILabel(text: "Персональные данные")
    
    private let nameTextField = UITextField(placeholder: "Имя")
    private let yearsTextField = UITextField(placeholder: "Возраст")
    private let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .actionSheet)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }()
    
    private let childrenLabel = UILabel(text: "Дети (макс.5)")
    
    private let addChildrenButton = UIButton(title: "Добавить ребенка", withImage: true)
    private let clearButton = UIButton(title: "Очистить", backgroundColor: .red, foregroundColor: .red)

    private let tableView = UITableView()
    private let viewModel: ChildViewModelProtocol

    init(viewModel: ChildViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSubViews()
        setupTableView()
        setupTargets()
        setupAlert()
    }
    
    private func setupSubViews() {
        view.addSubview(personalDateLabel)
        view.addSubview(nameTextField)
        view.addSubview(yearsTextField)
        view.addSubview(stackView)
        view.addSubview(clearButton)
        
        stackView.addArrangedSubview(childrenLabel)
        stackView.addArrangedSubview(addChildrenButton)
        
        NSLayoutConstraint.activate([
            personalDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            personalDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            personalDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: personalDateLabel.topAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),

            yearsTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            yearsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            stackView.topAnchor.constraint(equalTo: yearsTextField.bottomAnchor,constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -70),
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50)
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 70
        tableView.allowsSelection = false

        tableView.register(ChildCell.self, forCellReuseIdentifier: ChildCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupTargets() {
        addChildrenButton.addTarget(self, action: #selector(addNewChild), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
    }
    
    private func setupAlert() {
        alert.addAction(UIAlertAction(title: "Remove All", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.viewModel.removeAll()
            self.nameTextField.text = ""
            self.yearsTextField.text = ""
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.addChildrenButton.isHidden = false
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    }
    
    @objc private func addNewChild() {
        let child = Children(
            name: "",
            years: ""
        )
        viewModel.addChild(child: child)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.viewModel.children.count == 5 {
                self.addChildrenButton.isHidden = true
            } else {
                self.addChildrenButton.isHidden = false
            }
        }
    }

    @objc private func clearAll() {
        present(alert, animated: true, completion: nil)
    }
}

extension ChildrenListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.children.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.identifier) as! ChildCell
        let name = viewModel.children[indexPath.row].name
        let years = viewModel.children[indexPath.row].years
        cell.configure(name: name, years: years)
        return cell
    }
}

extension ChildrenListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DispatchQueue.main.async {
                self.viewModel.removeChild(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if self.viewModel.children.count == 5 {
                    self.addChildrenButton.isHidden = true
                } else {
                    self.addChildrenButton.isHidden = false
                }
            }
        }
    }
}
