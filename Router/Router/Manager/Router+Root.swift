//
//  Router+Root.swift
//  Router
//
//  Created by 남유성 on 6/25/24.
//

import SwiftUI

extension Router {
    enum Root: Routable {
        case root

        var type: RouteType { .appRoot }
        var description: String { "Root" }
        
        @ViewBuilder
        internal func NavigatingView() -> some View {
            CommonRootView()
        }
    }
}
