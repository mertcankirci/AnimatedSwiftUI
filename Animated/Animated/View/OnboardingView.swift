//
//  OnboardingView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 17.07.2023.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    
    let button = RiveViewModel(fileName: "button")
    @State var showModal = false
    @Binding var show: Bool
    
    var body: some View {
        
        ZStack {
            background
            
            content
                .offset(y: showModal ? -50: 0)
            
            Color("Shadow")
                .opacity(showModal ? 0.3 : 0.0)
                .ignoresSafeArea()
            
            if showModal {
                SignInView(showModel: $showModal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        
                        Button {
                            withAnimation(.spring()) {
                                showModal = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.black)
                                .background(.white)
                                .mask(Circle())
                                .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    )
                    .zIndex(1)
            }
            
            Button {
                withAnimation {
                    show = false
                }
                
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 36, height: 36)
                    .background(.black)
                    .foregroundColor(.white)
                    .mask(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .padding(.trailing, 20)
            .offset(y: showModal ? -200 : 80)
            
            
        }
    }
    
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
            )
    }
    
    var content : some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Learn design & code")
                .font(.custom("Poppins Bold", size: 60, relativeTo: .largeTitle))
                .frame(width: 260, alignment: .leading)
            
            Text("Don't skip design. Learn design and code, by building real apps with React and Swift. Complete courses about best tools")
                .customFont(.body)
                .opacity(0.7)
                .frame(width: 366)
                
            Spacer()
            
            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                    Label("Start the course", systemImage: "arrow.forward")
                        .offset(x:4 , y:4)
                        .font(.headline)
                )
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset(y: 10)
                )
                .onTapGesture {
                    button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showModal = true
                        }
                    }
            }
            
            Text("Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificate")
                .customFont(.footnote)
                .opacity(0.7)
                .frame(width: 366)
            
        }
        .padding(40)
        .padding(.top, 40)
    }
    
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true))
    }
}
