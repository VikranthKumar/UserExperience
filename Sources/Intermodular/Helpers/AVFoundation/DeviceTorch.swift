//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import AVFoundation
import SwiftUIX
import UIKit

open class DeviceTorch {
    open class var isActive: Bool {
        AVCaptureDevice.default(for: .video)?.isTorchActive ?? false
    }
    
    class func set(_ isEnabled: Bool) throws {
        if let device = AVCaptureDevice.default(for: .video), device.hasTorch {
            try device.lockForConfiguration()
            try device.setTorchModeOn(level: 1.0)
            
            device.torchMode = isEnabled ? .on : .off
            
            device.unlockForConfiguration()
        }
    }
    
    public final class func enable() throws {
        try set(true)
    }
    
    public final class func disable() throws {
        try set(false)
    }
    
    public final class func toggle() throws {
        if let device = AVCaptureDevice.default(for: .video), device.hasTorch {
            try device.lockForConfiguration()
            try device.setTorchModeOn(level: 1.0)
            
            device.torchMode = !device.isTorchActive ? .on : .off
            
            device.unlockForConfiguration()
        }
    }
}

#endif
