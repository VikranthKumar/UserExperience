//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import AVFoundation
import SwiftUIX
import UIKit

/// A view capable of scanning `AVMetadataObject` object types.
public struct CodeScannerView: UIViewControllerRepresentable, SetModelView {
    public typealias Model = Result<String, ScanError>
    
    @Binding public var result: Model
    
    private var codeTypes: [AVMetadataObject.ObjectType] = []
    
    @Environment(\.isEnabled) var isEnabled
    
    public init(_ result: SetBinding<Model>) {
        self._result = .init(set: result, defaultValue: .failure(.badOutput))
    }
    
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        
        viewController.delegate = context.coordinator
        
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if uiViewController.captureSession.isRunning != isEnabled {
            DispatchQueue.global(qos: .userInteractive).async {
                self.isEnabled
                    ? uiViewController.captureSession.startRunning()
                    : uiViewController.captureSession.stopRunning()
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return .init(parent: self)
    }
}

extension CodeScannerView {
    public class UIViewControllerType: UIViewController {
        var captureSession: AVCaptureSession!
        var previewLayer: AVCaptureVideoPreviewLayer!
        var delegate: Coordinator?
        
        override public var prefersStatusBarHidden: Bool {
            return true
        }
        
        override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
        
        override public func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor.black
            
            captureSession = AVCaptureSession()
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            
            if (captureSession.canAddInput(videoInput)) {
                captureSession.addInput(videoInput)
            } else {
                delegate?.didFail(reason: .badInput)
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (captureSession.canAddOutput(metadataOutput)) {
                captureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = delegate?.parent.codeTypes
            } else {
                delegate?.didFail(reason: .badOutput)
                return
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            
            view.layer.addSublayer(previewLayer)
        }
        
        override public func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            DispatchQueue.global(qos: .userInteractive).async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    public enum ScanError: Error {
        case badInput, badOutput
    }
}

extension CodeScannerView {
    public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CodeScannerView
        
        init(parent: CodeScannerView) {
            self.parent = parent
        }
        
        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                found(code: stringValue)
            }
        }
        
        func found(code: String) {
            parent.result = .success(code)
        }
        
        func didFail(reason: ScanError) {
            parent.result = .failure(reason)
        }
    }
}

extension CodeScannerView {
    public func codeTypes(_ types: [AVMetadataObject.ObjectType]) -> Self {
        then {
            $0.codeTypes = types
        }
    }
}

#endif
