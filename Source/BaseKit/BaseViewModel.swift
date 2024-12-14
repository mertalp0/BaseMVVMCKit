//
//  BaseViewModel.swift
//  BaseMVVMCKit
//
//  Created by mert alp on 13.12.2024.
//


import Foundation

@available(iOS 13.0, *)
open class BaseViewModel {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    //MARK: - Initializationz
    public init() {}
    
    //MARK: - Loading Managment
    open func startLoading(){
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    
    open func stopLoading(){
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    //MARK: - Error Handling
    open func handleError(_ error: Error){
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
    
    open func handleError(message : String){
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
}
