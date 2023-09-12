//
//  TimeSlotsViewController.swift
//  contrast
//
//  Created by Roman Kiruxin on 05.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import PanModal

protocol TimeSlotsDisplayLogic: AnyObject {
    func display(viewModel: TimeSlots.Model.ViewModel.ViewModelType)
}

final class TimeSlotsViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let dragView: UIView = {
        let view = UIView()
        view.backgroundColor = .textLight
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let titleLabel: UIView = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = .textLight
        label.text = R.string.localizable.timeSlotsTitle()
        label.textAlignment = .center
        return label
    }()
    
    private let timeSlotsView: TimeSlotsView = {
        let view = TimeSlotsView()
        return view
    }()

    private let additionalButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitle(R.string.localizable.close(), for: .normal)
        return button
    }()
    
    private let mainButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        button.isEnabledButton = false
        return button
    }()
    
    // MARK: - External vars
    var interactor: TimeSlotsBusinessLogic?
    var router: (NSObjectProtocol & TimeSlotsRoutingLogic & TimeSlotsDataPassing)?
    
    // MARK: - Internal vars
    private var intervals: [TimeIntervalModel] = []
    private var isSelectedDate = false
    private var isSelectedTime = false
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TimeSlotsConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        TimeSlotsConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension TimeSlotsViewController: TimeSlotsDisplayLogic {
    
    func display(viewModel: TimeSlots.Model.ViewModel.ViewModelType) {
        switch viewModel {
        case .intervals(let viewModel):
            self.intervals = viewModel
            timeSlotsView.setupView(intervals: intervals)
        }
    }
}

//MARK: - PanModalPresentable
extension TimeSlotsViewController: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
}

// MARK: - Private methods
private extension TimeSlotsViewController {
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(dragView)
        view.addSubview(titleLabel)
        view.addSubview(timeSlotsView)
        view.addSubview(additionalButton)
        view.addSubview(mainButton)
        
        timeSlotsView.delegate = self
        
        additionalButton.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        
        interactor?.make(request: .fetchIntervals)
        
        setupConstraints()
    }
    
    private func mainButtonActivate() {
        if isSelectedDate && isSelectedTime {
            mainButton.isEnabledButton = true
        }
    }
    
    private func setupConstraints() {
        dragView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dragView.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        timeSlotsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(126)
        }
        
        additionalButton.snp.makeConstraints {
            $0.top.equalTo(timeSlotsView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        mainButton.snp.makeConstraints {
            $0.top.equalTo(additionalButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(49)
            $0.height.equalTo(46)
        }
    }
    
    @objc private func dismissScreen() {
        router?.dismissScreen()
    }
}

// MARK: - TimeSlotsViewDelegate
extension TimeSlotsViewController: TimeSlotsViewDelegate {
    func dateSelection(date: TimeIntervalModel) {
        isSelectedDate = true
        mainButtonActivate()
    }
    
    func timeSelection(time: IntervalModel) {
        isSelectedTime = true
        mainButtonActivate()
    }
}
