//
//  ContentView.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

struct PathBox: View {
    let description: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(description)
            Spacer()
        }
        .font(.body.bold())
        .padding(20)
        .frame(height: 160)
        .background(Color.yellow.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        Router.shared.Stack {
            VStack {
                PathBox(description: Router.shared.description)
                
                Spacer()
                
                Button("CommonFlow") {
                    Router.shared.push(to: CommonRoute.root)
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button("LoginFlow") {
                    Router.shared.push(to: LoginRoute.root)
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button("Sheet") {
                    Router.shared.sheet(to: LoginRoute.sheet) {
                        print(11)
                    }
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .navigationTitle("Router")
            .padding(.bottom, 300)
        }
    }
}

#Preview {
    ContentView()
}

struct CommonRootView: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("toCommon1") {
                Router.shared.push(to: CommonRoute.common1)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Sheet") {
                Router.shared.sheet(to: LoginRoute.sheet)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct CommonView1: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("toCommon2") {
                Router.shared.push(to: CommonRoute.common2)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct CommonView2: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("toCommon2") {
                Router.shared.push(to: CommonRoute.common3)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct CommonView3: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("showLoginFlow") {
                Router.shared.push(to: LoginRoute.root)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("endFlow") {
                Router.shared.endRoute(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("popToCommonRoot") {
                Router.shared.popToRoot(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct LoginRootView: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("toLogin1") {
                Router.shared.push(to: LoginRoute.login1)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct LoginView1: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("toLogin2") {
                Router.shared.push(to: LoginRoute.login2)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct LoginView2: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("toLogin3") {
                Router.shared.push(to: LoginRoute.login3)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct LoginView3: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("endFlow") {
                Router.shared.endRoute(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("popToLoginRoot") {
                Router.shared.popToRoot(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}

struct LoginSheet: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.description)
            
            Spacer()
            
            Button("Sheet") {
                Router.shared.sheet(to: LoginRoute.sheet)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("FullCover") {
                Router.shared.fullScreenCover(to: LoginRoute.sheet)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Dismiss") {
                Router.shared.dismiss()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
    }
}
