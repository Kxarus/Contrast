//
//  LinkedCardsViewController.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LinkedCardsDisplayLogic: AnyObject {
    func display(viewModel: LinkedCards.Model.ViewModel.ViewModelType)
}

final class LinkedCardsViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let linkCardButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.linkCard(), for: .normal)
        return button
    }()
    
    // MARK: - External vars
    var interactor: LinkedCardsBusinessLogic?
    var router: (NSObjectProtocol & LinkedCardsRoutingLogic & LinkedCardsDataPassing)?
    
    // MARK: - Internal vars
    private var cards = [CardModel]()
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LinkedCardsConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LinkedCardsConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Display logic
extension LinkedCardsViewController: LinkedCardsDisplayLogic {
    
    func display(viewModel: LinkedCards.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension LinkedCardsViewController {
    private func setupView() {
        guard let cardsModel = router?.dataStore?.cards else { return }
        
        cards = cardsModel
        view.backgroundColor = UIColor.mainBackgroundColor
        setupNavBar(withTitle: R.string.localizable.linkedCards())
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.color.mainBackgroundColor()
        tableView.register(cellTypes: [LinkedCardTableViewCell.self])
        view.addSubview(tableView)
        view.addSubview(linkCardButton)
        linkCardButton.addTarget(self, action: #selector(linkCardButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        linkCardButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func linkCardButtonTapped() {
        guard let model = router?.dataStore?.orderModel else { return }
        
        router?.routeToLinkNewCard(withOrder: model)
    }
}

// MARK: - Public methods
extension LinkedCardsViewController {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LinkedCardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: LinkedCardTableViewCell.self)
        cell.setupCell(model: cards[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.dataStore?.orderModel?.card = cards[indexPath.row]
        guard let model = router?.dataStore?.orderModel else { return }
        
        router?.routeToPayConfirmation(withOrder: model)
    }
}


