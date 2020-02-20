//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

public struct SystemButton<Label: View>: View {
    private var actions: Actions
    private let label: Label
    
    @Environment(\.feedbackGenerator) private var feedbackGenerator
    @Environment(\.weight) var weight
    
    public init(action: @escaping () -> (), @ViewBuilder label: () -> Label) {
        self.actions = .init(initial: action)
        self.label = label()
    }
    
    public var body: some View {
        Button(action: trigger, label: { label })
    }
    
    private func trigger() {
        if let impactStyle = FeedbackGenerator.ImpactFeedbackStyle(for: weight) {
            feedbackGenerator.generate(.impact(impactStyle))
        }
        
        actions.perform()
    }
}

// MARK: - Protocol Implementations -

extension SystemButton: ActionTriggerView {
    public func onPrimaryTrigger(perform action: @escaping () -> ()) -> Self {
        then({ $0.actions.insert(action) })
    }
}
