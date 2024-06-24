//
//  LoginRoute.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

enum LoginRoute {
    case root
    case login1
    case login2
    case login3
    
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
        }
    }
}

extension LoginRoute: Routable {
    var type: RouteType { .login }
    var root: any Routable { LoginRoute.root }
    
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
        }
    }
}
