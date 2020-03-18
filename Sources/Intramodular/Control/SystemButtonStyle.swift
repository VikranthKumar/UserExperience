//
// Copyright (c) Vatsal Manot
//

import SwiftUIX

private struct SystemButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            Spacer()
            configuration.label.font(.headline)
            Spacer()
        }
        .frame(minHeight: 44, idealHeight: 52)
        .clipShape(SystemIconShape())
        .contentShape(SystemIconShape())
    }
}

extension View {
    public func systemButtonStyle() -> some View {
        buttonStyle(SystemButtonStyle())
            .clipShape(SystemIconShape())
            .contentShape(SystemIconShape())
    }
}
