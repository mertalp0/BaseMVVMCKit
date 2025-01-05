//
//  LoadingView.swift
//  BaseMVVMCKit
//
//  Created by mert alp on 16.12.2024.
//

import UIKit

final class LoadingView: UIView {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.isUserInteractionEnabled = true
        
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
}
