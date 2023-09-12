//
//  StoriesViewController.swift
//  contrast
//
//  Created by Александра Орлова on 10.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import AVFoundation

protocol StoriesDisplayLogic: AnyObject {
    func display(viewModel: Stories.Model.ViewModel.ViewModelType)
}

final class StoriesViewController: UIViewController {
    
    // MARK: - IBOutlets
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.setImage(R.image.clearPhotoIcon(), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium34
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private let promocodeButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .borderWhite)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let copyButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.copy(), for: .normal)
        return button
    }()
    
    private var playerView = PlayerView()
    private var videoPlayer: AVPlayer?
    
    // MARK: - External vars
    var interactor: StoriesBusinessLogic?
    var router: (NSObjectProtocol & StoriesRoutingLogic & StoriesDataPassing)?
    
    // MARK: - Internal vars
    private var stories: StoriesModel?
    private var promocode: String?
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        StoriesConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        StoriesConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - Display logic
extension StoriesViewController: StoriesDisplayLogic {
    
    func display(viewModel: Stories.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension StoriesViewController {
    private func setupView() {
        stories = router?.dataStore?.stories
        promocode = stories?.promocode
        setupSubviews()
        
        if stories?.mediaType == 0 {
            backgroundView = imageView
            if let link = stories?.mediaLink {
                imageView.kf.setImage(with: URL(string: link))
            }
            imageView.addBlackGradientLayerInBackground(frame: view.bounds, colors:[.clear, .black])
        } else {
            backgroundView = playerView
            playVideo()
        }
        
        view.addSubview(backgroundView)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        if promocode?.isEmpty == false {
            view.addSubview(promocodeButton)
            view.addSubview(copyButton)
            promocodeButton.setTitle(promocode, for: .normal)
        }
        
        setupConstraints()
    }
    
    private func setupSubviews() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        titleLabel.text = stories?.title
        descriptionLabel.text = stories?.description
    }
    
    private func playVideo() {
        if let link = stories?.mediaLink, let url = URL(string: link) {
            videoPlayer = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: videoPlayer)
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(playerLayer)
            
            videoPlayer?.playImmediately(atRate: 1)
            videoPlayer?.isMuted = true
            videoPlayer?.actionAtItemEnd = .none
            playerView.player = videoPlayer
        }
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(descriptionLabel.snp.top).inset(-19)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            
            if promocode?.isEmpty == true {
                $0.bottom.equalToSuperview().inset(32)
            } else {
                $0.bottom.equalTo(promocodeButton.snp.top).inset(-32)
            }
        }
        
        if promocode?.isEmpty == false {
            copyButton.snp.makeConstraints {
                $0.height.equalTo(46)
                $0.trailing.leading.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(35)
            }

            promocodeButton.snp.makeConstraints {
                $0.height.equalTo(46)
                $0.trailing.leading.equalToSuperview().inset(16)
                $0.bottom.equalTo(copyButton.snp.top).inset(-10)
            }
        }
    }
    
    @objc private func closeButtonTapped() {
        router?.routeBack()
    }
    
    @objc private func copyButtonTapped() {
        guard let promocode = stories?.promocode else { return }
        
        UIPasteboard.general.string = promocode
        let snackbar = CustomSnackbar(type: .copy)
        snackbar.showSnackbar()
    }
}

// MARK: - Public methods
extension StoriesViewController {
    
}
