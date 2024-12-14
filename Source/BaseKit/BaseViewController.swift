//
//  BaseViewController.swift
//  BaseMVVMCKit
//
//  Created by Mert Alp on 13.12.2024.
//

import UIKit
import Combine

@available(iOS 13.0, *)
open class BaseViewController<CoordinatorType: BaseCoordinator, ViewModelType: BaseViewModel>: UIViewController {
    
    // MARK: - Properties
    public var coordinator: CoordinatorType?
    public var viewModel: ViewModelType
    private var cancellables = Set<AnyCancellable>()
    private var loadingView: UIView?

    // MARK: - Initialization
    public init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        bindViewModel()
    }

    // MARK: - Setup
    open func setupController() {
        view.backgroundColor = .white
    }
}

// MARK: - Loading Management
@available(iOS 13.0, *)
extension BaseViewController {
    
    func showLoading() {
        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.loadingView = UIView(frame: self.view.bounds)
                self.loadingView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                activityIndicator.color = .white
                activityIndicator.startAnimating()
                self.loadingView?.addSubview(activityIndicator)
                self.view.addSubview(self.loadingView!)
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }
}

// MARK: - Alerts
@available(iOS 13.0, *)
extension BaseViewController {
    
    func showAlert(title: String, message: String, actionTitle: String = "OK", handler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                handler?()
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        confirmHandler: (() -> Void)? = nil,
        cancelHandler: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmHandler?()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelHandler?()
            }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Bind ViewModel
@available(iOS 13.0, *)
extension BaseViewController {
    func bindViewModel() {
        // Bind error messages to alerts
        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.showAlert(title: "Error", message: message)
                }
            }
            .store(in: &cancellables)

        // Bind loading state to loading view
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.showLoading()
                } else {
                    self?.hideLoading()
                }
            }
            .store(in: &cancellables)
    }
}
