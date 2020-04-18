//
//  Copyright (c) Vatsal Manot
//

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUIX
import UIKit

public protocol UIPINCodeTextFieldDelegate: class {
    func textFieldShouldBeginEditing(_ textField: UIPINCodeTextField) -> Bool
    func textFieldDidBeginEditing(_ textField: UIPINCodeTextField)
    func textFieldValueChanged(_ textField: UIPINCodeTextField)
    func textFieldShouldEndEditing(_ textField: UIPINCodeTextField) -> Bool
    func textFieldDidEndEditing(_ textField: UIPINCodeTextField)
    func textFieldShouldReturn(_ textField: UIPINCodeTextField) -> Bool
}

public extension UIPINCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PINCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PINCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PINCodeTextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: PINCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: PINCodeTextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: PINCodeTextField) -> Bool {
        return true
    }
}

#endif
