//
// Copyright (c) Vatsal Manot
//

import API
import Merge
import SwiftUIX

public enum RequestButtonState {
    case inactive
    case active
    case success
    case failure
}

public struct RequestButton<R: Request, Label: View>: View {
    private let request: R
    private let completion: (R.Result) -> ()
    private let label: (RequestButtonState) -> Label

    private var validateRequestResult: (R.Result) -> Bool = { _ in true }
    private var canRetry: Bool = true
    private var disableWhileActive: Bool = true
    private var onPress: () -> () = { }

    @State private var didTry: Bool = false
    @State private var state: RequestButtonState = .inactive
    @State private var cancellable: AnyCancellable?
    @State private var runOnAppear: Bool = false
    
    @EnvironmentObjectOrState private var session: AnyRequestSession<R>
    
    public var body: some View {
        Button(action: run) {
            label(state)
        }
        .disabled(disableWhileActive ? state == .active : false)
        .onAppear {
            if self.runOnAppear {
                self.run()
            }
        }
    }
    
    func trigger() {
        if !canRetry && didTry {
            return
        }
        
        cancel()
        run()
    }
    
    func run() {
        onPress()
        
        cancellable = session
            .task(with: request)
            .receiveOnMainQueue()
            .sinkResult(complete)
        
        cancellable?.store(in: session.cancellables)
        
        state = .active
    }
    
    func cancel() {
        guard cancellable != nil else {
            return
        }
        
        cancellable?.cancel()
        cancellable = nil
        
        state = .inactive
    }
    
    func complete(_ result: R.Result) {
        didTry = true
        
        completion(result)
                
        switch result {
            case .success:
                state = .success
            case .failure:
                state = .failure
        }
        
        if !validateRequestResult(result) {
            state = .failure
        }
    }
}

extension RequestButton {
    public init(
        request: R,
        session: AnyRequestSession<R>,
        completion: @escaping (R.Result) -> () = { _ in },
        @ViewBuilder label: @escaping (RequestButtonState) -> Label
    ) {
        self.request = request
        self._session = .init(wrappedValue: session)
        self.completion = completion
        self.label = label
    }
    
    public init(
        request: R,
        session: AnyRequestSession<R>,
        completion: @escaping (R.Result) -> () = { _ in },
        @ViewBuilder label: () -> Label
    ) {
        let _label = label()
        
        self.request = request
        self._session = .init(wrappedValue: session)
        self.completion = completion
        self.label = { _ in _label }
    }
    
    public init(
        request: R,
        completion: @escaping (R.Result) -> () = { _ in },
        @ViewBuilder label: @escaping (RequestButtonState) -> Label
    ) {
        self.request = request
        self.completion = completion
        self.label = label
    }
    
    public init(
        request: R,
        completion: @escaping (R.Result) -> () = { _ in },
        @ViewBuilder label: () -> Label
    ) {
        let _label = label()
        
        self.request = request
        self.completion = completion
        self.label = { _ in _label }
    }
    
    public init(
        request: R,
        action: @escaping () -> (),
        @ViewBuilder label: @escaping (RequestButtonState) -> Label
    ) {
        self.request = request
        self.completion = { _ in action() }
        self.label = label
    }
    
    public init(
        request: R,
        action: @escaping () -> (),
        @ViewBuilder label: () -> Label
    ) {
        let _label = label()
        
        self.request = request
        self.completion = { _ in action() }
        self.label = { _ in _label }
    }
}

extension RequestButton {
    public func canRetry(_ canRetry: Bool) -> Self {
        then({ $0.canRetry = canRetry })
    }
    
    public func disableWhileActive(_ disableWhileActive: Bool) -> Self {
        then({ $0.disableWhileActive = disableWhileActive })
    }
    
    public func onPress(_ onPress: @escaping () -> ()) -> Self {
        then({ $0.onPress = onPress })
    }
    
    public func runOnAppear(_ runOnAppear: Bool) -> Self {
        then({ $0.runOnAppear = runOnAppear })
    }

    public func validate(_ validateResult: @escaping (R.Result) -> Bool) -> Self {
        then({ $0.validateRequestResult = validateResult })
    }
}

extension RequestButton where R.Error == Never {
    public func validate(_ validateResult: @escaping (R.Response) -> Bool) -> Self {
        then({
            $0.validateRequestResult = { result in
                if case .success(let value) = result {
                    return validateResult(value)
                } else {
                    fatalError()
                }
            }
        })
    }

    public init(
        request: R,
        completion: @escaping (R.Response) -> (),
        @ViewBuilder label: @escaping (RequestButtonState) -> Label
    )  {
        self.request = request
        self.completion = { result in
            if case .success(let value) = result {
                completion(value)
            } else {
                fatalError()
            }
        }
        self.label = label
    }
}
