//
//  BaseCoordinator.swift
//  BaseMVVMCKit
//
//  Created by Mert Alp on 14.12.2024.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parentNavigationController: UINavigationController { get set }
    func start()
}

open class BaseCoordinator: Coordinator {
    
    // MARK: - Properties
    public var childCoordinators: [Coordinator] = []
    public var parentNavigationController: UINavigationController

    // MARK: - Initialization
    public init(navigationController: UINavigationController) {
        self.parentNavigationController = navigationController
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
           parentNavigationController.pushViewController(viewController, animated: animated)
       }
    
}
