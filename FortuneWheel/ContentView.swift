//
//  FortuneWheelView.swift
//  Merge It
//
//  Created by Erdem Senol on 15.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State var rotate = false
    private var timeCurveAnimation: Animation {
        return Animation.timingCurve(0, 0.55, 0.45, 1, duration: 6)
    }
    
    @State var randInt = 0
    @State var showResult = false
    @State var startOffset: CGFloat = 1000

    
    var body: some View {
        VStack {
            
            
            ZStack{
                ZStack{
                    Circle()
                        .stroke(
                            Color.red,
                            lineWidth: 40)
                        .frame(width: 300, height: 300)
                        .shadow(color: Color.red, radius: 10, x: 0.0, y: 0.0)
                    
                        
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color("blueLight")]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/),
                                lineWidth: 20)
                            .frame(width: 280, height: 280)
                            .shadow(color: Color("blueLight"), radius: 10, x: 0.0, y: 0.0)
                        ForEach(0..<8){
                            Circle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color("purple"), Color("purpleLight")]), startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(width: 20, height: 20)
                                .offset(y: -150)
                                .rotationEffect(.degrees(Double($0) * 45))
                        }
                        Image("heel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260, height: 260)
                        ForEach(0 ..< 8) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 4, height: 140)
                                .rotationEffect(Angle(degrees: Double($0) * 45), anchor: UnitPoint.bottom)
                                .offset(y: -70)
                        }
                        
                        Circle()
                            .fill(Color.white.opacity(0.5))
                            .frame(width: 70, height: 70)
                            .shadow(color: .red, radius: 10, x: 0.0, y: 0.0)
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color("redLight")]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 50, height: 50)

                        
                        
                    }.rotationEffect(Angle(degrees: rotate ? Double(randInt) : 0))
                    .animation(rotate ? timeCurveAnimation : Animation.interpolatingSpring(stiffness: 40, damping: 5))
                    Triangle()
                        .fill(
                            Color("purple")
                        )
                        .frame(width: 40, height: 60)
                        .rotationEffect(.degrees(180))
                        .offset(y: -160)
                }.blur(radius: showResult ? 3 : 0)
//                Image("star")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 42, height: 42)
//                    .rotationEffect(.degrees(36))
//                    .offset(y: -160)
                
                Text("\(getAwardName(number: randInt))")
                    .foregroundColor(.black)
                    .font(.system(size: 34, weight: .heavy, design: .monospaced))
                    .padding()
                    .frame(width: 300, height: 300)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(20)
                    .opacity(showResult ? 1 : 0)
                    .animation(.none)
                    .scaleEffect(showResult ? 1 : 0)
                    .animation(Animation.interpolatingSpring(stiffness: 40, damping: 5))
                    .onTapGesture {
                        showResult = false
                    }
                
            }
            
            
            Button(action: {
                randInt = Int.random(in: 1000..<1800)
                rotate.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    showResult = true
                }
            }, label: {
                Text("TURN")
                    .foregroundColor(.red)
                    .font(.headline)
                    .bold()
                    .padding()
                    .frame(width: 100, height: 50)
                    .background(Color("blueLight"))
                    .cornerRadius(12)
                    .shadow(color: .purple.opacity(0.34), radius: 10, x: 0.0, y: 0.0)
            }).padding(.top, 50)
            .disabled(rotate ? true : false)
            
//            Button(action: {
//                rotate = false
//                randInt = 0
//            }, label: {
//                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//            })
            
           
        }.offset(y: startOffset)
        .onAppear{
            withAnimation(Animation.interpolatingSpring(stiffness: 40, damping: 5)){
                startOffset = 0
            }
        }
    }
    
    func getAwardName(number: Int) -> String{
        switch (number % 360)/45 {
        case 1:
            return "darkGreen"
        case 2:
            return "lightGreen"
        case 3:
            return "yellow"
        case 4:
            return "bok"
        case 5:
            return "orange"
        case 6:
            return "red"
        case 7:
            return "purple"
        case 0:
            return "blue"
        default:
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))

        return path
    }
}

