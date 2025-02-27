//
//  MotionManager.swift
//  PMApp_MicroController
//
//  Created by David García on 26/02/25.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    private var timer = Timer()

    @Published var accX: Double = 0.0
    @Published var accY: Double = 0.0
    @Published var accZ: Double = 0.0
    
    @Published var gyroX: Double = 0.0
    @Published var gyroY: Double = 0.0
    @Published var gyroZ: Double = 0.0

    init() {
        startMotionUpdates()
    }

    func startMotionUpdates() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 0.1
            motion.startAccelerometerUpdates()
        }
        
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = 0.1
            motion.startGyroUpdates()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let accelerometerData = self.motion.accelerometerData {
                self.accX = accelerometerData.acceleration.x
                self.accY = accelerometerData.acceleration.y
                self.accZ = accelerometerData.acceleration.z
            }
            
            if let gyroData = self.motion.gyroData {
                self.gyroX = gyroData.rotationRate.x
                self.gyroY = gyroData.rotationRate.y
                self.gyroZ = gyroData.rotationRate.z
            }
        }
    }
}
