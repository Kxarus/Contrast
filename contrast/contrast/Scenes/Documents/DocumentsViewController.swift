//
//  DocumentsViewController.swift
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
import PDFKit

protocol DocumentsDisplayLogic: AnyObject {
    func display(viewModel: Documents.Model.ViewModel.ViewModelType)
}

final class DocumentsViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let pdfView = PDFView()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.share(), for: .normal)
        return button
    }()
    
    // MARK: - External vars
    var interactor: DocumentsBusinessLogic?
    var router: (NSObjectProtocol & DocumentsRoutingLogic & DocumentsDataPassing)?
    
    // MARK: - Internal vars
    private var data = Data()
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        DocumentsConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DocumentsConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension DocumentsViewController: DocumentsDisplayLogic {
    
    func display(viewModel: Documents.Model.ViewModel.ViewModelType) {
        switch viewModel {
        case .presentNameScreen(let nameScreen):
            setupNavBar(withTitle: R.string.localizable.receipt(), and: nameScreen, dismiss: true)
        case .presentUrlReceipt(let url):
            guard let url = URL(string: url.encodeUrl) else { return }
            fetchPDF(url: url)
        }
    }
}

// MARK: - Private methods
private extension DocumentsViewController {
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(pdfView)
        view.addSubview(shareButton)
        
        shareButton.addTarget(self, action: #selector(tapShareButton(sender:)), for: .touchUpInside)
        setPDFView()
        
        interactor?.make(request: .fetchNameScreen)
        interactor?.make(request: .fetchUrlReceipt)
        
        setupConstraints()
    }
    
    private func setPDFView() {
        DispatchQueue.main.async {
            self.pdfView.maxScaleFactor = 3
            self.pdfView.minScaleFactor = self.pdfView.scaleFactorForSizeToFit
            self.pdfView.autoScales = true
            self.pdfView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.pdfView.backgroundColor = .gray
        }
    }
    
    private func fetchPDF(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url), let document = PDFDocument(data: data) {
                self.data = data
                DispatchQueue.main.async {
                    self.pdfView.document = document
                }
            }
        }
    }
    
    private func setupConstraints() {
        shareButton.snp.makeConstraints ({
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(24)
        })
        
        pdfView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(shareButton.snp.top).offset(-13)
        }
    }
    
    @objc private func tapShareButton(sender: UIButton) {
        let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)

        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading

        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList
        ]

        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - Public methods
extension DocumentsViewController {
    
}

