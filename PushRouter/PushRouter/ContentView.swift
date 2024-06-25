//
//  ContentView.swift
//  PushRouter
//
//  Created by 남유성 on 6/25/24.
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
                PathBox(description: Router.shared.stackDescription)
                
                Spacer()
                
                Button("Push Common Root") {
                    Router.shared.push(to: CommonRoute.root)
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button("Push Login Root") {
                    Router.shared.push(to: LoginRoute.root)
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .padding(.bottom, 300)
            .navigationTitle("Router")
        }
    }
}

#Preview {
    ContentView()
}

struct CommonRootView: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Common1") {
                Router.shared.push(to: CommonRoute.common1)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Common") {
                Router.shared.endRoute(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommonView1: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Common2") {
                Router.shared.push(to: CommonRoute.common2)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Common") {
                Router.shared.endRoute(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Common Root") {
                Router.shared.popToRoot(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommonView2: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Common3") {
                Router.shared.push(to: CommonRoute.common3)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Common") {
                Router.shared.endRoute(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Common Root") {
                Router.shared.popToRoot(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommonView3: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Login Root") {
                Router.shared.push(to: LoginRoute.root)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Common") {
                Router.shared.endRoute(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Common Root") {
                Router.shared.popToRoot(of: .common)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginRootView: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Login1") {
                Router.shared.push(to: LoginRoute.login1)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Login") {
                Router.shared.endRoute(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView1: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Login2") {
                Router.shared.push(to: LoginRoute.login2)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Login") {
                Router.shared.endRoute(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Login Root") {
                Router.shared.popToRoot(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView2: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Push Login3") {
                Router.shared.push(to: LoginRoute.login3)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop All Login") {
                Router.shared.endRoute(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Login Root") {
                Router.shared.popToRoot(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView3: View {
    var body: some View {
        VStack {
            PathBox(description: Router.shared.stackDescription)
            
            Spacer()
            
            Button("Pop All Login") {
                Router.shared.endRoute(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Login Root") {
                Router.shared.popToRoot(of: .login)
            }
            .buttonStyle(BorderedButtonStyle())
            
            Button("Pop to Root") {
                Router.shared.popToRoot()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding(.bottom, 300)
        .navigationTitle(Router.shared.curRouteDescription)
        .navigationBarTitleDisplayMode(.inline)
    }
}
