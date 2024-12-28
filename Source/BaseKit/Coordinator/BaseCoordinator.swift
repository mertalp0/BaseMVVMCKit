//
//  BaseCoordinator.swift
//  BaseMVVMCKit
//
//  Created by Mert Alp on 14.12.2024.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
}

open class BaseCoordinator: Coordinator {
    
    // MARK: - Properties
    public var childCoordinators: [Coordinator] = []
    public weak var navigationController: UINavigationController?
    
    // MARK: - Initialization
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Debugging
    deinit {
        print("\(type(of: self)) deinitialized.")
    }
    
    open func start() {
        // Start method must be implemented by subclass
    }
    
    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    public func push(_ viewController: UIViewController, animated: Bool = true) {
        viewController.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
}
 
