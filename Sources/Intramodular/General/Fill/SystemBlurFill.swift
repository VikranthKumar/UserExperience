//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import SwiftUIX
import UIKit

public struct SystemBlurFill: UIViewRepresentable {
    public let style: UIBlurEffect.Style
    
    public func makeUIView(context: Context) -> UIView {
        let uiView = UIView(frame: .zero)
        
        uiView.configure(with: style)
        
        return uiView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        uiView.configure(with: style)
    }
}

extension UIView {
    fileprivate func configure(with style: UIBlurEffect.Style) {
        subviews.first?.removeFromSuperview()
        
        backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: heightAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}

#endif
