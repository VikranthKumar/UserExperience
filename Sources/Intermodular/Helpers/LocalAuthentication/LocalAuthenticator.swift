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
