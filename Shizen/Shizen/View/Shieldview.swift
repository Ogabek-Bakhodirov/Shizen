//'//
////  ShieldView.swift
////  Focus AI
////
////  Created by Ogabek Bakhodirov on 27/01/25.
////
//import SwiftUI
//import UIKit
//import FamilyControls
//
//struct ShieldView: View {
//
//    var dismissAction: (() -> Void)?
//
//    @StateObject private var manager = ShieldManager()
//    @State private var showActivityPicker = false
//
//    var body: some View {
//        ZStack {
//            // Background color (dark mode style)
//            Color.white.edgesIgnoringSafeArea(.all)
//
//            VStack {
//                // Custom Back Button at the Top
//                HStack {
//                    Button(action: {
//                        dismissAction?() // Dismiss the view
//                    }) {
//                        HStack {
//                            Image(.backArrowIcon)
//                                .font(.system(size: 30))
//                                .foregroundColor(.white)
//                            Text("Orqaga") // Back text
//                                .foregroundColor(.black)
//                                .font(.system(size: 18, weight: .regular))
//                        }
//                    }
//                    .padding(.leading, 20)
//                    .padding(.top, 10)
//
//                    Spacer()
//                }
//
//                Spacer()
//
//                // Activity Configuration Button
//                Button {
//                    showActivityPicker = true
//                } label: {
//                    Label("Configure activities", systemImage: "gearshape")
//                }
//                .buttonStyle(.borderedProminent)
//                .padding()
//
//                // Apply Shielding Button
//                Button("Apply Shielding") {
//                    manager.shieldActivities()
//                    dismissAction?()
//                }
//                .buttonStyle(.bordered)
//
//                Spacer()
//            }
//            .familyActivityPicker(isPresented: $showActivityPicker, selection: $manager.discouragedSelections)
//        }
//    }
//}
//
//
//

