//
//  ProgressCircle.swift
//  MicroAuth
//
//  Created by Damon Falck on 10/03/2021.
//

import SwiftUI

struct ProgressCircle: View {
    
    // Between 0 and 1
    @ObservedObject var options: CircleOptions
    
    var body: some View {
        ZStack {
            Circle().stroke(Color.gray, lineWidth: 5.0).opacity(0.1)
            Circle().trim(from: 0, to: options.progress).stroke((options.monochrome ? Color.secondary : Color.accentColor), lineWidth: 5.0).rotationEffect(.degrees(-90))
        }.frame(width: 18, height: 18).padding(5.0)
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(options: CircleOptions(progress: CGFloat(0.7), monochrome: false))
    }
}

class CircleOptions: ObservableObject {
    @Published var progress: CGFloat
    @Published var monochrome: Bool
    
    init(progress: CGFloat, monochrome: Bool) {
        self.progress = progress
        self.monochrome = monochrome
    }
}
