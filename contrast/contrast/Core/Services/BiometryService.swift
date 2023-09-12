//
//  BiometryService.swift
//  contrast
//
//  Created by Александра Орлова on 29.06.2023.
//

import Foundation
import LocalAuthentication

enum BiometryErrorType {
    case biometryChanged
    case unknown
}

protocol BiometryServiceDelegate {
    func routeToMain()
    func showError(_ error: BiometryErrorType)
}

final class BiometryService {
    var delegate: BiometryServiceDelegate?
    
    func setBiometry() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: R.string.localizable.authenticateFaceTouchId()) { [delegate] success, authenticationError in
                if success {
                    KeychainService.standard.save(context.evaluatedPolicyDomainState, service: Constants.biometryService, account: Constants.biometryKey)
                    UserDefaultsWorker.saveBiometryChangeNeed(false)
                    delegate?.routeToMain()
                }
            }
        } else {
            delegate?.routeToMain()
        }
    }
    
    func enterWithBiometry() {
        let context = LAContext()
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
            delegate?.showError(.unknown)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: R.string.localizable.authenticateFaceTouchId()) { [delegate] success, _ in
            DispatchQueue.main.async {
                guard success else { return }
                
                let currentBiometry = KeychainService.standard.read(service: Constants.biometryService, account: Constants.biometryKey)
                let newBiometry = context.evaluatedPolicyDomainState
                
                guard currentBiometry == nil || currentBiometry == newBiometry else {
                    UserDefaultsWorker.saveBiometryChangeNeed(true)
                    delegate?.showError(.biometryChanged)
                    return
                }
                
                if currentBiometry == nil {
                    KeychainService.standard.save(newBiometry, service: Constants.biometryService, account: Constants.biometryKey)
                }
                
                delegate?.routeToMain()
            }
        }
    }
}
