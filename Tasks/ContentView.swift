//
//  ContentView.swift
//  Tasks
//
//  Created by siddhatech on 29/07/24.
//

import SwiftUI

struct Account: Identifiable{
    let id = UUID()
    let type: String
    let balance: String
    let date: Date
}

struct ContentView: View {
    let size = UIScreen.main.bounds
    
    @State private var activeButton = "activos"
      
      let accounts = [
          Account(type: "activos", balance: "RD$1,000.00", date: Date()),
          Account(type: "activos", balance: "RD$2,000.00", date: Date()),
          Account(type: "activos", balance: "RD$3,000.00", date: Date()),
          Account(type: "activos", balance: "RD$4,000.00", date: Date()),
          Account(type: "Utilizados", balance: "RD$500.00", date: Date()),
          Account(type: "cerrados", balance: "RD$2,000.00", date: Date()),
          Account(type: "activos", balance: "RD$3,000.00", date: Date())
      ]
    
    var filteredAccounts: [Account] {
        accounts.filter { $0.type == activeButton }
    }
    
    var body: some View {
      
                VStack {
                    TopView(activeButton: $activeButton)
                        .padding()
                        .frame(maxWidth: .infinity ,maxHeight: size.height * 0.34)
                        .padding(.bottom)
                        .background(.white)
                        
                        
                    Spacer()
                    ScrollView{
                        ForEach(filteredAccounts ){ account in
                            MiddleView(account : account)
                                .padding(.horizontal)
                                .padding(.top ,6)
                        }
                    }
                    BottomNavigationBarView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background( BackgroundView(Offset: 0.4, topColor: .backgroundc, bottomColor:.backgroundc, topHeight: 0.4, bottomHeight: 0.6))
    }
}

struct TopView: View {
    let size = UIScreen.main.bounds
    @Binding  var activeButton :String
    var body: some View {
        
            VStack {
                HStack {
                    Spacer()
                    Text("código cash")
                        .font(.system(size:size.size.width * 0.05, weight: .bold))
                        .foregroundColor(.textC)
                        .padding(.leading, 30)
                    Spacer()
                    Image("mark")
                        .font(.system(size: size.width * 0.05))
                }
                Text("¿Para qué sirve el código de retiro?")
                    .font(.system(size: size.width * 0.04, weight: .bold))
                    .foregroundColor(.textC)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                

                
                HStack(spacing: size.width * 0.08) {
                    PersonView(imageN: "person", text: "para mi")
                        .frame(minWidth:size.width * 0.4,minHeight: size.height * 0.15)
                        .background(BackgroundView(Offset: 0.6, topColor: Color(red: 0.86, green: 0.96, blue: 0.99), bottomColor: .white, topHeight:0.6 , bottomHeight:0.5 ))
                        .cornerRadius(20) .shadow(color: Color.gray.opacity(0.2), radius: 3)
                    
                    PersonView(imageN: "person.2", text: "para otra persona")
                        .frame(minWidth:size.width * 0.4,minHeight:size.height * 0.15)
                        .background(BackgroundView(Offset: 0.6, topColor: Color(red: 0.86, green: 0.96, blue: 0.99), bottomColor:.white, topHeight:0.6 , bottomHeight:0.5 ))
                        .cornerRadius(20).shadow(color: Color.gray.opacity(0.2), radius: 5)
                }
                
               let spacing = size.width / 6
                HStack(spacing: spacing) {
                    Button(action: {
                        activeButton = "activos"
                    }) {
                        customizeButtonView(text: "activos", isActive: activeButton == "activos")
                    }
                    Button(action: {
                        activeButton = "Utilizados"
                    }) {
                        customizeButtonView(text: "Utilizados", isActive: activeButton == "Utilizados")
                    }
                    Button(action: {
                        activeButton = "cerrados"
                    }) {
                        customizeButtonView(text: "cerrados", isActive: activeButton == "cerrados")
                    }
                }.padding(.top, size.width * 0.04)

            
        }
    }
}



struct PersonView: View {
    var imageN: String = ""
    var text: String = ""
    let size = UIScreen.main.bounds
    var body: some View {
        VStack {
    
            Image(systemName: "\(imageN)")
                .font(.system(size: size.width * 0.04))
                .offset(y:size.width * 0.017)
            Text("\(text)")
                .font(.system(size: size.width * 0.035, weight: .regular))
                .padding(.top,50)
        }
    
        
    }
}


struct customizeButtonView : View {
    var text: String
    let size = UIScreen.main.bounds
       var isActive: Bool

       var body: some View {
           VStack {
               Text(text)
                   .foregroundColor(isActive ? .test :.black)
                   .fontWeight(isActive ? .bold : .regular)
                   .font(.system(size: size.width * 0.03))
               
               if isActive {
                   Circle()
                       .fill(Color.test)
                       .frame(width: 5, height: 5)
                       .padding(.top, -10)
               }
           }
       }
}



struct MiddleView :View {
    var account : Account
   
    let size = UIScreen.main.bounds
    var body: some View {
        
            HStack {
                    VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("monto:")
                                    .font(.system(size: size.width * 0.045,weight: .bold))
                                Text(account.balance)
                                    .font(.system(size: size.width * 0.035))
                            }
                            HStack {
                                Text("fecha:")
                                    .font(.system(size: size.width * 0.045,weight: .bold))
                                Text("  \(account.date.formatted(date: .long, time: .shortened).lowercased())")
                                    .font(.system(size: size.width * 0.035))
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                
                    .foregroundColor(Color.test)
                    .font(.system(size: size.width * 0.045,weight: .medium))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}


struct BackgroundView: View {
    var Offset : Double
    var topColor :Color
    var bottomColor :Color
    var topHeight : Double
    var bottomHeight : Double
    let size = UIScreen.main.bounds
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [topColor]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: geometry.size.width, height: geometry.size.height * topHeight)
                
                LinearGradient(
                    gradient: Gradient(colors: [bottomColor]),
                    startPoint: .center,
                    endPoint: .bottom
                )
                .frame(width: geometry.size.width, height: geometry.size.height * bottomHeight)
                .offset(y: geometry.size.height * Offset)
                
            }
        }
    }
}


struct BottomNavigationBarView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: geometry.size.width / 6) {
                BottomNavBarItem(iconName: "house", text: "inicio")
                BottomNavBarItem(iconName: "arrow.left.arrow.right", text: "transferencias").offset(x:15)
                BottomNavBarItem(iconName: "arrow.right.circle", text: "código cash")
            }
            .padding()
            .frame(width: geometry.size.width, height: 150)
            .background(Color.test)
            .cornerRadius(20)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.4 )
            
        }
        .frame(height: 45)
        
    }
}

struct BottomNavBarItem: View {
    var iconName: String
    var text: String
    let size = UIScreen.main.bounds
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: size.width * 0.04 ))
                .foregroundColor(.white)
            Text(text)
                .font(.system(size: size.width * 0.04))
                .foregroundColor(.white)
        }
        .padding(.bottom,30)
    }
}


#Preview {
    ContentView()
}
