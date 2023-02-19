//
//  WaterLevelView.swift
//  sampleESP
//
//  Created by Никита on 19.02.2023.
//
import SwiftUI
//
//struct WaterLevelView: View {
//    
//    @Binding private var percent: Int
//    
//    var body: some View {
//        VStack {
//            CircleWaveView(percent: Int(self.percent))
//            Slider(value: self.$percent, in: 0...100, step: 1.0)
//        }
//        .padding(.all)
//    }
//}
//
//struct Wave: Shape {
//
//    var offset: Angle
//    var percent: Double
//    
//    var animatableData: Double {
//        get { offset.degrees }
//        set { offset = Angle(degrees: newValue) }
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//
//        // empirically determined values for wave to be seen
//        // at 0 and 100 percent
//        let lowfudge = 0.02
//        let highfudge = 0.98
//        
//        let newpercent = lowfudge + (highfudge - lowfudge) * percent
//        let waveHeight = 0.015 * rect.height
//        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
//        let startAngle = offset
//        let endAngle = offset + Angle(degrees: 360)
//        
//        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
//        
//        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
//            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
//            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
//        }
//        
//        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
//        p.addLine(to: CGPoint(x: 0, y: rect.height))
//        p.closeSubpath()
//        
//        return p
//    }
//}
//
//struct CircleWaveView: View {
//    
//    @State private var waveOffset = Angle(degrees: 0)
//    
//    let percent: Int
//    
//    var body: some View {
//
//        GeometryReader { geo in
//            ZStack {
//                Text("\(self.percent)%")
//                    .foregroundColor(.black)
//                    .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) ))
//                Circle()
//                    .overlay(
//                        Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
//                            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
//                            .clipShape(Circle().scale(0.92))
//                    )
//            }
//        }
//        .aspectRatio(1, contentMode: .fit)
//        .onAppear {
//            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
//            self.waveOffset = Angle(degrees: 360)
//            }
//        }
//    }
//}
//
