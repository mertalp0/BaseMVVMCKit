//
//  BaseViewController.swift
//  BaseMVVMCKit
//
//  Created by mert alp on 13.12.2024.
//


import UIKit

open class BaseViewController<VM: BaseViewModel>: UIViewController {
    public let viewModel: VM

    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        viewModel.start()
    }

    open func setupController() {
        view.backgroundColor = .white
    }
}