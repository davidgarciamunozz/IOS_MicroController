//
//  MotionView.swift
//  PMApp_MicroController
//
//  Created by David García on 26/02/25.
//

import SwiftUI
import CoreMotion

struct MotionView: View {
    @StateObject private var motionManager = MotionManager()

    var body: some View {
        VStack {
            Text("Acelerómetro")
                .font(.title)
            Text("X: \(motionManager.accX, specifier: "%.2f")")
            Text("Y: \(motionManager.accY, specifier: "%.2f")")
            Text("Z: \(motionManager.accZ, specifier: "%.2f")")

            Divider()
            
            Text("Giroscopio")
                .font(.title)
            Text("X: \(motionManager.gyroX, specifier: "%.2f")")
            Text("Y: \(motionManager.gyroY, specifier: "%.2f")")
            Text("Z: \(motionManager.gyroZ, specifier: "%.2f")")
        }
        .padding()
    }
}
