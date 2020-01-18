//
// Copyright (c) Vatsal Manot
//

import Merge
import LocalAuthentication
import SwiftUIX

public final class LocalAuthenticator {
    public enum AuthenticationType {
        case biometric
        case any
    }
    
    public class func authenticate(with type: AuthenticationType = .any) -> Future<Void, LAError> {
        Future { attemptToFulfill in
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
            
            var error: NSError?
            let reasonString = "To access the secure data"
            
            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString) { success, evaluateError in
                    if success {
                        attemptToFulfill(.success(()))
                    } else {
                        guard let error = evaluateError else {
                            return
                        }
                        
                        attemptToFulfill(.failure(LAError(_nsError: error as NSError)))
                    }
                }
            } else {
                guard let error = error else {
                    return
                }
                
                attemptToFulfill(.failure(LAError(_nsError: error)))
            }
        }
    }
}

// MARK: - Helpers -

extension LAError: Error {
    
}

extension LAError: CustomStringConvertible {
    public var description: String {
        switch code.rawValue {
            case LAError.authenticationFailed.rawValue:
                return "The user failed to provide valid credentials"
            case LAError.appCancel.rawValue:
                return "Authentication was cancelled by application"
            case LAError.invalidContext.rawValue:
                return "The context is invalid"
            case LAError.notInteractive.rawValue:
                return "Not interactive"
            case LAError.passcodeNotSet.rawValue:
                return "Passcode is not set on the device"
            case LAError.systemCancel.rawValue:
                return "Authentication was cancelled by the system"
            case LAError.userCancel.rawValue:
                return "The user did cancel"
            case LAError.userFallback.rawValue:
                return "The user chose to use the fallback"
            case LAError.biometryNotAvailable.rawValue:
                return "Authentication could not start because the device does not support biometric authentication."
            case LAError.biometryLockout.rawValue:
                return "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
            case LAError.biometryNotEnrolled.rawValue:
                return "Authentication could not start because the user has not enrolled in biometric authentication."
            default:
                return "Unknown local authentication error."
        }
    }
}
