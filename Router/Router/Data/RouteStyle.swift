//
//  RouteStyle.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

public enum RouteStyle {
    case push
    
    case sheet(
        _ detents: Set<PresentationDetent> = [.large],
        _ indicatorVisibility: Visibility = .hidden
    )
    
    case cover
    
    var description: String {
        switch self {
        case .push:
            "push"
        case .sheet:
            "sheet"
        case .cover:
            "cover"
        }
    }
}
