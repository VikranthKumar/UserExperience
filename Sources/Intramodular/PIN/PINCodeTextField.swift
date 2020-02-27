//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

public struct PINCodeTextField: CocoaView, UIViewRepresentable {
    public typealias UIViewType = UIPINCodeTextField
    
    @Binding private var text: String
    
    fileprivate var placeholder: String
    fileprivate var onEditingChanged: (Bool) -> Void
    fileprivate var onCommit: () -> Void
    
    fileprivate var isFirstResponder: Bool?

    fileprivate var autocapitalization: UITextAutocapitalizationType?
    fileprivate var characterLimit: Int = 4
    fileprivate var font: UIFont?
    fileprivate var foregroundColor: UIColor?
    fileprivate var keyboardType: UIKeyboardType = .default
    fileprivate var textContentType: UITextContentType?
    
    public init<S: StringProtocol>(
        _ title: S,
        text: Binding<String>,
        onEditingChanged: @escaping (Bool) -> Void = { _ in },
        onCommit: @escaping () -> Void = { }
    ) {
        self.placeholder = String(title)
        self._text = text
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }
    
    public func makeUIView(context: Context) -> UIViewType {
        let uiView = UIViewType()
        
        uiView.configure(with: self)
        uiView.delegate = context.coordinator
        
        return uiView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.configure(with: self)
        
        if let isFirstResponder = isFirstResponder, uiView.window != nil {
            if isFirstResponder && !uiView.isFirstResponder {
                uiView.becomeFirstResponder()
            } else if uiView.isFirstResponder {
                uiView.resignFirstResponder()
            }
        }
    }
    
    public class Coordinator: NSObject, UIPINCodeTextFieldDelegate {
        var base: PINCodeTextField
        
        init(base: PINCodeTextField) {
            self.base = base
        }
        
        public func textFieldShouldBeginEditing(_ textField: UIPINCodeTextField) -> Bool {
            return true
        }
        
        public func textFieldDidBeginEditing(_ textField: UIPINCodeTextField) {
            base.onEditingChanged(true)
        }
        
        public func textFieldValueChanged(_ textField: UIPINCodeTextField) {
            base.text = textField.text ?? ""
        }
        
        public func textFieldShouldEndEditing(_ textField: UIPINCodeTextField) -> Bool {
            return true
        }
        
        public func textFieldDidEndEditing(_ textField: UIPINCodeTextField) {
            base.onEditingChanged(false)
            base.onCommit()
        }
        
        public func textFieldShouldReturn(_ textField: UIPINCodeTextField) -> Bool {
            return true
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        .init(base: self)
    }
}

extension PINCodeTextField {
    public func isFirstResponder(_ isFirstResponder: Bool) -> Self {
        then({ $0.isFirstResponder = isFirstResponder })
    }
}

extension PINCodeTextField {
    public func characterLimit(_ characterLimit: Int) -> Self {
        then({ $0.characterLimit = characterLimit })
    }
    
    public func font(_ font: UIFont) -> Self {
        then({ $0.font = font })
    }
    
    public func foregroundColor(_ font: UIColor) -> Self {
        then({ $0.foregroundColor = foregroundColor })
    }
    
    public func placeholder(_ placeholder: String) -> Self {
        then({ $0.placeholder = placeholder })
    }
    
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        then({ $0.keyboardType = keyboardType })
    }
    
    public func textContentType(_ keyboardType: UITextContentType) -> Self {
        then({ $0.textContentType = textContentType })
    }
}

extension UIPINCodeTextField {
    public func configure(with view: PINCodeTextField) {
        characterLimit = view.characterLimit
        
        if let _font = view.font {
            font = _font
        }
        
        if let _foregroundColor = view.foregroundColor {
            textColor = _foregroundColor
        }
        
        keyboardType = view.keyboardType
        placeholderText = view.placeholder
        
        if let _textContentType = view.textContentType {
            textContentType = _textContentType
        }
    }
}

#endif
