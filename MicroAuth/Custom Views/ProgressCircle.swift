//
//  ProgressCircle.swift
//  MicroAuth
//
//  Created by Damon Falck on 10/03/2021.
//

import SwiftUI

struct ProgressCircle: View {
    
    // Between 0 and 1
    @ObservedObject var progress: Progress
    
    var body: some View {
        ZStack {
            Circle().stroke(Color.gray, lineWidth: 5.0).opacity(0.1)
            Circle().trim(from: 0, to: progress.value).stroke(Color.accentColor, lineWidth: 5.0).rotationEffect(.degrees(-90))
        }.frame(width: 18, height: 18).padding(5.0)
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(progress: Progress(value: CGFloat(0.7)))
    }
}

class Progress: ObservableObject {
    @Published var value: CGFloat
    
    init(value: CGFloat) {
        self.value = value
    }
}
