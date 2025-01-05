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
    public var loadingView: UIView?

    // MARK: - Initialization
    public init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - deinit
    deinit {
        print("\(type(of: self)) deinitialized")
        cancellables.removeAll()
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    open func showLoading() {
        
        guard let window = UIApplication.shared.windows.first else { return }

        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.loadingView = LoadingView(frame: window.bounds)
                self.loadingView?.alpha = 0
                self.view.addSubview(self.loadingView!)
                
                UIView.animate(withDuration: 0.3) {
                    self.loadingView?.alpha = 1
                }
            }
        }
    }
    
    open func hideLoading() {
        DispatchQueue.main.async {
          
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView?.alpha = 0
            }) { _ in
                self.loadingView?.removeFromSuperview()
                self.loadingView = nil
            }
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
    private func bindViewModel() {
        bindLoading()
        bindError()
    }
}

@available(iOS 13.0, *)
extension BaseViewController {
    private func bindLoading() {
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

@available(iOS 13.0, *)
extension BaseViewController {
    private func bindError() {
        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.showAlert(title: "Error", message: message)
                }
            }
            .store(in: &cancellables)
    }
}


