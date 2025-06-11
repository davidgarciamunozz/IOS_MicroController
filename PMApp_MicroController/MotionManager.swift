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
    
    @Published var impactScore: Int = 0
    @Published var impactDetected: Bool = false

    let gravity: Double = 9.81  // Valor de la gravedad en m/s²
    let impactThreshold: Double = 15.0  // Umbral mínimo para detectar un golpe fuerte

    init() {
        startMotionUpdates()
    }

    func startMotionUpdates() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 0.05
            motion.startAccelerometerUpdates()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if let accelerometerData = self.motion.accelerometerData {
                let ax = accelerometerData.acceleration.x * self.gravity
                let ay = accelerometerData.acceleration.y * self.gravity
                let az = accelerometerData.acceleration.z * self.gravity
                
                self.accX = ax
                self.accY = ay
                self.accZ = az
                
                let totalAcceleration = sqrt(ax * ax + ay * ay + az * az)
                
                if totalAcceleration > self.impactThreshold {
                    self.impactScore = self.calculateImpactScore(totalAcceleration)
                    self.impactDetected = true
                } else {
                    self.impactDetected = false
                }
            }
        }
    }

    private func calculateImpactScore(_ acceleration: Double) -> Int {
        let normalizedImpact = max(0, acceleration - impactThreshold) / 40.0
        return min(1000, Int(normalizedImpact * 1000))
    }
}
