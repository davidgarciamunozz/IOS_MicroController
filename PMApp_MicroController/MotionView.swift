//
//  MotionView.swift
//  PMApp_MicroController
//
//  Created by David García on 26/02/25.
//

import SwiftUI

struct MotionView: View {
    @StateObject private var motionManager = MotionManager()
    @State private var showImpact = false

    var body: some View {
        VStack {
            Text("Acelerómetro")
                .font(.title)
            Text("X: \(motionManager.accX, specifier: "%.2f")")
            Text("Y: \(motionManager.accY, specifier: "%.2f")")
            Text("Z: \(motionManager.accZ, specifier: "%.2f")")

            Divider()

            if showImpact {
                VStack {
                    Text("⚠️ Golpe Detectado ⚠️")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    Text("Puntaje: \(motionManager.impactScore)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)

                    if motionManager.impactScore > 800 {
                        Text("¡GOLPE MUY FUERTE! 🚨")
                            .foregroundColor(.red)
                            .bold()
                    } else if motionManager.impactScore > 500 {
                        Text("Golpe Moderado ⚠️")
                            .foregroundColor(.orange)
                            .bold()
                    } else {
                        Text("Golpe Leve 🟢")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
                .transition(.scale)
            }
        }
        .padding()
        .onChange(of: motionManager.impactDetected) { newValue in
            if newValue {
                showImpact = true
                
                // Oculta el mensaje después de 3 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showImpact = false
                }
            }
        }
    }
}
