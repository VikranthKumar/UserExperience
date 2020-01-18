//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct SystemButton<Label: View>: View {
    private let action: () -> ()
    private let label: Label
    
    private var feedbackGeneratorAndStyle: (FeedbackGenerator, FeedbackGenerator.FeedbackStyle)? = nil
    
    @Environment(\.weight) var weight
    
    public init(action: @escaping () -> (), @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
        
        feedbackGeneratorAndStyle = FeedbackGenerator.ImpactFeedbackStyle(for: weight).map {
            (.init(), .impact($0))
        }
    }
    
    public var body: some View {
        Button(action: trigger, label: { label })
    }
    
    private func trigger() {
        feedbackGeneratorAndStyle.map({ $0.0.generate($0.1) })
        
        action()
    }
}
