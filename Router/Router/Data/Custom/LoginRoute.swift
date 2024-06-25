//
//  LoginRoute.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

enum LoginRoute: Routable {
    case root
    case login1
    case login2
    case login3
    case loginSheet
    
    var type: RouteType { .login }
    
    @ViewBuilder
    internal func NavigatingView() -> some View {
        switch self {
        case .root:
            LoginRootView()
        case .login1:
            LoginView1()
        case .login2:
            LoginView2()
        case .login3:
            LoginView3()
        case .loginSheet:
            LoginSheet()
        }
    }
    
    var description: String {
        switch self {
        case .root:
            "LoginRoot"
        case .login1:
            "login1"
        case .login2:
            "login2"
        case .login3:
            "login3"
        case .loginSheet:
            "loginSheet"
        }
    }
}
