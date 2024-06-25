//
//  CommonRoute.swift
//  PushRouter
//
//  Created by 남유성 on 6/25/24.
//

import SwiftUI

enum CommonRoute: Routable {
    case root
    case common1
    case common2
    case common3
    
    var type: RouteType { .common }
    
    @ViewBuilder
    internal func NavigatingView() -> some View {
        switch self {
        case .root:
            CommonRootView()
        case .common1:
            CommonView1()
        case .common2:
            CommonView2()
        case .common3:
            CommonView3()
        }
    }
    
    var description: String {
        switch self {
        case .root:
            "CommonRoot"
        case .common1:
            "Common1"
        case .common2:
            "Common2"
        case .common3:
            "Common3"
        }
    }
}
