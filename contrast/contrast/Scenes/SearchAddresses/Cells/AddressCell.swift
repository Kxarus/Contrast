//
//  AddressCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import UIKit

final class AddressCell: UITableViewCell, Reusable {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackgroundColor
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular15
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension AddressCell {
    private func setupView() {
        backgroundColor = .mainBackgroundColor
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(containerView).inset(8)
            $0.leading.trailing.equalTo(containerView).inset(16)
        }
    }
}

//MARK: - Public methods
extension AddressCell {
    func setupCell(address: String) {
        titleLabel.text = address
    }
}


