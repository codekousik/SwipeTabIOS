//
//  ContentView.swift
//  swipeTab
//
//  Created by Kousik Das on 10/02/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Home()
    }
}

struct Home: View{
    
    @State var index = 1
    @State var offset: CGFloat = UIScreen.main.bounds.width
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0){
            AppBar(index: self.$index, offset: self.$offset)
            GeometryReader{g in
                HStack(spacing: 0){
                    First()
                        .frame(width: g.frame(in : .global).width)
                    Second()
                        .frame(width: g.frame(in : .global).width)
                    Third()
                        .frame(width: g.frame(in : .global).width)
                }
                .offset(x: self.offset)
                .highPriorityGesture(DragGesture()
                    .onEnded({(value) in
                        if value.translation.width > 50 {
                            print("right")
                            self.changeView(left: false)
                        }
                        if -value.translation.width > 50 {
                            print("left")
                            self.changeView(left: true)
                        }
                    })
                )
            }
        }
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
    
    func changeView(left: Bool){
        if left {
            if self.index != 3 {
                self.index += 1
            }
        }else{
            if self.index != 0 {
                self.index -= 1
            }
        }
        if self.index == 1{
            self.offset = self.width
        }else if self.index == 2{
            self.offset = 0
        }else{
            self.offset = -self.width
        }
    }
}

struct AppBar: View{
    
    @Binding var index: Int
    @Binding var offset: CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Home")
                .font(.title)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.bottom)
            HStack {
                Button(action: {
                    self.index = 1
                    self.offset = self.width
                }){
                    VStack(spacing: 8){
                        HStack(spacing: 12){
                            Text("Tab 1")
                                .foregroundColor(self.index == 1 ? Color.blue : Color.white.opacity(0.7))
                        }
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button(action: {
                    self.index = 2
                    self.offset = 0
                }){
                    VStack(spacing: 8){
                        HStack(spacing: 12){
                            Text("Tab 2")
                                .foregroundColor(self.index == 2 ? Color.blue : Color.white.opacity(0.7))
                        }
                        
                        Capsule()
                            .fill(self.index == 2 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button(action: {
                    self.index = 3
                    self.offset = -self.width
                }){
                    VStack(spacing: 8){
                        HStack(spacing: 12){
                            Text("Tab 3")
                                .foregroundColor(self.index == 3 ? Color.blue : Color.white.opacity(0.7))
                        }
                        
                        Capsule()
                            .fill(self.index == 3 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
            }
        })
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.red)
    }
}

struct First: View {
    
    var body: some View {
        GeometryReader{_ in
            VStack{
                Text("First View")
            }
        }
        .background(Color.yellow)
    }
}

struct Second: View {
    
    var body: some View {
        GeometryReader{_ in
            VStack{
                Text("Second View")
            }
        }
        .background(Color.blue)
    }
}

struct Third: View {
    
    var body: some View {
        GeometryReader{_ in
            VStack{
                Text("Third View")
            }
        }
        .background(Color.brown)
    }
}
